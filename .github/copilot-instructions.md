# Power Apps Code Apps — Copilot Instructions

This project builds Power Apps code apps using **React + Vite + TypeScript**, deployed to Microsoft Power Platform via PAC CLI.

Full skill workflows are in `.agents/skills/`. When the user invokes a skill (e.g., "create a new app", "add SharePoint", "deploy"), read and follow the corresponding `.agents/skills/<name>/SKILL.md`.

---

## Connector-First Rule (Most Important)

Power Apps code apps run in a browser sandbox. **Direct HTTP calls do not work at runtime** — `fetch`, `axios`, Graph API calls, and Azure REST API calls will all fail in production. All external data access **must** go through Power Platform connectors.

| What you need | Connector to use |
|---|---|
| Custom business data / Dataverse tables | Dataverse — `npx power-apps add-data-source -a dataverse -t <table>` |
| Work items, pipelines, repos | Azure DevOps connector |
| Teams messages / channel posts | Microsoft Teams connector |
| Excel spreadsheet data | Excel Online (Business) connector |
| File upload/download/listing | OneDrive for Business connector |
| SharePoint lists and document libraries | SharePoint Online connector |
| Email, calendar, contacts | Office 365 Outlook connector |
| Copilot Studio agents | Microsoft Copilot Studio connector |
| Anything else | Generic Power Platform connector — `npx power-apps add-data-source -a <api-name>` |

If no connector supports the required functionality, say so explicitly. **Never propose a direct API call as a workaround** — it will not work in production.

---

## Windows CLI

`pac` is a Windows executable and is **not** on the bash PATH. Always invoke via PowerShell:

```powershell
pwsh -NoProfile -Command "pac auth list"
pwsh -NoProfile -Command "pac env list"
pwsh -NoProfile -Command "pac connection list"
```

Never run `pac <args>` directly in bash. Never use `cmd /c pac <args>`.

---

## Safety Gates — Always Confirm First

- **Before `npx power-apps push`**: Ask _"Ready to deploy to [environment name]? This will update the live app."_ Wait for explicit confirmation.
  - Exception: the baseline deploy in the `create-code-app` workflow (Step 7) is pre-approved.
- **Before `npm install -g ...` or `winget install ...`**: Ask for confirmation — global installs affect the machine.
- **Before writing files outside the project directory**: Ask for confirmation.

---

## Build Rules

- Always run `npm run build` before `npx power-apps push`. Never skip it.
- Verify `dist/` contains `index.html` and an `assets/` subdirectory before deploying.
- Fix TypeScript errors before deploying. TS6133 (unused import) — remove the import. TS2339 (property doesn't exist) — check the generated model types.
- **Never edit files under `src/generated/`** unless a documented fix explicitly requires it (e.g., the Azure DevOps `parameters`→`body` rename).

---

## Memory Bank

Each scaffolded code app project has a `memory-bank.md` at its root. Read it at the start of any task. Update it after each major step.
