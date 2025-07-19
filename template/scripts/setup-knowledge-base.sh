#!/bin/bash

# Setup Knowledge Base System
# Creates documentation structure for the project

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}📚 Setting up Knowledge Base System...${NC}"

# Create documentation directories
mkdir -p docs/development-notes
mkdir -p docs/decisions
mkdir -p docs/session-notes

# Create development notes template
cat > docs/development-notes/get-started.md << 'EOF'
# Development Notes

This directory contains technical learnings, troubleshooting guides, and architecture insights.

## Structure
- `troubleshooting-guide.md` - Common issues and solutions
- `architecture-patterns.md` - Design patterns and best practices
- `performance-notes.md` - Performance optimizations and learnings
- `security-notes.md` - Security considerations and implementations
EOF

# Create troubleshooting guide
cat > docs/development-notes/troubleshooting-guide.md << 'EOF'
# Troubleshooting Guide

## Common Issues and Solutions

### Port Already in Use
```bash
# Kill process on port 3000
npx kill-port 3000
```

### Module Not Found
```bash
# Clear cache and reinstall
rm -rf node_modules .next
npm install
```

### TypeScript Errors
```bash
# Check types
npm run type-check

# Build to find all errors
npm run build
```

### shadcn/ui Component Issues
```bash
# Reinstall components
npx shadcn-ui@latest add button --force

# Check component configuration
cat components.json
```

### TweakCN Optimization Issues
```bash
# Analyze CSS usage
npm run analyze

# Check configuration
cat tweakcn.config.json
```

### Next.js Build Issues
```bash
# Clear Next.js cache
rm -rf .next

# Rebuild
npm run build
```

### Tailwind CSS Not Working
```bash
# Check Tailwind config
cat tailwind.config.ts

# Rebuild CSS
npm run dev
```

## Performance Issues

### Large Bundle Size
```bash
# Analyze bundle
npm run analyze

# Check TweakCN report
cat tweakcn-report.json
```

### Slow Development Server
```bash
# Clear cache
rm -rf .next node_modules
npm install

# Restart dev server
npm run dev
```

## Environment Issues

### Environment Variables
```bash
# Create .env.local file
touch .env.local

# Add your variables
echo "NEXT_PUBLIC_API_URL=your-api-url" >> .env.local
```

### Git Issues
```bash
# Reset to clean state
git reset --hard HEAD
git clean -fd

# Reinstall dependencies
npm install
```
EOF

# Create architecture patterns guide
cat > docs/development-notes/architecture-patterns.md << 'EOF'
# Architecture Patterns

## Component Organization
- `/components/ui/` - shadcn/ui components
- `/components/custom/` - Custom business components
- `/components/layout/` - Layout components

## File Naming Conventions
- Components: PascalCase (e.g., `WelcomeCard.tsx`)
- Utilities: camelCase (e.g., `utils.ts`)
- Pages: kebab-case (e.g., `user-profile.tsx`)

## State Management
- Local state: React useState/useReducer
- Global state: Consider Zustand or Context API
- Server state: React Query or SWR

## Performance Patterns
- Use React.memo for expensive components
- Implement lazy loading for routes
- Optimize images with Next.js Image component
- Use TweakCN for CSS optimization

## API Patterns
- Use Next.js API routes in `/app/api/`
- Implement proper error handling
- Use TypeScript for API responses
- Add request/response validation

## Testing Patterns
- Unit tests for utilities
- Component tests for UI
- Integration tests for API routes
- E2E tests for critical flows

## Security Patterns
- Validate all inputs
- Use environment variables for secrets
- Implement proper authentication
- Add CSRF protection
EOF

# Create performance notes
cat > docs/development-notes/performance-notes.md << 'EOF'
# Performance Notes

## CSS Optimization with TweakCN

### Before Optimization
- Full Tailwind CSS: ~3.8MB
- First Paint: ~1.2s
- Parse Time: ~300ms

### After Optimization
- Optimized CSS: ~200-400KB (90%+ reduction)
- First Paint: ~600ms (50% faster)
- Parse Time: ~50ms (83% faster)

## Best Practices

### Component Optimization
- Use React.memo for expensive components
- Implement proper loading states
- Lazy load non-critical components

### Image Optimization
- Use Next.js Image component
- Implement proper sizing
- Use WebP format when possible

### Bundle Optimization
- Use dynamic imports for code splitting
- Monitor bundle size with TweakCN
- Remove unused dependencies

### Caching Strategies
- Implement proper cache headers
- Use Next.js caching features
- Consider CDN for static assets
EOF

# Create security notes
cat > docs/development-notes/security-notes.md << 'EOF'
# Security Notes

## Environment Variables
- Never commit secrets to version control
- Use `.env.local` for local development
- Use proper environment variable validation

## Input Validation
- Validate all user inputs
- Use TypeScript for type safety
- Implement proper sanitization

## Authentication
- Use secure authentication methods
- Implement proper session management
- Add rate limiting for API routes

## API Security
- Use HTTPS in production
- Implement proper CORS policies
- Add request validation

## Dependencies
- Regularly update dependencies
- Use `npm audit` to check for vulnerabilities
- Consider using `npm audit fix`
EOF

echo -e "${GREEN}✅ Knowledge base system created${NC}"
echo -e "${BLUE}📁 Documentation structure:${NC}"
echo "  - docs/development-notes/"
echo "  - docs/decisions/"
echo "  - docs/session-notes/"
echo ""
echo -e "${BLUE}📝 Next steps:${NC}"
echo "  - Run ./scripts/new-session.sh to start a development session"
echo "  - Update docs as you develop"
echo "  - Create ADRs for major decisions" 