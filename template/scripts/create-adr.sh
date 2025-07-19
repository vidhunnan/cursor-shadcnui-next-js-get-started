#!/bin/bash

# Create an Architecture Decision Record (ADR)
# Documents important technical decisions

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [ $# -eq 0 ]; then
    echo -e "${YELLOW}Usage: $0 \"Decision Title\"${NC}"
    echo -e "${YELLOW}Example: $0 \"Use Server Components for Data Fetching\"${NC}"
    exit 1
fi

DECISION_TITLE="$1"
DECISION_ID=$(date +"%Y%m%d")
DECISION_FILE="docs/decisions/adr-${DECISION_ID}.md"

# Create decisions directory if it doesn't exist
mkdir -p docs/decisions

# Create ADR template
cat > "$DECISION_FILE" << EOF
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
<!-- List negative consequences or trade-offs -->

### Neutral
<!-- List neutral consequences -->

## Alternatives Considered
<!-- List alternatives that were considered -->

## Implementation Notes
<!-- Any notes about implementation -->

---
*Created: $(date +"%Y-%m-%d")*
*Decision ID: ADR-${DECISION_ID}*
EOF

echo -e "${GREEN}✅ ADR created: ${DECISION_FILE}${NC}"
echo -e "${BLUE}📝 Decision ID: ADR-${DECISION_ID}${NC}"
echo ""
echo -e "${YELLOW}💡 Next steps:${NC}"
echo "  1. Fill in the context and problem statement"
echo "  2. Document the decision and reasoning"
echo "  3. List consequences and alternatives"
echo "  4. Update status when implemented" 