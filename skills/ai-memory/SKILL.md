---
name: ai-memory
description: >
  Long-term project memory via akitaonrails/ai-memory server. Capture handoffs
  between Grok and Pi, search wiki, save permanent notes. Use when user asks
  where we left off, search memory, handoff, /memory, /memory-handoff,
  /memory-search, /memory-status, or continues work across agents/sessions.
  Does not reimplement the Rust server.
metadata:
  short-description: "Cross-agent memory handoff (Grok+Pi)"
  author: "Grok wrapper for akitaonrails/ai-memory"
---

# ai-memory (Grok wrapper)

You help the user **use** the [ai-memory](https://github.com/akitaonrails/ai-memory)
server. You do **not** reimplement storage.

Announce: `Using ai-memory — project wiki + handoff.`

## Grok-specific truth

| Feature | On Grok |
|---------|---------|
| Lifecycle capture | Yes (hooks `--agent grok`) |
| Auto-inject handoff on SessionStart | **No** (Grok ignores that stdout) |
| Get handoff | MCP `memory_handoff_accept` or CLI equivalent |
| Search | MCP `memory_query` or `ai-memory search` |
| Write durable note | MCP `memory_write_page` or `ai-memory write-page` |

**Always** offer `/memory-handoff` when the user returns mid-task or says
"continue where we left off" / "onde paramos".

## Preflight

```bash
# CLI present?
command -v ai-memory || where ai-memory

# Server up? (loopback default)
curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:49374/ 2>/dev/null
# or: ai-memory status
```

PowerShell:

```powershell
Get-Command ai-memory -ErrorAction SilentlyContinue
ai-memory status 2>&1
try { (Invoke-WebRequest -Uri http://127.0.0.1:49374/ -UseBasicParsing -TimeoutSec 2).StatusCode } catch { "down" }
```

If server down: point to `docs/grok-pi-setup.md` / Docker quick start. Do not fake memory hits.

## Tools (prefer MCP if available)

When MCP tools exist in the session, use them:

| Intent | Tool / CLI |
|--------|------------|
| Accept handoff | `memory_handoff_accept` |
| Search | `memory_query` / `ai-memory search "q"` |
| Catch-up digest | tools that map to briefing/overview if present; else search + recent |
| Permanent note | `memory_write_page` with pinned; CLI: `ai-memory write-page --path ... --body ... --pinned` |
| Consolidate | `memory_consolidate` if available |
| Bootstrap project | `ai-memory bootstrap` in repo root (shell) |

If MCP is **not** wired, use CLI against `AI_MEMORY_SERVER_URL` (default `http://127.0.0.1:49374`).

## Workflows

### A) Resume session

1. Preflight  
2. Call handoff accept  
3. Summarize open questions + next steps for the user  
4. Continue the coding task with that context  

### B) Search

1. Run search with user query  
2. Cite page paths / titles  
3. Offer to open/read specific wiki paths if CLI exposes them  

### C) Save permanent decision

1. Confirm wording with user if ambiguous  
2. Write pinned page under something like `decisions/...` or project convention  
3. Confirm path written  

### D) Pi interoperability

Remind: Pi uses the **same server**. Same repo directory = same project.  
No special dual-write — hooks on both sides.

## Anti-patterns

- Do not invent prior decisions if status/search is empty  
- Do not dump entire wiki into context  
- Do not store secrets in memory pages  
- Do not claim SessionStart auto-handoff works on Grok  

## Integration with other kits

Memory informs **what was decided**;  
superpowers/craftsman/pentest still govern **how to work now**.
