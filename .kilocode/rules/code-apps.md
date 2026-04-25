# Power Apps Code Apps — Project Instructions

This project builds Power Apps code apps using **React + Vite + TypeScript**, deployed to Microsoft Power Platform via PAC CLI.

## Architect Persona

When making architecture decisions, selecting connectors, designing data models, or troubleshooting build/deploy issues, apply the expertise described in [.agent-docs/code-app-architect.md](.agent-docs/code-app-architect.md).

## Shared Instructions

Read these before acting on any skill workflow:

- **Cross-cutting rules** — [.agent-docs/shared-instructions.md](.agent-docs/shared-instructions.md)
- **Connector prerequisites** — [.agent-docs/connector-reference.md](.agent-docs/connector-reference.md)

## Available Skills

Skill workflows are defined in `.agents/skills/`. Read the relevant `SKILL.md` when the user invokes a skill.

| Skill | File |
|---|---|
| Create a new code app | [.agents/skills/create-code-app/SKILL.md](.agents/skills/create-code-app/SKILL.md) |
| Build and deploy | [.agents/skills/deploy/SKILL.md](.agents/skills/deploy/SKILL.md) |
| List connections | [.agents/skills/list-connections/SKILL.md](.agents/skills/list-connections/SKILL.md) |
| Add a data source (router) | [.agents/skills/add-datasource/SKILL.md](.agents/skills/add-datasource/SKILL.md) |
| Add Dataverse | [.agents/skills/add-dataverse/SKILL.md](.agents/skills/add-dataverse/SKILL.md) |
| Add SharePoint | [.agents/skills/add-sharepoint/SKILL.md](.agents/skills/add-sharepoint/SKILL.md) |
| Add Excel | [.agents/skills/add-excel/SKILL.md](.agents/skills/add-excel/SKILL.md) |
| Add OneDrive | [.agents/skills/add-onedrive/SKILL.md](.agents/skills/add-onedrive/SKILL.md) |
| Add Teams | [.agents/skills/add-teams/SKILL.md](.agents/skills/add-teams/SKILL.md) |
| Add Office 365 Outlook | [.agents/skills/add-office365/SKILL.md](.agents/skills/add-office365/SKILL.md) |
| Add Azure DevOps | [.agents/skills/add-azuredevops/SKILL.md](.agents/skills/add-azuredevops/SKILL.md) |
| Add Copilot Studio | [.agents/skills/add-mcscopilot/SKILL.md](.agents/skills/add-mcscopilot/SKILL.md) |
| Add any connector | [.agents/skills/add-connector/SKILL.md](.agents/skills/add-connector/SKILL.md) |
| Report an issue | [.agents/skills/report-issue/SKILL.md](.agents/skills/report-issue/SKILL.md) |

## Key Principles

1. **Connector-First** — Power Apps code apps run sandboxed. Direct `fetch`/`axios`/Graph API calls do not work at runtime. All external data must go through Power Platform connectors.
2. **Windows CLI** — `pac` is a Windows executable, not on the bash PATH. Always invoke via `pwsh -NoProfile -Command "pac ..."`.
3. **Memory Bank** — Every skill reads `memory-bank.md` at the project root first. Create it after scaffolding; update it after each major step.
4. **Plan Before Implementing** — Enter plan mode before multi-file changes, adding features, or modifying data sources.
5. **Build Before Deploy** — Always run `npm run build` and verify `dist/` contains `index.html` before `npx power-apps push`.
