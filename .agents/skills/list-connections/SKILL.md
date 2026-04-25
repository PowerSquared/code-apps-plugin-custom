---
name: list-connections
description: List Power Platform connections to find connection IDs. Use when setting up a connector or when an add-* skill needs a connection ID.
compatibility: Requires pac CLI authenticated to a Power Platform environment.
---

**Shared instructions:** Read `.agent-docs/shared-instructions.md` before starting.

# List Connections

Lists all Power Platform connections in the default environment using the Power Platform CLI (`pac`).

## Workflow

1. Fetch Connections → 2. Present Results

---

### Step 1: Fetch Connections

```bash
pwsh -NoProfile -Command "pac connection list"
```

If `pac` is not authenticated, tell the user to run `pwsh -NoProfile -Command "pac auth create"` and try again.

**Other failures:**
- Non-zero exit for any reason other than auth: Report the exact output. STOP.
- No output or timeout: Run `pwsh -NoProfile -Command "pac env list"` to verify pac can reach the environment, then retry once.

### Step 2: Present Results

Show the connection list to the user. The **Connection ID** is what goes into `-c <connection-id>` when adding a data source.

**If the needed connector is missing:**

1. Share the direct Connections URL using the active environment ID from context (from `power.config.json` or a prior step): `https://make.powerapps.com/environments/<environment-id>/connections` → **+ New connection**
2. Search for and create the connector, then complete the sign-in/consent flow
3. Re-run `/list-connections` to get the new connection ID
