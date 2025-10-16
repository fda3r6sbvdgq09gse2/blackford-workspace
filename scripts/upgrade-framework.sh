#!/bin/bash
# upgrade-framework.sh
# Upgrades Claude-Dev-Framework to a new version
#
# Usage: ./scripts/upgrade-framework.sh [version]
# Example: ./scripts/upgrade-framework.sh v2.0.0
#
# This script:
# 1. Updates STARTUP_VARIABLES.yaml with new version
# 2. Syncs .claude/settings.json
# 3. Validates the configuration
# 4. Provides rollback instructions

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Check arguments
if [ $# -eq 0 ]; then
    print_error "No version specified"
    echo "Usage: ./scripts/upgrade-framework.sh [version]"
    echo "Example: ./scripts/upgrade-framework.sh v2.0.0"
    echo ""
    echo "Available versions:"
    gh api repos/fda3r6sbvdgq09gse2/claude-dev-framework/git/refs/tags | jq -r '.[].ref' | sed 's|refs/tags/||'
    exit 1
fi

NEW_VERSION=$1

# Remove 'v' prefix if present for YAML, keep for git ref
VERSION_FOR_YAML="${NEW_VERSION#v}"
VERSION_FOR_GIT="$NEW_VERSION"
if [[ ! $VERSION_FOR_GIT =~ ^v ]]; then
    VERSION_FOR_GIT="v$VERSION_FOR_GIT"
fi

print_header "Claude-Dev-Framework Upgrade"
echo ""
print_info "Target version: $VERSION_FOR_YAML"
echo ""

# Step 1: Check current version
print_info "Checking current version..."
CURRENT_VERSION=$(grep "version:" STARTUP_VARIABLES.yaml | head -1 | awk '{print $2}' | tr -d '"')
print_info "Current version: $CURRENT_VERSION"

if [ "$CURRENT_VERSION" = "$VERSION_FOR_YAML" ]; then
    print_warning "Already on version $VERSION_FOR_YAML"
    exit 0
fi

# Step 2: Verify target version exists
print_info "Verifying version $VERSION_FOR_GIT exists..."
if ! gh api repos/fda3r6sbvdgq09gse2/claude-dev-framework/git/refs/tags/$VERSION_FOR_GIT > /dev/null 2>&1; then
    print_error "Version $VERSION_FOR_GIT not found in claude-dev-framework"
    echo ""
    echo "Available versions:"
    gh api repos/fda3r6sbvdgq09gse2/claude-dev-framework/git/refs/tags | jq -r '.[].ref' | sed 's|refs/tags/||'
    exit 1
fi
print_success "Version $VERSION_FOR_GIT exists"

# Step 3: Backup current configuration
print_info "Creating backup..."
BACKUP_FILE="STARTUP_VARIABLES.yaml.backup.$(date +%Y%m%d_%H%M%S)"
cp STARTUP_VARIABLES.yaml "$BACKUP_FILE"
print_success "Backed up to $BACKUP_FILE"

# Step 4: Update STARTUP_VARIABLES.yaml
print_info "Updating STARTUP_VARIABLES.yaml..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i "" "s/version: \"${CURRENT_VERSION}\"/version: \"${VERSION_FOR_YAML}\"/" STARTUP_VARIABLES.yaml
else
    # Linux
    sed -i "s/version: \"${CURRENT_VERSION}\"/version: \"${VERSION_FOR_YAML}\"/" STARTUP_VARIABLES.yaml
fi
print_success "Updated STARTUP_VARIABLES.yaml"

# Step 5: Sync .claude/settings.json
print_info "Syncing .claude/settings.json..."
MARKETPLACE_REPO=$(grep "marketplace_repo:" STARTUP_VARIABLES.yaml | awk '{print $2}' | tr -d '"')

cat > .claude/settings.json <<EOF
{
  "\$schema": "https://api.claude.com/schemas/settings.json",
  "extraKnownMarketplaces": {
    "Claude-Dev-Framework": {
      "source": {
        "source": "github",
        "repo": "${MARKETPLACE_REPO}",
        "ref": "${VERSION_FOR_GIT}"
      }
    }
  },
  "annotations": {
    "_comment_1": "This settings file configures Claude Code to use the Claude-Dev-Framework marketplace",
    "_comment_2": "The framework provides specialized agents for multi-agent development",
    "_comment_3": "To upgrade: change 'ref' from '${VERSION_FOR_GIT}' to newer version",
    "_comment_4": "See STARTUP_VARIABLES.yaml for company-specific configuration",
    "_reference": "[[STARTUP_VARIABLES.yaml:39]] - framework.version"
  }
}
EOF
print_success "Synced .claude/settings.json"

# Step 6: Show what changed
print_header "Changes Made"
echo ""
echo "STARTUP_VARIABLES.yaml:"
echo "  Old version: $CURRENT_VERSION"
echo "  New version: $VERSION_FOR_YAML"
echo ""
echo ".claude/settings.json:"
echo "  Framework ref: $VERSION_FOR_GIT"
echo ""

# Step 7: Test (optional - would require Claude Code restart)
print_header "Next Steps"
echo ""
print_info "1. Review the changes:"
echo "   git diff STARTUP_VARIABLES.yaml .claude/settings.json"
echo ""
print_info "2. Test the upgrade:"
echo "   cd projects/your-project && claude"
echo "   # Verify framework agents load correctly"
echo ""
print_info "3. If everything works, commit:"
echo "   git add STARTUP_VARIABLES.yaml .claude/settings.json"
echo "   git commit -m \"chore: Upgrade Claude-Dev-Framework to $VERSION_FOR_YAML\""
echo ""
print_warning "4. If something breaks, rollback:"
echo "   cp $BACKUP_FILE STARTUP_VARIABLES.yaml"
echo "   ./scripts/upgrade-framework.sh $CURRENT_VERSION"
echo ""

# Step 8: Changelog (if available)
print_info "Checking for changelog..."
if gh api repos/fda3r6sbvdgq09gse2/claude-dev-framework/releases/tags/$VERSION_FOR_GIT > /dev/null 2>&1; then
    echo ""
    print_header "Release Notes: $VERSION_FOR_GIT"
    gh api repos/fda3r6sbvdgq09gse2/claude-dev-framework/releases/tags/$VERSION_FOR_GIT | jq -r '.body'
fi

echo ""
print_success "Upgrade complete!"
print_info "Restart Claude Code to load the new framework version"
