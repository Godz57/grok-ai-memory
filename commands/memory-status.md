---
description: Check ai-memory CLI, server, and Grok hooks
---

# /memory-status

1. Load skill `ai-memory` preflight section.
2. Check:
   - `ai-memory` on PATH
   - `ai-memory status` output if CLI works
   - HTTP reachability of `http://127.0.0.1:49374` (or `$env:AI_MEMORY_SERVER_URL`)
   - Hook file exists: `~/.grok/hooks/ai-memory.json` or list `~/.grok/hooks/`
3. Report table: CLI | Server | Hooks | MCP (if detectable in config).
4. If missing pieces: link user to wrapper `docs/grok-pi-setup.md` and upstream install.
5. Remind: on Grok, handoff is **manual** via `/memory-handoff`.
