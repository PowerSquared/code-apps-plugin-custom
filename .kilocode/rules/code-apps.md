# Power Apps Code Apps — Project Instructions

This project builds Power Apps code apps using **React + Vite + TypeScript**, deployed to Microsoft Power Platform via PAC CLI.

## Architect Persona

When making architecture decisions, selecting connectors, designing data models, or troubleshooting build/deploy issues, apply the expertise described in [.agent-docs/code-app-architect.md](.agent-docs/code-app-architect.md).

## Shared Instructions

Read these before acting on any skill workflow:

- **Cross-cutting rules** — [.agent-docs/shared-instructions.md](.agent-docs/shared-instructions.md)
- **Connector prerequisites** — [.agent-docs/connector-reference.md](.agent-docs/connector-reference.md)

## Available Skills

Skill workflows are defined in `.claude/commands/`. Read the relevant file when the user invokes a skill.

| Skill | File |
|---|---|
| Create a new code app | [.claude/commands/create-code-app.md](.claude/commands/create-code-app.md) |
| Build and deploy | [.claude/commands/deploy.md](.claude/commands/deploy.md) |
| List connections | [.claude/commands/list-connections.md](.claude/commands/list-connections.md) |
| Add a data source (router) | [.claude/commands/add-datasource.md](.claude/commands/add-datasource.md) |
| Add Dataverse | [.claude/commands/add-dataverse.md](.claude/commands/add-dataverse.md) |
| Add SharePoint | [.claude/commands/add-sharepoint.md](.claude/commands/add-sharepoint.md) |
| Add Excel | [.claude/commands/add-excel.md](.claude/commands/add-excel.md) |
| Add OneDrive | [.claude/commands/add-onedrive.md](.claude/commands/add-onedrive.md) |
| Add Teams | [.claude/commands/add-teams.md](.claude/commands/add-teams.md) |
| Add Office 365 Outlook | [.claude/commands/add-office365.md](.claude/commands/add-office365.md) |
| Add Azure DevOps | [.claude/commands/add-azuredevops.md](.claude/commands/add-azuredevops.md) |
| Add Copilot Studio | [.claude/commands/add-mcscopilot.md](.claude/commands/add-mcscopilot.md) |
| Add any connector | [.claude/commands/add-connector.md](.claude/commands/add-connector.md) |
| Report an issue | [.claude/commands/report-issue.md](.claude/commands/report-issue.md) |

## Key Principles

1. **Connector-First** — Power Apps code apps run sandboxed. Direct `fetch`/`axios`/Graph API calls do not work at runtime. All external data must go through Power Platform connectors.
2. **Windows CLI** — `pac` is a Windows executable, not on the bash PATH. Always invoke via `pwsh -NoProfile -Command "pac ..."`.
3. **Memory Bank** — Every skill reads `memory-bank.md` at the project root first. Create it after scaffolding; update it after each major step.
4. **Plan Before Implementing** — Enter plan mode before multi-file changes, adding features, or modifying data sources.
5. **Build Before Deploy** — Always run `npm run build` and verify `dist/` contains `index.html` before `pac code push`.
