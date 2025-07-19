#!/bin/bash

# End current development session
# Updates session notes with end time and summary

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Get current date and time
END_DATE=$(date +"%Y-%m-%d")
END_TIME=$(date +"%H:%M")

echo -e "${BLUE}🔚 Ending development session...${NC}"

# Find the most recent session file
LATEST_SESSION=$(find docs/session-notes -name "session-*.md" -type f | sort | tail -n 1)

if [ -z "$LATEST_SESSION" ]; then
    echo -e "${YELLOW}⚠️  No session file found. Run ./scripts/new-session.sh first.${NC}"
    exit 1
fi

echo -e "${GREEN}📝 Updating session: ${LATEST_SESSION}${NC}"

# Add end time to session file
echo "" >> "$LATEST_SESSION"
echo "## 🏁 Session End" >> "$LATEST_SESSION"
echo "**Ended:** ${END_DATE} ${END_TIME}" >> "$LATEST_SESSION"

# Calculate session duration if start time is available
if grep -q "Started:" "$LATEST_SESSION"; then
    START_TIME=$(grep "Started:" "$LATEST_SESSION" | tail -n 1 | sed 's/.*Started: //')
    echo "**Duration:** Calculated from start time" >> "$LATEST_SESSION"
fi

echo "" >> "$LATEST_SESSION"
echo "## 📊 Session Summary" >> "$LATEST_SESSION"
echo "<!-- Add a brief summary of what was accomplished -->" >> "$LATEST_SESSION"

echo -e "${GREEN}✅ Session ended successfully${NC}"
echo -e "${YELLOW}💡 Don't forget to commit your changes!${NC}"
echo ""
echo -e "${BLUE}📋 Quick git commands:${NC}"
echo "  - git add .              # Stage all changes"
echo "  - git commit -m \"feat: session summary\"  # Commit changes"
echo "  - git push               # Push to remote" 