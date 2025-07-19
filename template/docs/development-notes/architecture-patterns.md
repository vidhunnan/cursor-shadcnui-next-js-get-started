# 🏗️ Architecture Patterns

Design patterns and best practices for Next.js projects with shadcn/ui.

## 📁 Component Organization

### **Directory Structure**
```
components/
├── ui/                    # shadcn/ui components
│   ├── button.tsx
│   ├── card.tsx
│   └── badge.tsx
├── custom/                # Custom business components
│   ├── welcome-card.tsx
│   ├── user-profile.tsx
│   └── dashboard-widget.tsx
└── layout/                # Layout components
    ├── header.tsx
    ├── sidebar.tsx
    └── footer.tsx
```

### **Naming Conventions**
- **Components**: PascalCase (e.g., `WelcomeCard.tsx`)
- **Utilities**: camelCase (e.g., `utils.ts`)
- **Pages**: kebab-case (e.g., `user-profile.tsx`)
- **Constants**: UPPER_SNAKE_CASE (e.g., `API_ENDPOINTS.ts`)

## 🎯 Component Patterns

### **shadcn/ui Component Extension**
```typescript
// components/ui/custom-button.tsx
import { Button, ButtonProps } from "@/components/ui/button"
import { cn } from "@/lib/utils"

interface CustomButtonProps extends ButtonProps {
  icon?: React.ReactNode
  loading?: boolean
}

export function CustomButton({ 
  icon, 
  loading, 
  children, 
  className, 
  ...props 
}: CustomButtonProps) {
  return (
    <Button 
      className={cn("flex items-center gap-2", className)} 
      disabled={loading}
      {...props}
    >
      {loading && <Spinner className="w-4 h-4" />}
      {icon && !loading && icon}
      {children}
    </Button>
  )
}
```

### **Component with Variants**
```typescript
// components/ui/status-badge.tsx
import { Badge } from "@/components/ui/badge"
import { cva, type VariantProps } from "class-variance-authority"
import { cn } from "@/lib/utils"

const statusVariants = cva(
  "inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-semibold",
  {
    variants: {
      status: {
        success: "bg-green-100 text-green-800",
        warning: "bg-yellow-100 text-yellow-800",
        error: "bg-red-100 text-red-800",
        info: "bg-blue-100 text-blue-800",
      },
    },
    defaultVariants: {
      status: "info",
    },
  }
)

interface StatusBadgeProps extends VariantProps<typeof statusVariants> {
  children: React.ReactNode
  className?: string
}

export function StatusBadge({ status, children, className }: StatusBadgeProps) {
  return (
    <Badge className={cn(statusVariants({ status }), className)}>
      {children}
    </Badge>
  )
}
```

## 🔄 State Management

### **Local State with React Hooks**
```typescript
// hooks/use-local-storage.ts
import { useState, useEffect } from 'react'

export function useLocalStorage<T>(key: string, initialValue: T) {
  const [storedValue, setStoredValue] = useState<T>(() => {
    if (typeof window === "undefined") {
      return initialValue
    }
    try {
      const item = window.localStorage.getItem(key)
      return item ? JSON.parse(item) : initialValue
    } catch (error) {
      console.log(error)
      return initialValue
    }
  })

  const setValue = (value: T | ((val: T) => T)) => {
    try {
      const valueToStore = value instanceof Function ? value(storedValue) : value
      setStoredValue(valueToStore)
      if (typeof window !== "undefined") {
        window.localStorage.setItem(key, JSON.stringify(valueToStore))
      }
    } catch (error) {
      console.log(error)
    }
  }

  return [storedValue, setValue] as const
}
```

### **Context for Global State**
```typescript
// contexts/theme-context.tsx
import { createContext, useContext, useState, ReactNode } from 'react'

interface ThemeContextType {
  theme: 'light' | 'dark'
  toggleTheme: () => void
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined)

export function ThemeProvider({ children }: { children: ReactNode }) {
  const [theme, setTheme] = useState<'light' | 'dark'>('light')

  const toggleTheme = () => {
    setTheme(prev => prev === 'light' ? 'dark' : 'light')
  }

  return (
    <ThemeContext.Provider value={{ theme, toggleTheme }}>
      {children}
    </ThemeContext.Provider>
  )
}

export function useTheme() {
  const context = useContext(ThemeContext)
  if (context === undefined) {
    throw new Error('useTheme must be used within a ThemeProvider')
  }
  return context
}
```

## 🌐 API Patterns

### **API Route Handler**
```typescript
// app/api/users/route.ts
import { NextRequest, NextResponse } from 'next/server'

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const page = searchParams.get('page') || '1'
    const limit = searchParams.get('limit') || '10'

    // Your API logic here
    const users = await fetchUsers({ page: parseInt(page), limit: parseInt(limit) })

    return NextResponse.json({ users, page, limit })
  } catch (error) {
    return NextResponse.json(
      { error: 'Failed to fetch users' },
      { status: 500 }
    )
  }
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    
    // Validate input
    if (!body.name || !body.email) {
      return NextResponse.json(
        { error: 'Name and email are required' },
        { status: 400 }
      )
    }

    // Your API logic here
    const user = await createUser(body)

    return NextResponse.json(user, { status: 201 })
  } catch (error) {
    return NextResponse.json(
      { error: 'Failed to create user' },
      { status: 500 }
    )
  }
}
```

### **API Client Hook**
```typescript
// hooks/use-api.ts
import { useState, useEffect } from 'react'

interface UseApiOptions<T> {
  url: string
  method?: 'GET' | 'POST' | 'PUT' | 'DELETE'
  body?: any
  headers?: Record<string, string>
}

interface UseApiResult<T> {
  data: T | null
  loading: boolean
  error: string | null
  refetch: () => void
}

export function useApi<T>({ url, method = 'GET', body, headers }: UseApiOptions<T>): UseApiResult<T> {
  const [data, setData] = useState<T | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)

  const fetchData = async () => {
    try {
      setLoading(true)
      setError(null)

      const response = await fetch(url, {
        method,
        headers: {
          'Content-Type': 'application/json',
          ...headers,
        },
        body: body ? JSON.stringify(body) : undefined,
      })

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`)
      }

      const result = await response.json()
      setData(result)
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred')
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    fetchData()
  }, [url, method])

  return { data, loading, error, refetch: fetchData }
}
```

## 🧪 Testing Patterns

### **Component Testing**
```typescript
// __tests__/components/welcome-card.test.tsx
import { render, screen } from '@testing-library/react'
import { WelcomeCard } from '@/components/custom/welcome-card'

describe('WelcomeCard', () => {
  it('renders welcome message', () => {
    render(<WelcomeCard />)
    
    expect(screen.getByText('Welcome to Your Cursor Project')).toBeInTheDocument()
    expect(screen.getByText('Get Started')).toBeInTheDocument()
  })

  it('displays version badge', () => {
    render(<WelcomeCard />)
    
    expect(screen.getByText('v1.0.0')).toBeInTheDocument()
  })
})
```

### **API Route Testing**
```typescript
// __tests__/api/users.test.ts
import { GET, POST } from '@/app/api/users/route'
import { NextRequest } from 'next/server'

describe('/api/users', () => {
  it('GET returns users list', async () => {
    const request = new NextRequest('http://localhost:3000/api/users?page=1&limit=10')
    const response = await GET(request)
    const data = await response.json()

    expect(response.status).toBe(200)
    expect(data).toHaveProperty('users')
    expect(data).toHaveProperty('page')
  })

  it('POST creates new user', async () => {
    const request = new NextRequest('http://localhost:3000/api/users', {
      method: 'POST',
      body: JSON.stringify({ name: 'John Doe', email: 'john@example.com' }),
    })
    
    const response = await POST(request)
    const data = await response.json()

    expect(response.status).toBe(201)
    expect(data).toHaveProperty('name', 'John Doe')
  })
})
```

## 🔒 Security Patterns

### **Input Validation**
```typescript
// lib/validation.ts
import { z } from 'zod'

export const userSchema = z.object({
  name: z.string().min(2).max(50),
  email: z.string().email(),
  age: z.number().min(18).max(120).optional(),
})

export type User = z.infer<typeof userSchema>

export function validateUser(data: unknown): User {
  return userSchema.parse(data)
}
```

### **Authentication Middleware**
```typescript
// middleware.ts
import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'

export function middleware(request: NextRequest) {
  const token = request.cookies.get('auth-token')

  // Protect API routes
  if (request.nextUrl.pathname.startsWith('/api/protected')) {
    if (!token) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      )
    }
  }

  // Protect pages
  if (request.nextUrl.pathname.startsWith('/dashboard')) {
    if (!token) {
      return NextResponse.redirect(new URL('/login', request.url))
    }
  }

  return NextResponse.next()
}

export const config = {
  matcher: ['/api/protected/:path*', '/dashboard/:path*'],
}
```

## 📱 Performance Patterns

### **Image Optimization**
```typescript
// components/optimized-image.tsx
import Image from 'next/image'
import { cn } from '@/lib/utils'

interface OptimizedImageProps {
  src: string
  alt: string
  width: number
  height: number
  className?: string
  priority?: boolean
}

export function OptimizedImage({
  src,
  alt,
  width,
  height,
  className,
  priority = false,
}: OptimizedImageProps) {
  return (
    <Image
      src={src}
      alt={alt}
      width={width}
      height={height}
      className={cn('object-cover', className)}
      priority={priority}
      placeholder="blur"
      blurDataURL="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAYEBQYFBAYGBQYHBwYIChAKCgkJChQODwwQFxQYGBcUFhYaHSUfGhsjHBYWICwgIyYnKSopGR8tMC0oMCUoKSj/2wBDAQcHBwoIChMKChMoGhYaKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCj/wAARCAABAAEDASIAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAAAAv/xAAUEAEAAAAAAAAAAAAAAAAAAAAA/8QAFQEBAQAAAAAAAAAAAAAAAAAAAAX/xAAUEQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwCdABmX/9k="
    />
  )
}
```

### **Lazy Loading Components**
```typescript
// components/lazy-dashboard.tsx
import dynamic from 'next/dynamic'

const DashboardChart = dynamic(() => import('./dashboard-chart'), {
  loading: () => <div>Loading chart...</div>,
  ssr: false,
})

const DashboardTable = dynamic(() => import('./dashboard-table'), {
  loading: () => <div>Loading table...</div>,
})

export function LazyDashboard() {
  return (
    <div>
      <DashboardChart />
      <DashboardTable />
    </div>
  )
}
```

## 🎯 Best Practices

1. **Component Composition** - Build complex components from simple ones
2. **Single Responsibility** - Each component should do one thing well
3. **Props Interface** - Always define TypeScript interfaces for props
4. **Error Boundaries** - Wrap components that might fail
5. **Performance Monitoring** - Use React DevTools and performance metrics
6. **Consistent Naming** - Follow established naming conventions
7. **Documentation** - Document complex logic and patterns

---

**Remember: Good architecture makes code easier to understand, test, and maintain! 🏗️** 