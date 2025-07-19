# 🔧 Troubleshooting Guide

Common issues and solutions for Next.js projects with shadcn/ui and TweakCN.

## 🚨 Common Issues

### **Port Already in Use**
```bash
# Kill process on port 3000
npx kill-port 3000

# Or find and kill the process manually
lsof -ti:3000 | xargs kill -9
```

### **Module Not Found**
```bash
# Clear cache and reinstall
rm -rf node_modules .next
npm install

# If using yarn
rm -rf node_modules .next
yarn install
```

### **TypeScript Errors**
```bash
# Check types
npm run type-check

# Build to find all errors
npm run build

# Clear TypeScript cache
rm -rf .next
```

### **shadcn/ui Component Issues**
```bash
# Reinstall components
npx shadcn-ui@latest add button --force

# Check component configuration
cat components.json

# Update shadcn/ui
npx shadcn-ui@latest update
```

### **TweakCN Optimization Issues**
```bash
# Analyze CSS usage
npm run analyze

# Check configuration
cat tweakcn.config.json

# Regenerate optimized CSS
npm run optimize
```

### **Next.js Build Issues**
```bash
# Clear Next.js cache
rm -rf .next

# Rebuild
npm run build

# Check for memory issues
NODE_OPTIONS="--max-old-space-size=4096" npm run build
```

### **Tailwind CSS Not Working**
```bash
# Check Tailwind config
cat tailwind.config.ts

# Rebuild CSS
npm run dev

# Check PostCSS config
cat postcss.config.js
```

## 🔍 Performance Issues

### **Large Bundle Size**
```bash
# Analyze bundle
npm run analyze

# Check TweakCN report
cat tweakcn-report.json

# Use Next.js bundle analyzer
npm install @next/bundle-analyzer
```

### **Slow Development Server**
```bash
# Clear cache
rm -rf .next node_modules
npm install

# Restart dev server
npm run dev

# Check for file watchers
ulimit -n 10240
```

### **Slow Build Times**
```bash
# Use production build
npm run build

# Check for unnecessary dependencies
npm ls

# Optimize images
# Use Next.js Image component with proper sizing
```

## 🌐 Environment Issues

### **Environment Variables**
```bash
# Create .env.local file
touch .env.local

# Add your variables
echo "NEXT_PUBLIC_API_URL=your-api-url" >> .env.local

# Check environment loading
npm run dev
```

### **Git Issues**
```bash
# Reset to clean state
git reset --hard HEAD
git clean -fd

# Reinstall dependencies
npm install
```

## 🎨 UI/UX Issues

### **shadcn/ui Styling Problems**
```bash
# Check CSS variables
# Ensure globals.css is imported

# Verify Tailwind classes
# Use the cn() utility for conditional classes

# Check component variants
# Use class-variance-authority properly
```

### **Dark Mode Issues**
```bash
# Check CSS variables in globals.css
# Verify dark mode configuration in tailwind.config.ts

# Test theme switching
# Use next-themes for theme management
```

## 🔒 Security Issues

### **Environment Variables in Client**
```bash
# Only use NEXT_PUBLIC_ prefix for client-side variables
# Keep sensitive data server-side only

# Check for exposed secrets
grep -r "NEXT_PUBLIC_" . --exclude-dir=node_modules
```

### **Dependency Vulnerabilities**
```bash
# Check for vulnerabilities
npm audit

# Fix vulnerabilities
npm audit fix

# Update dependencies
npm update
```

## 📱 Mobile/Responsive Issues

### **Responsive Design Problems**
```bash
# Test on different screen sizes
# Use Tailwind responsive prefixes

# Check viewport meta tag
# Ensure proper mobile optimization
```

## 🧪 Testing Issues

### **Test Setup Problems**
```bash
# Install testing dependencies
npm install --save-dev jest @testing-library/react

# Configure Jest for Next.js
# Set up testing environment
```

## 🔄 Debugging Tips

### **Enable Debug Logging**
```bash
# Next.js debug
DEBUG=* npm run dev

# Tailwind debug
TAILWIND_DEBUG=true npm run dev
```

### **Check File Structure**
```bash
# Verify component imports
# Check file naming conventions
# Ensure proper directory structure
```

### **Performance Monitoring**
```bash
# Use Chrome DevTools
# Monitor network requests
# Check bundle size
# Analyze performance metrics
```

## 📞 Getting Help

### **Useful Commands**
```bash
# Check Node.js version
node --version

# Check npm version
npm --version

# Check Next.js version
npm list next

# Check all dependencies
npm ls
```

### **Resources**
- [Next.js Documentation](https://nextjs.org/docs)
- [shadcn/ui Documentation](https://ui.shadcn.com/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [TweakCN Documentation](https://tweakcn.com/)

---

**Remember: Most issues can be solved by clearing cache and reinstalling dependencies! 🔧** 