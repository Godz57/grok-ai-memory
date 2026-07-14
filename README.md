# Grok AI Memory — wrapper Grok (+ Pi) para [ai-memory](https://github.com/akitaonrails/ai-memory)

> Memória de longo prazo e **handoff entre agents**.  
> Este kit **não reimplementa** o server Rust: orquestra install de hooks/MCP e uso no **Grok Build** e no **Pi**.

## Start here

Part of the [Godz57 Grok kit stack](https://github.com/Godz57/grok-tooling-playbook).  
**New users** — install the playbook first, or the full stack in order:

```powershell
git clone https://github.com/Godz57/grok-tooling-playbook.git
cd grok-tooling-playbook
.\scripts\install-stack.ps1                 # Full
.\scripts\install-stack.ps1 -Profile Core   # playbook + superpowers + craftsman
```

```bash
./scripts/install-stack.sh
./scripts/install-stack.sh core
```

[When to use what →](https://github.com/Godz57/grok-tooling-playbook#quick-routing)

## Por que você (Grok + Pi)

| Agent | Captura (hooks) | Handoff automático no start |
|-------|-----------------|-----------------------------|
| **Grok** | Sim (`--agent grok`) | **Não** (SessionStart stdout é ignorado) → use `/memory-handoff` |
| **Pi** | Sim (`--agent pi`) | Sim (via extension + bridge) |

Mesmo server, mesmo projeto (mesmo `cwd` / git root) → continuidade entre os dois.

## O que este kit instala

| Peça | Destino |
|------|---------|
| Skill `ai-memory` | `~/.grok/skills/ai-memory/` |
| Commands | `/memory`, `/memory-status`, `/memory-handoff`, `/memory-search`, `/memory-save` |
| Docs | checklist Grok+Pi + Windows |

**Não** instala Docker/ai-memory sozinho (só guia + tenta `install-hooks` se o CLI existir).

## Pré-requisitos (upstream)

1. **ai-memory server** rodando (`127.0.0.1:49374`) — Docker ou binário  
2. CLI `ai-memory` no PATH (wrapper Docker ou nativo)  
3. Opcional: LLM API key no server (consolidação melhor; zero-LLM ainda funciona com FTS5)

Docs oficiais: https://github.com/akitaonrails/ai-memory · https://github.com/akitaonrails/ai-memory/blob/main/docs/install.md

## Install do wrapper Grok

```powershell
cd grok-ai-memory
.\scripts\install.ps1
```

```bash
./scripts/install.sh
```

### Wire hooks (quando o CLI existir)

```powershell
# Server já up em 127.0.0.1:49374
ai-memory install-hooks --agent grok --apply
ai-memory install-hooks --agent pi --apply
# MCP (se o client suportar no seu setup):
# ai-memory install-mcp --client ... --apply
ai-memory install-instructions   # routing snippets / managed skills
```

No Windows: preferir **WSL2** ou Docker Desktop; nativo ainda experimental. Ver `docs/grok-pi-setup.md`.

## Uso no Grok

```
/memory-status              # server / hooks / health
/memory-handoff             # aceitar "where we left off" (obrigatório no Grok)
/memory-search postgres     # memory_query / CLI search
/memory-save path body      # nota pinned (decisão durável)
/memory                     # router
```

Linguagem natural: *“onde paramos?”*, *“salva na memória que usamos Postgres”*, *“busca memória auth JWT”*.

## Companions

| Kit | Papel |
|-----|--------|
| [grok-tooling-playbook](https://github.com/Godz57/grok-tooling-playbook) | **Start here** + install-stack |
| [grok-superpowers](https://github.com/Godz57/grok-superpowers) | Processo de eng |
| [grok-pentest](https://github.com/Godz57/grok-pentest) / [grok-strix](https://github.com/Godz57/grok-strix) | Segurança |
| [grok-cyber-skills](https://github.com/Godz57/grok-cyber-skills) | Playbooks SOC/DFIR |
| **ai-memory** | Continuação entre sessões/agents |

## License

MIT (wrapper). Upstream ai-memory: MIT.
