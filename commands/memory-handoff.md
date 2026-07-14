---
description: Accept ai-memory handoff (required on Grok - no auto SessionStart inject)
---

# /memory-handoff

Grok does **not** auto-inject handoff on session start. This command recovers it.

1. Preflight server/CLI.
2. Prefer MCP tool `memory_handoff_accept` if available in this session.
3. Else try CLI if documented (e.g. handoff-related subcommands) or instruct user to ensure MCP is installed.
4. Present:
   - where we left off
   - open questions
   - next steps
   - session summary (short)
5. Ask if they want to continue that work now.

If no pending handoff: say so; offer `/memory-search` or bootstrap.
