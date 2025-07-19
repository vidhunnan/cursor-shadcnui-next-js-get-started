#!/bin/bash

# Start a new development session
# Creates timestamped session notes

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Get current date and time
SESSION_DATE=$(date +"%Y-%m-%d")
SESSION_TIME=$(date +"%H:%M")
SESSION_ID=$(date +"%Y%m%d-%H%M")

# Create session notes file
SESSION_FILE="docs/session-notes/session-${SESSION_ID}.md"

# Create session notes directory if it doesn't exist
mkdir -p docs/session-notes

# Create session notes template
cat > "$SESSION_FILE" << EOF
# Development Session - ${SESSION_DATE} ${SESSION_TIME}

## 🎯 Session Goals
- [ ] Goal 1
- [ ] Goal 2
- [ ] Goal 3

## 📝 Notes
<!-- Add your development notes here -->

## 🔧 Technical Decisions
<!-- Document any technical decisions made -->

## 🐛 Issues Encountered
<!-- List any problems and their solutions -->

## ✅ Completed Tasks
<!-- What was accomplished -->

## 📚 Learnings
<!-- New things learned during this session -->

## 🔄 Next Steps
<!-- What to work on next -->

---
*Session ID: ${SESSION_ID}*
*Started: ${SESSION_DATE} ${SESSION_TIME}*
EOF

echo -e "${GREEN}✅ New session started: ${SESSION_FILE}${NC}"
echo -e "${BLUE}📝 Session ID: ${SESSION_ID}${NC}"
echo -e "${YELLOW}💡 Tip: Update your session notes as you work!${NC}"
echo ""
echo -e "${BLUE}📋 Quick commands:${NC}"
echo "  - npm run dev          # Start development server"
echo "  - npm run type-check   # Check TypeScript"
echo "  - npm run analyze      # Analyze CSS usage"
echo "  - ./scripts/end-session.sh  # End session when done" 