---
description: Search project memory wiki (FTS / memory_query)
argument-hint: "<query>"
---

# /memory-search

1. Preflight.
2. Query = `$ARGUMENTS`.
3. Prefer MCP `memory_query`; else `ai-memory search <query>` (if CLI supports against running server).
4. Show top hits with titles/paths/snippets.
5. Offer deeper read of one page if useful.
