# Power Apps Code Apps — Copilot Instructions

This project builds Power Apps code apps using **React + Vite + TypeScript**, deployed to Microsoft Power Platform via PAC CLI.

---

## Connector-First Rule (Most Important)

Power Apps code apps run in a browser sandbox. **Direct HTTP calls do not work at runtime** — `fetch`, `axios`, Graph API calls, and Azure REST API calls will all fail in production. All external data access **must** go through Power Platform connectors.

### Connector Decision Table

| What you need | Connector to use |
|---|---|
| Custom business data / Dataverse tables | Dataverse — `pac code add-data-source -a dataverse -t <table>` |
| Work items, pipelines, repos | Azure DevOps connector |
| Teams messages / channel posts | Microsoft Teams connector |
| Excel spreadsheet data | Excel Online (Business) connector |
| File upload/download/listing | OneDrive for Business connector |
| SharePoint lists and document libraries | SharePoint Online connector |
| Email, calendar, contacts | Office 365 Outlook connector |
| Copilot Studio agents | Microsoft Copilot Studio connector |
| Anything else | Generic Power Platform connector — `pac code add-data-source -a <api-name>` |

If no connector supports the required functionality, say so explicitly. **Never propose a direct API call as a workaround** — it will not work in production.

---

## Windows CLI

`pac` is a Windows executable and is **not** on the bash PATH. Always invoke via PowerShell:

```powershell
pwsh -NoProfile -Command "pac auth list"
pwsh -NoProfile -Command "pac env list"
pwsh -NoProfile -Command "pac code push"
pwsh -NoProfile -Command "pac connection list"
```

Never run `pac <args>` directly in bash. Never use `cmd /c pac <args>`.

---

## Safety Gates — Always Confirm First

- **Before `pac code push`**: Ask _"Ready to deploy to [environment name]? This will update the live app."_ Wait for explicit confirmation.
  - Exception: the baseline deploy in the `create-code-app` workflow (Step 7) is pre-approved.
- **Before `npm install -g ...` or `winget install ...`**: Ask for confirmation — global installs affect the machine.
- **Before writing files outside the project directory**: Ask for confirmation.

---

## Build Rules

- Always run `npm run build` before `pac code push`. Never skip it.
- Verify `dist/` contains `index.html` and an `assets/` subdirectory before deploying.
- Fix TypeScript errors before deploying. TS6133 (unused import) — remove the import. TS2339 (property doesn't exist) — check the generated model types.
- **Never edit files under `src/generated/`** unless a documented fix explicitly requires it (e.g., the Azure DevOps `parameters`→`body` rename).

---

## Scaffolding New Apps

Use `npx degit` — never `git clone` or manual file creation:

```bash
npx degit microsoft/PowerAppsCodeApps/templates/vite {folder-name} --force
cd {folder-name}
npm install
pwsh -NoProfile -Command "pac code init --displayName '{App Name}' -e <environment-id>"
```

Node.js v22+ is required. Check with `node --version` before starting.

---

## Environment Selection

1. Check `power.config.json` for `environmentId` — use it if present, confirm with user.
2. If absent, run `pwsh -NoProfile -Command "pac env list"` and ask the user to choose.
3. Use `pwsh -NoProfile -Command "pac env select --environment <id>"` to switch if needed.

---

## Adding Connectors (Non-Dataverse)

All non-Dataverse connectors require a **connection ID**:

```bash
pwsh -NoProfile -Command "pac connection list"   # find the connection ID
pwsh -NoProfile -Command "pac code add-data-source -a <api-name> -c <connection-id>"
```

For tabular connectors (SharePoint, Excel), also pass `-d '<dataset>'` and `-t '<table>'`.

If the connection doesn't exist, direct the user to:
`https://make.powerapps.com/environments/<environment-id>/connections`

---

## Using Generated Services

After `pac code add-data-source`, use the **generated services** for all data access — never use fetch/axios:

```typescript
// Correct — use the generated service
const result = await AccountsService.getAll({ select: ["name", "accountnumber"], top: 50 });
const items = result.data || [];

// Wrong — will not work in production
const response = await fetch("https://org.crm.dynamics.com/api/data/v9.2/accounts");
```

Generated files live in `src/generated/`. Use `grep` to find available methods in large service files rather than reading them whole.

---

## Memory Bank

Each scaffolded code app project has a `memory-bank.md` at its root. It tracks:
- Environment ID and app URL
- Completed scaffolding steps
- Data sources added
- User preferences

Read it at the start of any task. Update it after each major step.

---

## Dataverse Field Gotchas

- **Choice/Picklist fields** store integers, not strings. Filter and set with numeric constants.
- **Lookup fields**: read with `_fieldname_value` (GUID); write with `@odata.bind: "/entitysetname(guid)"`.
- **Virtual fields** (computed, end in `name`) cannot be queried in OData — exclude from `$select`.
- **Formatted values**: request with `Prefer: odata.include-annotations="OData.Community.Display.V1.FormattedValue"`.
- **File/Image columns**: use separate upload/download endpoints, not inline OData.
- **TypeScript enums**: annotate state variables as `number` explicitly to avoid literal type inference.

---

## Azure DevOps — Known Generated Code Fix

After adding the Azure DevOps connector, rename `parameters` to `body` in the generated `HttpRequest` method signature and usages across three files. This is a known issue in the code generator.

---

## Microsoft Copilot Studio — Correct Endpoint

Use **`ExecuteCopilotAsyncV2` only**. The other endpoints either fire-and-forget or return 502 errors:

```typescript
const response = await CopilotStudioService.ExecuteCopilotAsyncV2({ ... });
const text = JSON.parse(response.responses[0]).text;
```
