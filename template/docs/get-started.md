# 📚 Knowledge Base System

This directory contains the Knowledge Base system for capturing development insights, decisions, and learnings.

## 🗂️ Structure

```
docs/
├── get-started.md              # This file - Knowledge Base overview
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

## 🚀 Quick Start

| Action | Command | Description | Output |
|--------|---------|-------------|---------|
| **Start Development Session** | `./scripts/new-session.sh` | Creates timestamped session notes for daily development | `docs/session-notes/session-YYYYMMDD-HHMM.md` |
| **End Development Session** | `./scripts/end-session.sh` | Updates session with end time and summary | Updates existing session file |
| **Create ADR** | `./scripts/create-adr.sh "Decision Title"` | Creates Architecture Decision Record | `docs/decisions/adr-YYYYMMDD.md` |
| **View Knowledge Base** | `ls docs/` | Lists all documentation directories | Shows structure overview |
| **Browse Development Notes** | `ls docs/development-notes/` | Lists technical guides and learnings | Shows available guides |
| **Check Session History** | `ls docs/session-notes/` | Lists all development sessions | Shows session timeline |
| **Review Decisions** | `ls docs/decisions/` | Lists all Architecture Decision Records | Shows decision history |

### Example Usage
```bash
# Start your day
./scripts/new-session.sh

# During development, document insights in the session file
# Create ADRs for important decisions
./scripts/create-adr.sh "Use Server Components for Data Fetching"

# End your day
./scripts/end-session.sh
```

## 📝 How to Use

### **Daily Development Workflow**

| Step | Command | What Happens | File Created/Updated |
|------|---------|--------------|---------------------|
| **1. Start Day** | `./scripts/new-session.sh` | Creates new session file with timestamp | `docs/session-notes/session-20241201-1430.md` |
| **2. Code & Document** | Edit session file manually | Add insights, problems, solutions as you work | Updates session file in real-time |
| **3. Create ADRs** | `./scripts/create-adr.sh "Decision Title"` | Documents important technical decisions | `docs/decisions/adr-20241201.md` |
| **4. Add Notes** | Create files in `development-notes/` | Document learnings and patterns | New `.md` files in development-notes |
| **5. End Day** | `./scripts/end-session.sh` | Adds end time and summary to session | Updates session file with completion |

### **Documentation Types**

| Type | Location | Purpose | Creation Method |
|------|----------|---------|-----------------|
| **Session Notes** | `docs/session-notes/` | Daily development insights | `./scripts/new-session.sh` |
| **ADRs** | `docs/decisions/` | Architecture decisions | `./scripts/create-adr.sh` |
| **Development Notes** | `docs/development-notes/` | Technical guides & learnings | Manual file creation |
| **Troubleshooting** | `docs/development-notes/` | Problem solutions | Manual file creation |
| **Performance Notes** | `docs/development-notes/` | Optimization insights | Manual file creation |
| **Security Notes** | `docs/development-notes/` | Security considerations | Manual file creation |

### **Quick Commands Reference**

| Task | Command | Notes |
|------|---------|-------|
| Start session | `./scripts/new-session.sh` | Creates timestamped file |
| End session | `./scripts/end-session.sh` | Updates with end time |
| Create ADR | `./scripts/create-adr.sh "Title"` | Use quotes for multi-word titles |
| List sessions | `ls docs/session-notes/` | See all development sessions |
| List ADRs | `ls docs/decisions/` | See all decisions made |
| View structure | `tree docs/` | See full documentation tree |

## 🎯 Best Practices

### **Session Notes**
- Update session notes as you work, not just at the end
- Document both successes and failures
- Include code snippets and solutions
- Note any new learnings or patterns

### **ADRs (Architecture Decision Records)**
- Create ADRs for significant technical decisions
- Include context, alternatives considered, and consequences
- Update status as decisions are implemented
- Reference ADRs in code comments

### **Development Notes**
- Organize by topic (performance, security, patterns)
- Include practical examples and code
- Update guides as you discover new solutions
- Share with team members

## 📊 Example Workflow

### **Morning Session Start**
```bash
./scripts/new-session.sh
# Creates: docs/session-notes/session-20241201-1430.md
```

### **During Development**
- Document insights in session file
- Create ADRs for decisions
- Update development notes with learnings

### **Evening Session End**
```bash
./scripts/end-session.sh
# Updates session file with end time and summary
```

## 🔧 Customization

### **Adding New Note Types**
Create new directories in `docs/` for different types of documentation:
- `docs/api-notes/` - API design decisions
- `docs/ui-notes/` - UI/UX patterns
- `docs/testing-notes/` - Testing strategies

### **Customizing Templates**
- Modify `scripts/new-session.sh` for custom session templates
- Update `scripts/create-adr.sh` for custom ADR formats
- Create new scripts for specific documentation needs

## 📈 Benefits

### **Knowledge Retention**
- Capture insights before they're forgotten
- Build institutional knowledge
- Share learnings across team members

### **Decision Tracking**
- Document why decisions were made
- Avoid repeating past discussions
- Provide context for future changes

### **Problem Solving**
- Build a troubleshooting knowledge base
- Share solutions across projects
- Reduce time spent on common issues

## 🎉 Getting Started

### **First-Time Setup**

| Step | Command | Expected Result | Troubleshooting |
|------|---------|-----------------|-----------------|
| **1. Check Scripts** | `ls scripts/` | Should show: `new-session.sh`, `end-session.sh`, `create-adr.sh` | If missing, run project setup again |
| **2. Make Executable** | `chmod +x scripts/*.sh` | Scripts become executable | Run if you get "Permission denied" |
| **3. Start Session** | `./scripts/new-session.sh` | Creates `docs/session-notes/session-YYYYMMDD-HHMM.md` | Check if `docs/` directory exists |
| **4. Create ADR** | `./scripts/create-adr.sh "First Decision"` | Creates `docs/decisions/adr-YYYYMMDD.md` | Use quotes for multi-word titles |
| **5. End Session** | `./scripts/end-session.sh` | Updates session file with end time | Must have an active session file |

### **Common Issues & Solutions**

| Issue | Error Message | Solution |
|-------|---------------|----------|
| **Permission Denied** | `bash: ./scripts/new-session.sh: Permission denied` | `chmod +x scripts/*.sh` |
| **Script Not Found** | `bash: ./scripts/new-session.sh: No such file or directory` | Check if scripts directory exists: `ls scripts/` |
| **No Session to End** | `No session file found` | Run `./scripts/new-session.sh` first |
| **Directory Missing** | `mkdir: cannot create directory` | Create docs directory: `mkdir -p docs/session-notes docs/decisions` |
| **Invalid ADR Title** | Script fails with special characters | Use simple titles with quotes: `./scripts/create-adr.sh "Simple Title"` |

### **Verification Commands**

| Command | Purpose | Expected Output |
|---------|---------|-----------------|
| `ls scripts/` | Check if scripts exist | `new-session.sh`, `end-session.sh`, `create-adr.sh` |
| `ls docs/` | Check documentation structure | `development-notes/`, `decisions/`, `session-notes/` |
| `ls docs/session-notes/` | Check for existing sessions | List of session files (if any) |
| `ls docs/decisions/` | Check for existing ADRs | List of ADR files (if any) |
| `./scripts/new-session.sh` | Test session creation | Creates new session file |

---

**Happy documenting! 📚** 