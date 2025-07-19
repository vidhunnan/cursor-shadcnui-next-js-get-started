# 🚀 Cursor Project Starter Template

A modern Next.js 14 starter template with shadcn/ui, TweakCN optimization, and a comprehensive Knowledge Base system.

[![GitHub](https://img.shields.io/badge/GitHub-Repository-181717?logo=github)](https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started)
[![GitHub Stars](https://img.shields.io/github/stars/vidhunnan/cursor-shadcnui-next-js-get-started?style=social)](https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started)
[![GitHub Forks](https://img.shields.io/github/forks/vidhunnan/cursor-shadcnui-next-js-get-started?style=social)](https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started)

## ✨ Features

- **Next.js 14** with App Router and TypeScript
- **shadcn/ui** component library with class-variance-authority
- **TweakCN** for 90%+ CSS bundle size reduction
- **Tailwind CSS** with custom design system
- **Knowledge Base System** for development documentation
- **Cursor AI Rules** for consistent development patterns
- **Shell Scripts** for automation and workflow

## 🚀 Quick Start

### 1. Create New Project
```bash
# Clone this template
git clone https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started.git my-project
cd my-project

# Or use the setup script
./create-cursor-project.sh
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Start Development Server
```bash
npm run dev
```

Visit [http://localhost:3000](http://localhost:3000) to see your app.

## 📚 Knowledge Base System

This template includes a comprehensive Knowledge Base system for capturing development insights, decisions, and learnings.

### **📖 Complete Documentation**
For detailed usage instructions, troubleshooting, and best practices, see:
**[📚 Knowledge Base Documentation](docs/get-started.md)**

### **Quick Start with Knowledge Base**
```bash
# Start a development session
./scripts/new-session.sh

# Create an Architecture Decision Record
./scripts/create-adr.sh "Use Server Components for Data Fetching"

# End your session
./scripts/end-session.sh
```

### **Knowledge Base Structure**
```
docs/
├── get-started.md              # Knowledge Base overview
├── development-notes/           # Technical learnings and guides
│   ├── get-started.md          # Development notes index
│   ├── troubleshooting-guide.md # Common issues and solutions
│   ├── architecture-patterns.md # Design patterns and best practices
│   ├── performance-notes.md    # Performance optimizations
│   └── security-notes.md       # Security considerations
├── decisions/                   # Architecture Decision Records (ADRs)
│   ├── get-started.md          # ADRs overview
│   ├── adr-20241201.md         # Example ADR
│   └── adr-template.md         # ADR template
└── session-notes/              # Daily development sessions
    ├── get-started.md          # Session notes overview
    ├── session-20241201-1430.md # Example session
    └── session-template.md     # Session template
```

## 🛠️ Available Scripts

### **Development**
```bash
npm run dev          # Start development server
npm run build        # Build for production
npm run start        # Start production server
npm run lint         # Run ESLint
npm run type-check   # Run TypeScript type checking
```

### **CSS Optimization**
```bash
npm run analyze      # Analyze CSS usage
npm run optimize     # Optimize CSS for production
```

### **Knowledge Base**
```bash
./scripts/new-session.sh        # Start a new development session
./scripts/end-session.sh        # End current session
./scripts/create-adr.sh "Title" # Create an Architecture Decision Record
```

| Script | Purpose | Output |
|--------|---------|---------|
| `new-session.sh` | Start daily development session | `docs/session-notes/session-YYYYMMDD-HHMM.md` |
| `end-session.sh` | End session with summary | Updates session file with end time |
| `create-adr.sh "Title"` | Document architecture decision | `docs/decisions/adr-YYYYMMDD.md` |

## 🎨 Component Library

### **shadcn/ui Components**
- Button with variants (default, destructive, outline, secondary, ghost, link)
- Card with header, content, and footer
- Badge with different styles
- More components can be added with `npx shadcn-ui@latest add [component]`

### **Custom Components**
- WelcomeCard - Example custom component
- Extensible component architecture

### **Adding New Components**
```bash
# Add shadcn/ui component
npx shadcn-ui@latest add input

# Create custom component
touch components/custom/my-component.tsx
```

## 🔧 Configuration

### **Tailwind CSS**
- Custom design tokens
- Dark mode support
- Responsive utilities
- Custom animations

### **TweakCN**
- CSS optimization for production
- Bundle size reduction
- Usage analysis

### **TypeScript**
- Strict type checking
- Path aliases configured
- ESLint integration

## 📁 Project Structure

```
├── app/                    # Next.js App Router
│   ├── globals.css        # Global styles
│   ├── layout.tsx         # Root layout
│   └── page.tsx           # Home page
├── components/            # React components
│   ├── ui/               # shadcn/ui components
│   └── custom/           # Custom components
├── lib/                  # Utility functions
│   └── utils.ts          # Common utilities
├── docs/                 # Knowledge Base
│   ├── development-notes/ # Technical documentation
│   ├── decisions/        # Architecture Decision Records
│   └── session-notes/    # Development sessions
├── scripts/              # Automation scripts
├── public/               # Static assets
└── Configuration files   # Various config files
```

## 🎯 Best Practices

### **Component Development**
- Use TypeScript interfaces for all props
- Implement proper error boundaries
- Follow shadcn/ui patterns
- Use the `cn()` utility for conditional classes

### **Knowledge Management**
- Document decisions with ADRs
- Update session notes regularly
- Share learnings in development notes
- Cross-reference related documentation

### **Performance**
- Use Next.js Image component
- Implement proper caching strategies
- Monitor Core Web Vitals
- Optimize bundle sizes with TweakCN

## 🔒 Security

- Input validation with Zod
- Secure authentication patterns
- XSS prevention
- CSRF protection
- Rate limiting
- Security headers

## 📈 Performance

- Server Components for better performance
- CSS optimization with TweakCN
- Image optimization
- Code splitting
- Caching strategies

## 🤝 Contributing

1. Follow the established patterns
2. Update documentation as needed
3. Create ADRs for significant decisions
4. Maintain the Knowledge Base

## 📚 Resources

- [Next.js Documentation](https://nextjs.org/docs)
- [shadcn/ui Documentation](https://ui.shadcn.com/)
- [Tailwind CSS Documentation](https://tailwindcss.com/docs)
- [TweakCN Documentation](https://tweakcn.com/)

## 🔗 Repository

- **GitHub**: [https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started](https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started)
- **Issues**: [https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started/issues](https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started/issues)
- **Discussions**: [https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started/discussions](https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started/discussions)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Happy coding! 🚀** 