# ⚡ Performance Notes

Performance optimization strategies and learnings for Next.js projects.

## 🎯 Core Web Vitals

### **Largest Contentful Paint (LCP)**
- **Target**: < 2.5 seconds
- **Optimizations**:
  - Use Next.js Image component with proper sizing
  - Implement lazy loading for below-the-fold images
  - Optimize critical rendering path
  - Use CDN for static assets

### **First Input Delay (FID)**
- **Target**: < 100 milliseconds
- **Optimizations**:
  - Minimize JavaScript bundle size
  - Use code splitting and lazy loading
  - Optimize event handlers
  - Implement proper loading states

### **Cumulative Layout Shift (CLS)**
- **Target**: < 0.1
- **Optimizations**:
  - Set explicit dimensions for images and videos
  - Reserve space for dynamic content
  - Avoid inserting content above existing content
  - Use CSS transforms instead of layout changes

## 📦 Bundle Optimization

### **TweakCN CSS Optimization**
```bash
# Analyze CSS usage
npm run analyze

# Optimize CSS for production
npm run optimize

# Check optimization results
cat tweakcn-report.json
```

### **JavaScript Bundle Optimization**
```typescript
// Dynamic imports for code splitting
const HeavyComponent = dynamic(() => import('./HeavyComponent'), {
  loading: () => <div>Loading...</div>,
  ssr: false, // Disable SSR for client-only components
})

// Route-based code splitting
const Dashboard = dynamic(() => import('./Dashboard'), {
  loading: () => <DashboardSkeleton />,
})
```

### **Tree Shaking**
```typescript
// Import only what you need
import { Button } from '@/components/ui/button'
// Instead of
import * as UI from '@/components/ui'
```

## 🖼️ Image Optimization

### **Next.js Image Component**
```typescript
import Image from 'next/image'

// Optimized image with proper sizing
<Image
  src="/hero-image.jpg"
  alt="Hero image"
  width={1200}
  height={600}
  priority // For above-the-fold images
  placeholder="blur"
  blurDataURL="data:image/jpeg;base64,..."
/>
```

### **Image Formats**
- **WebP**: Best compression, modern browsers
- **AVIF**: Latest format, excellent compression
- **JPEG**: Fallback for older browsers
- **PNG**: For images requiring transparency

### **Responsive Images**
```typescript
<Image
  src="/responsive-image.jpg"
  alt="Responsive image"
  fill
  sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
  className="object-cover"
/>
```

## 🔄 Caching Strategies

### **Static Assets**
```typescript
// next.config.js
module.exports = {
  async headers() {
    return [
      {
        source: '/static/:path*',
        headers: [
          {
            key: 'Cache-Control',
            value: 'public, max-age=31536000, immutable',
          },
        ],
      },
    ]
  },
}
```

### **API Response Caching**
```typescript
// app/api/data/route.ts
export async function GET() {
  const data = await fetchData()
  
  return NextResponse.json(data, {
    headers: {
      'Cache-Control': 'public, s-maxage=3600, stale-while-revalidate=86400',
    },
  })
}
```

### **React Query Caching**
```typescript
import { useQuery } from '@tanstack/react-query'

const { data } = useQuery({
  queryKey: ['users'],
  queryFn: fetchUsers,
  staleTime: 5 * 60 * 1000, // 5 minutes
  cacheTime: 10 * 60 * 1000, // 10 minutes
})
```

## 🚀 Server-Side Optimization

### **Server Components**
```typescript
// app/users/page.tsx
async function UsersPage() {
  // This runs on the server
  const users = await fetchUsers()
  
  return (
    <div>
      {users.map(user => (
        <UserCard key={user.id} user={user} />
      ))}
    </div>
  )
}
```

### **Streaming**
```typescript
// app/dashboard/page.tsx
import { Suspense } from 'react'

export default function DashboardPage() {
  return (
    <div>
      <Suspense fallback={<DashboardSkeleton />}>
        <Dashboard />
      </Suspense>
      <Suspense fallback={<AnalyticsSkeleton />}>
        <Analytics />
      </Suspense>
    </div>
  )
}
```

### **Database Query Optimization**
```typescript
// Optimize database queries
const users = await prisma.user.findMany({
  select: {
    id: true,
    name: true,
    email: true,
    // Only select needed fields
  },
  where: {
    active: true,
  },
  take: 20, // Limit results
})
```

## 📊 Monitoring & Analytics

### **Core Web Vitals Monitoring**
```typescript
// lib/analytics.ts
export function reportWebVitals(metric: any) {
  if (metric.label === 'web-vital') {
    // Send to analytics service
    console.log(metric)
  }
}
```

### **Performance Monitoring**
```typescript
// Custom performance monitoring
export function measurePerformance(name: string, fn: () => void) {
  const start = performance.now()
  fn()
  const end = performance.now()
  
  console.log(`${name} took ${end - start}ms`)
}
```

## 🔧 Development Tools

### **Bundle Analyzer**
```bash
# Install bundle analyzer
npm install @next/bundle-analyzer

# Analyze bundle
npm run analyze
```

### **Lighthouse CI**
```bash
# Install Lighthouse CI
npm install -g @lhci/cli

# Run Lighthouse
lhci autorun
```

### **Web Vitals**
```bash
# Install web-vitals
npm install web-vitals

# Monitor in development
import { getCLS, getFID, getFCP, getLCP, getTTFB } from 'web-vitals'
```

## 📈 Performance Checklist

### **Before Deployment**
- [ ] Run Lighthouse audit
- [ ] Check Core Web Vitals
- [ ] Optimize images
- [ ] Minimize bundle size
- [ ] Enable compression
- [ ] Set up caching headers
- [ ] Test on slow connections

### **Ongoing Monitoring**
- [ ] Monitor Core Web Vitals
- [ ] Track bundle size changes
- [ ] Monitor API response times
- [ ] Check for memory leaks
- [ ] Review performance budgets

## 🎯 Best Practices

1. **Measure First** - Always measure before optimizing
2. **Optimize Critical Path** - Focus on above-the-fold content
3. **Use Modern Formats** - WebP, AVIF for images
4. **Implement Caching** - Cache static assets and API responses
5. **Code Splitting** - Split code by routes and components
6. **Lazy Loading** - Load non-critical resources on demand
7. **Monitor Performance** - Set up ongoing performance monitoring

## 📚 Resources

- [Next.js Performance Documentation](https://nextjs.org/docs/advanced-features/measuring-performance)
- [Web Vitals](https://web.dev/vitals/)
- [Lighthouse](https://developers.google.com/web/tools/lighthouse)
- [Core Web Vitals](https://web.dev/core-web-vitals/)

---

**Remember: Performance is a feature, not an afterthought! ⚡** 