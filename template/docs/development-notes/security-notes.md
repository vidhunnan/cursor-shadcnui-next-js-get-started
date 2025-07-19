# 🔒 Security Notes

Security best practices and considerations for Next.js applications.

## 🛡️ Authentication & Authorization

### **JWT Token Security**
```typescript
// lib/auth.ts
import jwt from 'jsonwebtoken'

const JWT_SECRET = process.env.JWT_SECRET!
const JWT_EXPIRES_IN = '15m' // Short expiration

export function createToken(payload: any) {
  return jwt.sign(payload, JWT_SECRET, {
    expiresIn: JWT_EXPIRES_IN,
    issuer: 'your-app',
    audience: 'your-app-users',
  })
}

export function verifyToken(token: string) {
  try {
    return jwt.verify(token, JWT_SECRET, {
      issuer: 'your-app',
      audience: 'your-app-users',
    })
  } catch (error) {
    throw new Error('Invalid token')
  }
}
```

### **Session Management**
```typescript
// lib/session.ts
import { cookies } from 'next/headers'

export async function createSession(userId: string) {
  const token = createToken({ userId })
  
  // Set secure, httpOnly cookie
  cookies().set('session-token', token, {
    httpOnly: true,
    secure: process.env.NODE_ENV === 'production',
    sameSite: 'strict',
    maxAge: 15 * 60, // 15 minutes
  })
}

export async function getSession() {
  const token = cookies().get('session-token')?.value
  
  if (!token) {
    return null
  }
  
  try {
    return verifyToken(token)
  } catch {
    return null
  }
}
```

### **Role-Based Access Control**
```typescript
// lib/rbac.ts
export enum UserRole {
  USER = 'user',
  ADMIN = 'admin',
  MODERATOR = 'moderator',
}

export function hasPermission(userRole: UserRole, requiredRole: UserRole) {
  const roleHierarchy = {
    [UserRole.USER]: 1,
    [UserRole.MODERATOR]: 2,
    [UserRole.ADMIN]: 3,
  }
  
  return roleHierarchy[userRole] >= roleHierarchy[requiredRole]
}

// Middleware for route protection
export function withAuth(handler: Function, requiredRole?: UserRole) {
  return async (req: NextRequest) => {
    const session = await getSession()
    
    if (!session) {
      return NextResponse.json({ error: 'Unauthorized' }, { status: 401 })
    }
    
    if (requiredRole && !hasPermission(session.role, requiredRole)) {
      return NextResponse.json({ error: 'Forbidden' }, { status: 403 })
    }
    
    return handler(req, session)
  }
}
```

## 🔐 Input Validation

### **Zod Schema Validation**
```typescript
// lib/validation.ts
import { z } from 'zod'

export const userSchema = z.object({
  name: z.string().min(2).max(50).trim(),
  email: z.string().email().toLowerCase(),
  password: z.string().min(8).regex(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/),
  age: z.number().min(18).max(120).optional(),
})

export const loginSchema = z.object({
  email: z.string().email(),
  password: z.string().min(1),
})

// API route with validation
export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const validatedData = loginSchema.parse(body)
    
    // Process validated data
    const user = await authenticateUser(validatedData)
    
    return NextResponse.json({ user })
  } catch (error) {
    if (error instanceof z.ZodError) {
      return NextResponse.json(
        { error: 'Invalid input', details: error.errors },
        { status: 400 }
      )
    }
    
    return NextResponse.json(
      { error: 'Internal server error' },
      { status: 500 }
    )
  }
}
```

### **SQL Injection Prevention**
```typescript
// Use parameterized queries
const user = await prisma.user.findUnique({
  where: {
    email: email, // Prisma automatically escapes
  },
})

// For raw SQL, use parameterized queries
const result = await prisma.$queryRaw`
  SELECT * FROM users WHERE email = ${email}
`
```

## 🚫 XSS Prevention

### **Content Security Policy**
```typescript
// next.config.js
module.exports = {
  async headers() {
    return [
      {
        source: '/(.*)',
        headers: [
          {
            key: 'Content-Security-Policy',
            value: [
              "default-src 'self'",
              "script-src 'self' 'unsafe-eval' 'unsafe-inline'",
              "style-src 'self' 'unsafe-inline'",
              "img-src 'self' data: https:",
              "font-src 'self'",
              "connect-src 'self'",
              "frame-ancestors 'none'",
            ].join('; '),
          },
        ],
      },
    ]
  },
}
```

### **Safe HTML Rendering**
```typescript
// Use DOMPurify for sanitizing HTML
import DOMPurify from 'dompurify'

export function sanitizeHtml(html: string) {
  return DOMPurify.sanitize(html, {
    ALLOWED_TAGS: ['p', 'br', 'strong', 'em'],
    ALLOWED_ATTR: [],
  })
}

// React component with safe rendering
export function SafeHtml({ html }: { html: string }) {
  const sanitized = sanitizeHtml(html)
  
  return (
    <div 
      dangerouslySetInnerHTML={{ __html: sanitized }}
      className="prose"
    />
  )
}
```

## 🔄 CSRF Protection

### **CSRF Token Implementation**
```typescript
// lib/csrf.ts
import crypto from 'crypto'

export function generateCSRFToken() {
  return crypto.randomBytes(32).toString('hex')
}

export function validateCSRFToken(token: string, storedToken: string) {
  return crypto.timingSafeEqual(
    Buffer.from(token, 'hex'),
    Buffer.from(storedToken, 'hex')
  )
}

// Form with CSRF protection
export function ProtectedForm() {
  const [csrfToken, setCsrfToken] = useState('')
  
  useEffect(() => {
    const token = generateCSRFToken()
    setCsrfToken(token)
    // Store token in session
  }, [])
  
  return (
    <form>
      <input type="hidden" name="csrf" value={csrfToken} />
      {/* Form fields */}
    </form>
  )
}
```

## 🔍 Rate Limiting

### **API Rate Limiting**
```typescript
// lib/rate-limit.ts
import { NextRequest } from 'next/server'

const rateLimitMap = new Map()

export function rateLimit(
  request: NextRequest,
  limit: number = 100,
  windowMs: number = 15 * 60 * 1000 // 15 minutes
) {
  const ip = request.ip || 'unknown'
  const now = Date.now()
  const windowStart = now - windowMs
  
  const requests = rateLimitMap.get(ip) || []
  const recentRequests = requests.filter(time => time > windowStart)
  
  if (recentRequests.length >= limit) {
    return false
  }
  
  recentRequests.push(now)
  rateLimitMap.set(ip, recentRequests)
  
  return true
}

// API route with rate limiting
export async function POST(request: NextRequest) {
  if (!rateLimit(request, 10, 60 * 1000)) { // 10 requests per minute
    return NextResponse.json(
      { error: 'Too many requests' },
      { status: 429 }
    )
  }
  
  // Process request
}
```

## 🔐 Environment Variables

### **Secure Environment Configuration**
```typescript
// lib/env.ts
import { z } from 'zod'

const envSchema = z.object({
  DATABASE_URL: z.string().url(),
  JWT_SECRET: z.string().min(32),
  API_KEY: z.string().min(1),
  NODE_ENV: z.enum(['development', 'production', 'test']),
})

export const env = envSchema.parse(process.env)

// Validate at startup
if (!env.JWT_SECRET || env.JWT_SECRET.length < 32) {
  throw new Error('JWT_SECRET must be at least 32 characters long')
}
```

### **Client-Side Environment Variables**
```typescript
// Only expose public variables to client
const publicEnv = {
  NEXT_PUBLIC_API_URL: process.env.NEXT_PUBLIC_API_URL,
  NEXT_PUBLIC_APP_VERSION: process.env.NEXT_PUBLIC_APP_VERSION,
}

// Keep sensitive data server-side only
const serverEnv = {
  DATABASE_URL: process.env.DATABASE_URL,
  JWT_SECRET: process.env.JWT_SECRET,
}
```

## 🛡️ Security Headers

### **Security Headers Configuration**
```typescript
// next.config.js
module.exports = {
  async headers() {
    return [
      {
        source: '/(.*)',
        headers: [
          {
            key: 'X-Frame-Options',
            value: 'DENY',
          },
          {
            key: 'X-Content-Type-Options',
            value: 'nosniff',
          },
          {
            key: 'Referrer-Policy',
            value: 'strict-origin-when-cross-origin',
          },
          {
            key: 'Permissions-Policy',
            value: 'camera=(), microphone=(), geolocation=()',
          },
        ],
      },
    ]
  },
}
```

## 🔍 Security Monitoring

### **Security Logging**
```typescript
// lib/security-logger.ts
export function logSecurityEvent(event: {
  type: 'login_attempt' | 'failed_auth' | 'suspicious_activity'
  ip: string
  userAgent: string
  details: any
}) {
  console.log(`[SECURITY] ${event.type}:`, {
    timestamp: new Date().toISOString(),
    ip: event.ip,
    userAgent: event.userAgent,
    details: event.details,
  })
  
  // Send to security monitoring service
  // sendToSecurityService(event)
}
```

### **Failed Login Detection**
```typescript
// lib/auth.ts
const failedAttempts = new Map()

export async function attemptLogin(email: string, password: string) {
  const attempts = failedAttempts.get(email) || 0
  
  if (attempts >= 5) {
    logSecurityEvent({
      type: 'suspicious_activity',
      ip: 'unknown',
      userAgent: 'unknown',
      details: { email, reason: 'too_many_failed_attempts' },
    })
    
    throw new Error('Account temporarily locked')
  }
  
  try {
    const user = await authenticateUser(email, password)
    failedAttempts.delete(email)
    return user
  } catch (error) {
    failedAttempts.set(email, attempts + 1)
    throw error
  }
}
```

## 📋 Security Checklist

### **Before Deployment**
- [ ] Enable HTTPS
- [ ] Set secure cookies
- [ ] Configure CSP headers
- [ ] Implement rate limiting
- [ ] Validate all inputs
- [ ] Sanitize user content
- [ ] Use parameterized queries
- [ ] Set up security monitoring

### **Ongoing Security**
- [ ] Regular dependency updates
- [ ] Security audits
- [ ] Monitor failed login attempts
- [ ] Review access logs
- [ ] Update security policies
- [ ] Conduct penetration testing

## 🎯 Best Practices

1. **Defense in Depth** - Multiple layers of security
2. **Principle of Least Privilege** - Minimal required permissions
3. **Input Validation** - Validate all user inputs
4. **Output Encoding** - Encode all outputs
5. **Secure by Default** - Secure configurations by default
6. **Regular Updates** - Keep dependencies updated
7. **Security Monitoring** - Monitor for security events

## 📚 Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Next.js Security Documentation](https://nextjs.org/docs/advanced-features/security-headers)
- [Web Security Fundamentals](https://web.dev/security/)
- [Content Security Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP)

---

**Remember: Security is everyone's responsibility! 🔒** 