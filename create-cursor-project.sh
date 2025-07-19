#!/bin/bash

# Cursor Project Starter - Quick Start Guide
# Creates a Next.js + shadcn/ui + Knowledge Base project

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ASCII Art Header
echo -e "${CYAN}"
cat << "EOF"
   ____                            ____  _             _            
  / ___|   _ _ __ ___  ___  _ __  / ___|| |_ __ _ _ __| |_ ___ _ __ 
 | |  | | | | '__/ __|/ _ \| '__| \___ \| __/ _` | '__| __/ _ \ '__|
 | |__| |_| | |  \__ \ (_) | |     ___) | || (_| | |  | ||  __/ |   
  \____\__,_|_|  |___/\___/|_|    |____/ \__\__,_|_|   \__\___|_|   
EOF
echo -e "${NC}"

echo -e "${BLUE}🚀 Cursor Project Starter - Quick Start${NC}"
echo "This script creates a Next.js project with shadcn/ui and knowledge base system."
echo ""

# Get project name
read -p "Project name (lowercase, no spaces): " PROJECT_NAME
PROJECT_NAME=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

if [ -z "$PROJECT_NAME" ]; then
    echo -e "${RED}❌ Project name is required${NC}"
    exit 1
fi

# Check if directory exists
if [ -d "$PROJECT_NAME" ]; then
    echo -e "${RED}❌ Directory '$PROJECT_NAME' already exists${NC}"
    exit 1
fi

read -p "Project description: " PROJECT_DESCRIPTION

echo ""
echo -e "${BLUE}📦 Creating Next.js project...${NC}"

# Create Next.js project with TypeScript and Tailwind
npx create-next-app@latest "$PROJECT_NAME" \
    --typescript \
    --tailwind \
    --app \
    --src-dir=false \
    --import-alias "@/*" \
    --use-npm

cd "$PROJECT_NAME"

echo -e "${GREEN}✅ Next.js project created${NC}"

# Initialize shadcn/ui
echo -e "${BLUE}🎨 Setting up shadcn/ui...${NC}"

# Create components.json for shadcn/ui
cat > components.json << EOF
{
  "\$schema": "https://ui.shadcn.com/schema.json",
  "style": "default",
  "rsc": true,
  "tsx": true,
  "tailwind": {
    "config": "tailwind.config.ts",
    "css": "app/globals.css",
    "baseColor": "slate",
    "cssVariables": true,
    "prefix": ""
  },
  "aliases": {
    "components": "@/components",
    "utils": "@/lib/utils"
  }
}
EOF

# Install shadcn/ui dependencies and TweakCN
npm install clsx tailwind-merge class-variance-authority
npm install --save-dev tweakcn

# Create lib directory and utils
mkdir -p lib
cat > lib/utils.ts << 'EOF'
import { type ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}
EOF

# Create components directory
mkdir -p components/ui
mkdir -p components/custom

echo -e "${GREEN}✅ shadcn/ui configured${NC}"

# Add some initial shadcn/ui components
echo -e "${BLUE}📦 Adding essential shadcn/ui components...${NC}"
npx shadcn-ui@latest add button card badge --yes

# Create example custom component
cat > components/custom/welcome-card.tsx << 'EOF'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Badge } from "@/components/ui/badge"

export function WelcomeCard() {
  return (
    <Card className="w-full max-w-2xl">
      <CardHeader>
        <div className="flex items-center justify-between">
          <CardTitle className="text-2xl">Welcome to Your Cursor Project</CardTitle>
          <Badge variant="secondary">v1.0.0</Badge>
        </div>
        <CardDescription>
          A complete starter template with Next.js, shadcn/ui, and knowledge capture system
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-4">
        <div className="space-y-2">
          <h3 className="font-semibold">Quick Actions</h3>
          <div className="flex gap-2">
            <Button variant="default">Get Started</Button>
            <Button variant="outline">View Docs</Button>
            <Button variant="ghost">Explore Components</Button>
          </div>
        </div>
        <div className="text-sm text-muted-foreground">
          <p>✨ Start coding with Cursor AI</p>
          <p>📚 Document insights as you develop</p>
          <p>🎨 Build beautiful UIs with shadcn/ui</p>
        </div>
      </CardContent>
    </Card>
  )
}
EOF

# Update the main page
cat > app/page.tsx << 'EOF'
import { WelcomeCard } from "@/components/custom/welcome-card"

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-24">
      <div className="z-10 w-full max-w-5xl items-center justify-between font-mono text-sm">
        <WelcomeCard />
      </div>
    </main>
  )
}
EOF

echo -e "${GREEN}✅ UI components added${NC}"

# Setup TweakCN for Tailwind optimization
echo -e "${BLUE}⚡ Setting up TweakCN for Tailwind optimization...${NC}"

# Create tweakcn configuration
cat > tweakcn.config.json << 'EOF'
{
  "include": [
    "./app/**/*.{js,ts,jsx,tsx}",
    "./components/**/*.{js,ts,jsx,tsx}",
    "./lib/**/*.{js,ts,jsx,tsx}"
  ],
  "exclude": [
    "./node_modules/**",
    "./.next/**",
    "./dist/**"
  ],
  "tailwindConfig": "./tailwind.config.ts",
  "output": {
    "css": "./app/globals.optimized.css",
    "report": "./tweakcn-report.json"
  },
  "options": {
    "preserveImportant": true,
    "preserveKeyframes": true,
    "preserveVariables": true,
    "minify": true
  }
}
EOF

# Update package.json scripts
npm pkg set scripts.analyze="tweakcn analyze"
npm pkg set scripts.optimize="tweakcn optimize"
npm pkg set scripts.build="tweakcn optimize && next build"
npm pkg set scripts.dev="next dev"
npm pkg set scripts.start="next start"
npm pkg set scripts.lint="next lint"
npm pkg set scripts.type-check="tsc --noEmit"
npm pkg set scripts.format="prettier --write ."
npm pkg set scripts.clean="rm -rf .next node_modules"

echo -e "${GREEN}✅ TweakCN configured${NC}"

# Create knowledge base scripts
mkdir -p scripts

# Create basic scripts
cat > scripts/new-session.sh << 'EOF'
#!/bin/bash
# Start a new development session
SESSION_ID=$(date +"%Y%m%d-%H%M")
mkdir -p docs/session-notes
cat > "docs/session-notes/session-${SESSION_ID}.md" << 'SESSION_EOF'
# Development Session - $(date +"%Y-%m-%d %H:%M")

## 🎯 Session Goals
- [ ] Goal 1
- [ ] Goal 2

## 📝 Notes
<!-- Add your development notes here -->

## ✅ Completed Tasks
<!-- What was accomplished -->

---
*Session ID: ${SESSION_ID}*
*Started: $(date +"%Y-%m-%d %H:%M")*
SESSION_EOF
echo "✅ New session started: docs/session-notes/session-${SESSION_ID}.md"
EOF

cat > scripts/end-session.sh << 'EOF'
#!/bin/bash
# End current development session
LATEST_SESSION=$(find docs/session-notes -name "session-*.md" -type f | sort | tail -n 1)
if [ -n "$LATEST_SESSION" ]; then
    echo "" >> "$LATEST_SESSION"
    echo "## 🏁 Session End" >> "$LATEST_SESSION"
    echo "**Ended:** $(date +"%Y-%m-%d %H:%M")" >> "$LATEST_SESSION"
    echo "✅ Session ended successfully"
else
    echo "⚠️  No session file found. Run ./scripts/new-session.sh first."
fi
EOF

cat > scripts/create-adr.sh << 'EOF'
#!/bin/bash
# Create an Architecture Decision Record
if [ $# -eq 0 ]; then
    echo "Usage: $0 \"Decision Title\""
    exit 1
fi
DECISION_TITLE="$1"
DECISION_ID=$(date +"%Y%m%d")
mkdir -p docs/decisions
cat > "docs/decisions/adr-${DECISION_ID}.md" << 'ADR_EOF'
# ADR-${DECISION_ID}: ${DECISION_TITLE}

## Status
Proposed

## Context
<!-- Describe the context and problem statement -->

## Decision
<!-- Describe the decision that was made -->

## Consequences
### Positive
<!-- List positive consequences -->

### Negative
<!-- List negative consequences -->

---
*Created: $(date +"%Y-%m-%d")*
ADR_EOF
echo "✅ ADR created: docs/decisions/adr-${DECISION_ID}.md"
EOF

# Make scripts executable
chmod +x scripts/*.sh

echo -e "${GREEN}✅ Knowledge base scripts created${NC}"

# Create Cursor rules
echo -e "${BLUE}🤖 Creating Cursor AI rules...${NC}"

cat > .cursorrules << 'EOF'
# Cursor AI Rules for Cursor Project Starter

## Project Overview
This is a Next.js 14 project with shadcn/ui components, TypeScript, and TweakCN optimization.
Focus on modern React patterns, performance, and maintainable code.

## Code Style & Patterns
- Use functional components with hooks
- Prefer TypeScript for all components
- Use proper prop typing with interfaces
- Import components from "@/components/ui/"
- Use the cn() utility for conditional classes
- Follow shadcn/ui patterns for variants
- Use Tailwind CSS classes for styling
- Implement proper error boundaries
- Use Next.js Image component for images
- Document complex logic with comments

## File Organization
- Components in /components/ui/ (shadcn/ui) or /components/custom/ (business logic)
- Utilities in /lib/
- Types in /types/ or co-located with components
- API routes in /app/api/
- Pages in /app/ following Next.js 13+ conventions

## Performance Guidelines
- Use React.memo for expensive components
- Implement proper loading states
- Use Next.js optimization features
- Monitor bundle size with TweakCN
- Use proper caching strategies

## Documentation
- Document complex logic
- Add JSDoc comments for functions
- Update README.md with new features
- Create ADRs for major decisions
- Maintain session notes for learnings
EOF

echo -e "${GREEN}✅ Cursor rules created${NC}"

# Create a comprehensive README
echo -e "${BLUE}📚 Creating project README...${NC}"

cat > README.md << 'EOF'
# Cursor Project Starter

A comprehensive starter template for Cursor AI projects with Next.js, shadcn/ui, and a built-in knowledge capture system.

[![GitHub](https://img.shields.io/badge/GitHub-Repository-181717?logo=github)](https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started)
[![GitHub Stars](https://img.shields.io/github/stars/vidhunnan/cursor-shadcnui-next-js-get-started?style=social)](https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started)
[![GitHub Forks](https://img.shields.io/github/forks/vidhunnan/cursor-shadcnui-next-js-get-started?style=social)](https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started)

## 🚀 Quick Start

```bash
# Install dependencies
npm install

# Run development server
npm run dev
```

## 📦 What's Included

### Tech Stack
- **Next.js 14** - React framework with App Router
- **TypeScript** - Type safety and better DX
- **Tailwind CSS** - Utility-first CSS framework
- **shadcn/ui** - High-quality React components
- **TweakCN** - Tailwind CSS optimization (90%+ size reduction)
- **Knowledge Base System** - Documentation and insight capture

### Project Structure
```
my-project/
├── app/                    # Next.js App Router
│   ├── layout.tsx         # Root layout
│   ├── page.tsx           # Home page
│   └── globals.css        # Global styles
├── components/            # React components
│   ├── ui/               # shadcn/ui components
│   └── custom/           # Your custom components
├── lib/                   # Utility functions
│   └── utils.ts          # Helper functions
├── docs/                  # Documentation (created by setup)
│   ├── development-notes/
│   ├── decisions/
│   ├── session-notes/
│   └── tweakcn-guide.md  # TweakCN optimization guide
├── scripts/              # Development scripts
│   ├── new-session.sh
│   └── end-session.sh
├── public/               # Static assets
├── .cursorrules         # Cursor AI rules
├── components.json      # shadcn/ui config
├── tweakcn.config.json  # TweakCN optimization config
├── tailwind.config.ts   # Tailwind configuration
├── tsconfig.json        # TypeScript config
└── package.json         # Dependencies
```

## 🛠️ Setup Instructions

### 1. Initial Setup
```bash
# Install dependencies
npm install
```

### 2. Add shadcn/ui Components
```bash
# Add a component (e.g., Button)
npx shadcn-ui@latest add button

# Add multiple components
npx shadcn-ui@latest add card badge dialog
```

### 3. Start Development
```bash
# Development server
npm run dev

# Start a coding session
./scripts/new-session.sh
```

## 📚 Knowledge Base System

### Session Management
- **Start Session**: `./scripts/new-session.sh` - Creates timestamped session notes
- **End Session**: `./scripts/end-session.sh` - Updates documentation with insights
- **Create ADR**: `./scripts/create-adr.sh "Decision Title"` - Document architecture decisions

### Documentation Structure
- **Development Notes**: Technical learnings, troubleshooting, architecture decisions
- **ADRs**: Architecture Decision Records for major choices
- **Session Notes**: Daily development insights and problem solutions

## 🎨 UI Components

### Available shadcn/ui Components
After setup, you can add any shadcn/ui component:
```bash
# Examples
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

## 🧩 Development Workflow

### 1. Daily Development
```bash
# Start your day
./scripts/new-session.sh

# Code with Cursor AI
# Document insights in session notes

# End your day
./scripts/end-session.sh
```

### 2. Making Decisions
```bash
# Create an ADR for major decisions
./scripts/create-adr.sh "Use Server Components for Data Fetching"
```

### 3. Troubleshooting
- Check `docs/development-notes/troubleshooting-guide.md`
- Add new solutions as you discover them
- Update `.cursorrules` with patterns

## 🔧 Configuration

### Cursor Rules (.cursorrules)
The `.cursorrules` file contains:
- Project-specific coding guidelines
- Common patterns and best practices
- Error handling strategies
- Performance considerations

### TypeScript (tsconfig.json)
Pre-configured with:
- Strict mode enabled
- Path aliases (@/ for imports)
- Next.js optimizations

### Tailwind CSS
- Configured with shadcn/ui defaults
- Custom color schemes ready
- Dark mode support built-in

## 📝 Best Practices

### Code Organization
- **Components**: Keep in `/components` with clear naming
- **Utilities**: Shared functions in `/lib/utils.ts`
- **Types**: Create `/types` directory for shared TypeScript types
- **API Routes**: Use `/app/api` for backend endpoints

### Documentation
- Update `.cursorrules` with new patterns
- Create ADRs for significant decisions
- Maintain troubleshooting guide
- Use session notes for daily insights

### Git Workflow
```bash
# Feature branch
git checkout -b feature/your-feature

# Commit with clear messages
git add .
git commit -m "feat: add user authentication"

# Push and create PR
git push origin feature/your-feature
```

## 🚨 Common Issues

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

## 📦 Scripts

```json
{
  "dev": "next dev",
  "build": "tweakcn optimize && next build",
  "start": "next start",
  "lint": "next lint",
  "type-check": "tsc --noEmit",
  "format": "prettier --write .",
  "clean": "rm -rf .next node_modules",
  "analyze": "tweakcn analyze",
  "optimize": "tweakcn optimize"
}
```

### TweakCN Commands
- **Analyze CSS usage**: `npm run analyze` - See which Tailwind classes are used/unused
- **Optimize CSS**: `npm run optimize` - Create optimized CSS file for production
- **Auto-optimization**: `npm run build` - Automatically optimizes before building

## 🤝 Contributing

We welcome contributions! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch
3. Document your changes
4. Update tests if applicable
5. Submit a pull request

## 📄 License

MIT License - feel free to use this template for your projects!

## 🔗 Repository

- **GitHub**: [https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started](https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started)
- **Issues**: [https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started/issues](https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started/issues)
- **Discussions**: [https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started/discussions](https://github.com/vidhunnan/cursor-shadcnui-next-js-get-started/discussions)

## 🙏 Acknowledgments

- [Next.js](https://nextjs.org/) - The React Framework
- [shadcn/ui](https://ui.shadcn.com/) - Beautiful component library
- [Tailwind CSS](https://tailwindcss.com/) - Utility-first CSS
- [Cursor](https://cursor.sh/) - AI-powered code editor
EOF

echo -e "${GREEN}✅ Project README created${NC}"

# Create .gitignore
cat > .gitignore << 'EOF'
# See https://help.github.com/articles/ignoring-files/ for more about ignoring files.

# dependencies
/node_modules
/.pnp
.pnp.js
.yarn/install-state.gz

# testing
/coverage

# next.js
/.next/
/out/

# production
/build

# misc
.DS_Store
*.pem

# debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# local env files
.env*.local

# vercel
.vercel

# typescript
*.tsbuildinfo
next-env.d.ts

# TweakCN
tweakcn-report.json
app/globals.optimized.css

# IDE
.vscode/
.idea/

# OS
Thumbs.db
EOF

echo -e "${GREEN}✅ .gitignore created${NC}"

# Initialize git repository
git init
git add .
git commit -m "Initial commit: Cursor Project Starter Template"

echo ""
echo -e "${GREEN}🎉 Project setup complete!${NC}"
echo ""
echo -e "${BLUE}📁 Project created in: $(pwd)${NC}"
echo ""
echo -e "${YELLOW}🚀 Next steps:${NC}"
echo "1. cd $PROJECT_NAME"
echo "2. npm run dev"
echo "3. ./scripts/new-session.sh"
echo ""
echo -e "${CYAN}📚 For detailed documentation, see:${NC}"
echo "  - README.md - Complete project guide"
echo "  - docs/ - Knowledge base system"
echo "  - .cursorrules - Cursor AI guidelines"
echo ""
echo -e "${GREEN}✨ Happy coding with Cursor AI!${NC}"