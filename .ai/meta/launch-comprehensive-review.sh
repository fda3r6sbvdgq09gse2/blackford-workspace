#!/bin/bash
# Comprehensive System Review: Framework + Template + Meta-System
# Uses opusplan for strategic review across all repositories

echo "═══════════════════════════════════════════════════════════"
echo "🏗️  COMPREHENSIVE SYSTEM REVIEW"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "Reviewing:"
echo "  ✅ claude-dev-framework (v1.0.0)"
echo "  ✅ claude-workspace-template (v1.1.0)"
echo "  ✅ blackford-workspace meta-system"
echo "  ✅ Knowledge compounding ecosystem"
echo ""
echo "═══════════════════════════════════════════════════════════"
echo "📊 ESTIMATED COST & TIME"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "Token Budget: ~100-150K tokens"
echo "Estimated Cost: ~\$5-8 (Opus pricing)"
echo "Estimated Time: 10-15 minutes"
echo ""
echo "Worth it? YES! This will guide v2.0 development."
echo ""
echo "═══════════════════════════════════════════════════════════"
echo "🚀 LAUNCHING OPUSPLAN (PLAN MODE)"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "Briefing ready: .ai/meta/comprehensive-system-review-briefing.md"
echo "Output will be: .ai/meta/comprehensive-system-review-$(date +%Y-%m-%d).md"
echo ""
echo "Starting comprehensive review session..."
echo ""

# Launch opusplan from blackford-workspace
cd /Users/z/dev/blackford-workspace
claude --model opusplan
