# 🚀 Cursor Project Starter Template

A comprehensive starter template for Cursor AI projects with Next.js, shadcn/ui, and a built-in knowledge capture system.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Next.js](https://img.shields.io/badge/Next.js-14-black)](https://nextjs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5-blue)](https://www.typescriptlang.org/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-3-38B2AC)](https://tailwindcss.com/)

[![GitHub](https://img.shields.io/badge/GitHub-Repository-181717?logo=github)](https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started)
[![GitHub Stars](https://img.shields.io/github/stars/vidhunnan/cursor-shadcnui-next-js-get-started?style=social)](https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started)
[![GitHub Forks](https://img.shields.io/github/forks/vidhunnan/cursor-shadcnui-next-js-get-started?style=social)](https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started)

## ✨ Features

- **🎨 Modern UI Stack**: Next.js 14, TypeScript, Tailwind CSS, shadcn/ui
- **⚡ Performance Optimized**: Bundle analyzer and Tailwind CSS optimization
- **🤖 AI-Powered**: Cursor AI rules and best practices built-in
- **📚 Knowledge Management**: Session-based development workflow
- **🚀 One-Command Setup**: Interactive project creation
- **📱 Production Ready**: Optimized builds and deployment configs

## 🚀 Quick Start

```bash
# Clone this template
git clone https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started.git
cd cursor-shadcnui-next-js-get-started

# Create a new project
./create-cursor-project.sh
```

## 📦 What's Included

### Tech Stack
- **Next.js 14** - React framework with App Router
- **TypeScript** - Type safety and better DX
- **Tailwind CSS** - Utility-first CSS framework
- **shadcn/ui** - High-quality React components
- **Bundle Analyzer** - Performance monitoring and optimization insights
- **Knowledge Base System** - Documentation and insight capture

### Project Structure
```
my-project/
├── app/                    # Next.js App Router
├── components/            # React components (ui/ + custom/)
├── lib/                   # Utility functions
├── docs/                  # Documentation system
├── scripts/              # Development scripts
├── .cursorrules         # Cursor AI rules
├── components.json      # shadcn/ui config
├── next.config.js       # Next.js configuration
└── ...                  # All necessary configs
```

## 🛠️ Setup Instructions

### 1. Create Project
```bash
./create-cursor-project.sh
# Follow the interactive prompts
```

### 2. Start Development
```bash
cd your-project-name
npm install
npm run dev
```

### 3. Use Knowledge Base
```bash
# Start a development session
./scripts/new-session.sh

# End session when done
./scripts/end-session.sh

# Create ADRs for decisions
./scripts/create-adr.sh "Decision Title"
```

### 4. Add Components
```bash
# Add shadcn/ui components
npx shadcn-ui@latest add alert form table

# Create custom components in components/custom/
```

## 🎨 UI Components

### Available shadcn/ui Components
After setup, you can add any shadcn/ui component:
```bash
npx shadcn-ui@latest add alert
npx shadcn-ui@latest add form
npx shadcn-ui@latest add table
```

### Example Component Usage
```typescript
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"

export default function Example() {
  return (
    <Card>
      <CardHeader>
        <CardTitle>Welcome</CardTitle>
        <CardDescription>Get started with your project</CardDescription>
      </CardHeader>
      <CardContent>
        <Button>Click me</Button>
      </CardContent>
    </Card>
  )
}
```

## 📚 Knowledge Base System

### Session Management
- **Start Session**: `./scripts/new-session.sh` - Creates timestamped session notes
- **End Session**: `./scripts/end-session.sh` - Updates documentation with insights
- **Create ADR**: `./scripts/create-adr.sh` - Document architecture decisions

### Documentation Structure
- **Development Notes**: Technical learnings, troubleshooting, architecture decisions
- **ADRs**: Architecture Decision Records for major choices
- **Session Notes**: Daily development insights and problem solutions

## ⚡ Performance Optimization

### Performance Optimization
- **Bundle Analysis**: Monitor and optimize your application bundle
- **Tailwind CSS**: Utility-first CSS with built-in optimization
- **Next.js 14**: Automatic code splitting and optimization

### Usage
```bash
# Analyze bundle size
npm run analyze

# Build for production
npm run build
```

## 📦 Scripts

```json
{
  "dev": "next dev",
  "build": "next build",
  "start": "next start",
  "lint": "next lint",
  "type-check": "tsc --noEmit",
  "format": "prettier --write .",
  "clean": "rm -rf .next node_modules",
  "analyze": "npx @next/bundle-analyzer",
  "optimize": "npm run build"
}
```

## 🔧 Configuration

### Cursor Rules (.cursorrules)
Project-specific coding guidelines, patterns, and best practices for Cursor AI.

### TypeScript (tsconfig.json)
Pre-configured with strict mode, path aliases, and Next.js optimizations.

### Tailwind CSS
Configured with shadcn/ui defaults, custom color schemes, and dark mode support.

## 🚨 Common Issues

### Port Already in Use
```bash
npx kill-port 3000
```

### Module Not Found
```bash
rm -rf node_modules .next
npm install
```

### TypeScript Errors
```bash
npm run type-check
npm run build
```

## 📖 Documentation

For detailed documentation, see the [docs/](./docs/) directory:
- [Complete Setup Guide](./docs/get-started.md)
- [Template Structure](./docs/doc.md)
- [Performance Optimization](./docs/get-started.md)
- [Template Overview](./docs/TEMPLATE_SUMMARY.md)

## 🤝 Contributing

We welcome contributions! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Repository

- **GitHub**: [https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started](https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started)
- **Issues**: [https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started/issues](https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started/issues)
- **Discussions**: [https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started/discussions](https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started/discussions)

## 🙏 Acknowledgments

- [Next.js](https://nextjs.org/) - The React Framework
- [shadcn/ui](https://ui.shadcn.com/) - Beautiful component library
- [Tailwind CSS](https://tailwindcss.com/) - Utility-first CSS
- [Cursor](https://cursor.sh/) - AI-powered code editor

---

**Happy coding with Cursor AI! 🚀**
