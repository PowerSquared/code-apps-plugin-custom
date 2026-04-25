# Power Apps Code Apps — AI Assistant Instructions

This project builds Power Apps code apps using **React + Vite + TypeScript**, deployed to Microsoft Power Platform via the npm CLI (`npx power-apps push`).

## Architect Persona

When making architecture decisions, selecting connectors, designing data models, or troubleshooting build/deploy issues, apply the expertise described in [.agent-docs/code-app-architect.md](.agent-docs/code-app-architect.md).

## Shared Instructions

Read these before acting on any skill workflow:

- **Cross-cutting rules** — [.agent-docs/shared-instructions.md](.agent-docs/shared-instructions.md)
  Covers: safety guardrails, planning policy, memory bank protocol, development standards, connector-first rule, Windows CLI compatibility, and command failure handling.

- **Connector prerequisites** — [.agent-docs/connector-reference.md](.agent-docs/connector-reference.md)
  Covers: connection IDs, tabular connector parameters, large generated service files, and cross-skill argument passing.

## Available Skills

| Slash command | What it does |
|---|---|
| `/create-code-app` | Scaffold, configure, and baseline-deploy a new Power Apps code app |
| `/deploy` | Build (`npm run build`) and deploy an existing app via `npx power-apps push` |
| `/list-connections` | List Power Platform connections to find connection IDs |
| `/add-datasource` | Router — asks what you need, routes to the right `/add-*` skill |
| `/add-dataverse` | Add Dataverse tables with generated TypeScript models and services |
| `/add-sharepoint` | Add SharePoint Online connector |
| `/add-excel` | Add Excel Online (Business) connector |
| `/add-onedrive` | Add OneDrive for Business connector |
| `/add-teams` | Add Microsoft Teams connector |
| `/add-office365` | Add Office 365 Outlook connector |
| `/add-azuredevops` | Add Azure DevOps connector |
| `/add-mcscopilot` | Add Microsoft Copilot Studio connector |
| `/add-connector` | Add any other Power Platform connector (generic fallback) |
| `/report-issue` | Report a bug with these skill files |

Skill workflows live in [.agents/skills/](.agents/skills/) — the universal location for all tools. The `.claude/commands/` files are thin stubs that load the corresponding `SKILL.md`.

## Key Principles

1. **Connector-First** — Power Apps code apps run sandboxed. Direct `fetch`/`axios`/Graph API calls do not work at runtime. All external data must go through Power Platform connectors.
2. **Windows CLI** — `npx power-apps` runs in bash directly. `pac` is a Windows executable (not on bash PATH) and is only needed for env/connection listing — always invoke via `pwsh -NoProfile -Command "pac ..."`.
3. **Memory Bank** — Every skill reads `memory-bank.md` at the project root first. Create it after scaffolding; update it after each major step.
4. **Plan Before Implementing** — Enter plan mode before multi-file changes, adding features, or modifying data sources. See [.agent-docs/planning-policy.md](.agent-docs/planning-policy.md).
5. **Build Before Deploy** — Always run `npm run build` and verify `dist/` contains `index.html` before `npx power-apps push`.

## About This Directory

This is a **vendored (local) copy** of the upstream plugin. You own every file here — edit, extend, or delete anything. The upstream source is:
https://github.com/microsoft/power-platform-skills/tree/main/plugins/code-apps
