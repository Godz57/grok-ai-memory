# Setup: Grok Build + Pi + ai-memory

## 1. Server (once)

### Docker (simplest shared path)

```bash
docker run -d --name ai-memory \
  --restart unless-stopped \
  -p 127.0.0.1:49374:49374 \
  -v ai-memory-data:/data \
  akitaonrails/ai-memory:latest
```

Optional LLM env vars for better consolidation (see upstream README).

### CLI wrapper

```bash
mkdir -p ~/.local/bin
curl -fsSL https://raw.githubusercontent.com/akitaonrails/ai-memory/main/bin/ai-memory \
  -o ~/.local/bin/ai-memory
chmod +x ~/.local/bin/ai-memory
```

Windows: use **WSL2** for the path above, or native zip + Docker Desktop (see upstream `docs/windows.md`).

## 2. Wire Grok

```bash
ai-memory install-hooks --agent grok --apply
# MCP: if your Grok config supports MCP servers pointing at http://127.0.0.1:49374/mcp
```

Hooks land in `~/.grok/hooks/ai-memory.json` (or Grok hook bundle).

**Grok limitation:** SessionStart does **not** inject handoff text.  
At the start of a continued task, run **`/memory-handoff`** or ask the agent to call MCP `memory_handoff_accept`.

## 3. Wire Pi

```bash
ai-memory install-hooks --agent pi --apply
```

Creates/updates `~/.pi/agent/extensions/ai-memory.ts` (lifecycle + HTTP MCP bridge).

## 4. Same project identity

Work in the **same git repo root** (or set `.ai-memory.toml` in the repo):

```toml
# optional .ai-memory.toml
workspace = "default"
project = "my-app"
```

Then Grok and Pi write to the same project wiki.

## 5. Bootstrap existing repo (optional)

```bash
cd /path/to/repo
ai-memory bootstrap
```

## 6. Day-to-day

| Moment | Action |
|--------|--------|
| Coding in Grok | automatic capture via hooks |
| Resume in Grok | `/memory-handoff` |
| Coding in Pi | capture + handoff via extension |
| Search | `/memory-search topic` or ask agent |
| Permanent note | `/memory-save` or "save permanent note that..." |

## 7. Health

```bash
ai-memory status
curl -s http://127.0.0.1:49374/admin/health   # if exposed; auth may apply
```

Or in Grok: `/memory-status`.

## Uninstall hooks later

```bash
ai-memory uninstall --apply
# review carefully; see upstream docs
```
