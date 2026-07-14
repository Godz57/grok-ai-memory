---
description: Save a permanent pinned note to ai-memory wiki
argument-hint: "<short decision or note text>"
---

# /memory-save

1. Body/topic from `$ARGUMENTS` (or ask if empty).
2. Choose path like `decisions/YYYY-MM-DD-slug.md` unless user gave a path.
3. Prefer MCP `memory_write_page` with pin/durable flag; else:

```bash
ai-memory write-page --path decisions/note.md --body $'# Title\n\n...' --pinned
```

4. Confirm path written; do not store secrets.
