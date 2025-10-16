#!/bin/bash
# Launch Claude Opus for Strategic Review
# This script prepares and launches Opus for high-level strategic guidance

echo "═══════════════════════════════════════════════════════════"
echo "🧠 CLAUDE OPUS STRATEGIC REVIEW"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "Preparing Opus session..."
echo ""
echo "✅ Briefing document ready: .ai/meta/opus-strategic-briefing.md"
echo "✅ Output will be saved to: .ai/meta/opus-strategic-review-$(date +%Y-%m-%d).md"
echo ""
echo "═══════════════════════════════════════════════════════════"
echo "📋 LAUNCHING CLAUDE CODE (opusplan mode)"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "Model: opusplan (Opus for planning, Sonnet for execution)"
echo "Mode: PLAN mode for strategic review"
echo "Estimated cost: ~$2-3 (50K tokens @ Opus pricing)"
echo "Estimated time: 3-5 minutes"
echo ""
echo "Starting opusplan session..."
echo ""

# Launch Claude Code with opusplan (hybrid Opus+Sonnet)
cd /Users/z/dev/blackford-workspace
claude --model opusplan
