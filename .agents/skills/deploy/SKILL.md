---
name: deploy
description: Build and deploy an existing Power Apps code app to Power Platform. Use when the user wants to deploy or redeploy their app.
compatibility: Requires Node.js v22+ and a Power Platform environment. pac CLI is not required for deploy.
---

**Shared instructions:** Read `.agent-docs/shared-instructions.md` before starting.

# Deploy

Builds and deploys the app in the current directory to Power Platform.

## Workflow

1. Check Memory Bank → 2. Build → 3. Deploy → 4. Update Memory Bank

---

### Step 1: Check Memory Bank

Check for `memory-bank.md` in the project root. If found, read it for the project name and environment. If not found, proceed — the project may have been created without the plugin.

### Step 2: Build

```powershell
npm run build
```

If the build fails:

- **TS6133 (unused import)**: Remove the unused import and retry.
- **Other TypeScript errors**: Report the error with the file and line number and stop. Do not deploy a broken build.

Verify `dist/` exists with `index.html` before continuing.

### Step 3: Deploy

Ask the user: _"Ready to deploy to [environment name]? This will update the live app."_ Wait for explicit confirmation before proceeding.

```bash
npx power-apps push
```

Capture the app URL from the output if present.

If deploy fails, report the error and stop — do not retry silently. Common fixes:

- Auth error → re-run `npx power-apps push`; the CLI will prompt for sign-in automatically.
- "environment not found" → verify `power.config.json` contains the correct `environmentId`.

### Step 4: Update Memory Bank

If `memory-bank.md` exists, update:

- Last deployed timestamp
- App URL (if captured)
