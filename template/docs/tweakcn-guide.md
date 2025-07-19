# TweakCN - Tailwind CSS Optimization Guide

## 🚀 Performance Benefits

### Before TweakCN
- Full Tailwind CSS: ~3.8MB
- First Paint: ~1.2s
- Parse Time: ~300ms
- Unused Classes: ~95%

### After TweakCN
- Optimized CSS: ~200-400KB (90%+ reduction)
- First Paint: ~600ms (50% faster)
- Parse Time: ~50ms (83% faster)
- Only Used Classes: 100% efficiency

## 📊 Usage Workflow

### 1. Development Phase
```bash
# Normal development with full Tailwind
npm run dev
```

### 2. Pre-Production Analysis
```bash
# Analyze your CSS usage
npm run analyze

# Review the report
cat tweakcn-report.json
```

### 3. Production Build
```bash
# Automatically optimizes CSS
npm run build
```

## 🎯 Configuration

### Basic Configuration (tweakcn.config.json)
```json
{
  "include": [
    "./app/**/*.{js,ts,jsx,tsx}",
    "./components/**/*.{js,ts,jsx,tsx}",
    "./lib/**/*.{js,ts,jsx,tsx}"
  ],
  "exclude": [
    "./node_modules/**",
    "./.next/**"
  ],
  "tailwindConfig": "./tailwind.config.ts",
  "output": {
    "css": "./app/globals.optimized.css",
    "report": "./tweakcn-report.json"
  }
}
```

### Advanced Options
```json
{
  "options": {
    "preserveImportant": true,
    "preserveKeyframes": true,
    "preserveVariables": true,
    "preserveMediaQueries": true,
    "minify": true,
    "removeComments": true,
    "mergeRules": true
  },
  "safelist": {
    "classes": ["animate-spin", "animate-pulse"],
    "patterns": [
      "bg-(red|green|blue)-(100|500|900)",
      "text-(xs|sm|base|lg|xl)"
    ]
  }
}
```

## 🔧 Common Patterns

### Dynamic Classes with shadcn/ui
```typescript
// ❌ Problematic: String concatenation
const variant = props.variant || 'default';
const className = `bg-${variant}-500`;

// ✅ Better: Object mapping
const variantStyles = {
  default: 'bg-gray-500',
  primary: 'bg-blue-500',
  danger: 'bg-red-500',
} as const;

const className = variantStyles[variant];

// ✅ Best: Using cva from class-variance-authority
import { cva } from 'class-variance-authority';

const buttonVariants = cva(
  'inline-flex items-center rounded-md',
  {
    variants: {
      variant: {
        default: 'bg-gray-500 text-white',
        primary: 'bg-blue-500 text-white',
        danger: 'bg-red-500 text-white',
      },
    },
  }
);
```

### Safelist Strategy for Dynamic Content
```typescript
// tailwind.config.ts
module.exports = {
  content: [
    './app/**/*.{js,ts,jsx,tsx}',
    './components/**/*.{js,ts,jsx,tsx}',
  ],
  safelist: [
    // Specific classes
    'bg-red-500',
    'bg-green-500',
    
    // Patterns for dynamic classes
    {
      pattern: /bg-(red|green|blue|yellow)-(100|200|300|400|500)/,
      variants: ['hover', 'focus'],
    },
    
    // Animation classes
    'animate-spin',
    'animate-pulse',
    'animate-bounce',
    
    // Grid classes for dynamic layouts
    {
      pattern: /grid-cols-(1|2|3|4|5|6|7|8|9|10|11|12)/,
      variants: ['sm', 'md', 'lg', 'xl', '2xl'],
    },
  ],
};
```

## 🏗️ Build Pipeline Integration

### Next.js Build Configuration
```javascript
// next.config.js
const path = require('path');

module.exports = {
  webpack: (config, { dev, isServer }) => {
    if (!dev && !isServer) {
      // Use optimized CSS in production
      config.resolve.alias['@/styles/globals.css'] = path.resolve(
        __dirname,
        './app/globals.optimized.css'
      );
    }
    return config;
  },
};
```

### CI/CD Pipeline Example
```yaml
# .github/workflows/build.yml
name: Build and Deploy

on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          
      - name: Install dependencies
        run: npm ci
        
      - name: Analyze CSS usage
        run: npm run analyze
        
      - name: Upload CSS report
        uses: actions/upload-artifact@v3
        with:
          name: css-analysis
          path: tweakcn-report.json
          
      - name: Build with optimization
        run: npm run build
        
      - name: Deploy
        run: npm run deploy
```

## 🎨 Working with Component Libraries

### shadcn/ui Component Optimization
```json
{
  "include": [
    "./components/ui/**/*.tsx",
    "./app/**/*.tsx"
  ],
  "componentLibraries": {
    "shadcn": {
      "preserveDefaults": true,
      "includeThemeClasses": true
    }
  }
}
```

### Custom Component Patterns
```typescript
// components/ui/dynamic-badge.tsx
import { Badge } from '@/components/ui/badge';
import { cn } from '@/lib/utils';

// Define all possible classes
const STATUS_CLASSES = {
  success: 'bg-green-100 text-green-800',
  warning: 'bg-yellow-100 text-yellow-800',
  error: 'bg-red-100 text-red-800',
  info: 'bg-blue-100 text-blue-800',
} as const;

type Status = keyof typeof STATUS_CLASSES;

interface DynamicBadgeProps {
  status: Status;
  children: React.ReactNode;
}

export function DynamicBadge({ status, children }: DynamicBadgeProps) {
  return (
    <Badge className={cn(STATUS_CLASSES[status])}>
      {children}
    </Badge>
  );
}
```

## 📈 Monitoring & Optimization

### Size Tracking Script
```bash
#!/bin/bash
# scripts/track-css-size.sh

echo "CSS Size Tracking Report"
echo "======================="

ORIGINAL=$(stat -f%z app/globals.css 2>/dev/null || stat -c%s app/globals.css)
OPTIMIZED=$(stat -f%z app/globals.optimized.css 2>/dev/null || stat -c%s app/globals.optimized.css 2>/dev/null || echo "0")

echo "Original CSS: $(numfmt --to=iec-i --suffix=B $ORIGINAL)"
echo "Optimized CSS: $(numfmt --to=iec-i --suffix=B $OPTIMIZED)"

if [ $OPTIMIZED -gt 0 ]; then
  REDUCTION=$(( 100 - ($OPTIMIZED * 100 / $ORIGINAL) ))
  echo "Size Reduction: ${REDUCTION}%"
fi
```

### Performance Budget
```json
// tweakcn.config.json
{
  "performanceBudget": {
    "maxSize": "500KB",
    "warnAt": "400KB",
    "errorOnExceed": false
  }
}
```

## 🐛 Debugging Tips

### Missing Styles Checklist
1. **Check Dynamic Classes**: `grep -r "className.*\${" ./app ./components`
2. **Verify Include Paths**: `tweakcn analyze --verbose --show-files`
3. **Check Safelist**: Ensure dynamic classes are in safelist
4. **Review Report**: Check `tweakcn-report.json` for missing classes
5. **Test Build**: Run `npm run build` to see optimization results

### Common Issues
- **Missing dynamic classes**: Add to safelist or use object mapping
- **Component library classes**: Ensure proper include paths
- **Build errors**: Check configuration syntax
- **No optimization**: Verify TweakCN is installed and configured

## 🚀 Best Practices

1. **Use Object Mapping**: Instead of string concatenation for dynamic classes
2. **Leverage class-variance-authority**: For component variants
3. **Safelist Strategically**: Only what's truly dynamic
4. **Monitor Bundle Size**: Regular analysis and tracking
5. **Test in Production**: Verify optimization works in real builds
6. **Document Patterns**: Share learnings with team 