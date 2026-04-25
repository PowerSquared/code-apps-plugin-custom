---
name: add-excel
description: Add Excel Online (Business) connector to a Power Apps code app. Use when the user wants to read or write Excel spreadsheet data.
compatibility: Requires pac CLI, an Excel Online (Business) Power Platform connection, and an Excel workbook in OneDrive or SharePoint.
---

**Shared instructions:** Read `.agent-docs/shared-instructions.md` before starting.

# Add Excel Online

## Workflow

1. Check Memory Bank → 2. Gather → 3. Add Connector → 4. Configure → 5. Build → 6. Update Memory Bank

---

### Step 1: Check Memory Bank

Check for `memory-bank.md` per `.agent-docs/shared-instructions.md`.

### Step 2: Gather

Ask the user:

1. Where is the workbook? (OneDrive or SharePoint)
2. Workbook file name
3. Which table(s) in the workbook to access

### Step 3: Add Connector

**First, find the connection ID** (see `.agent-docs/connector-reference.md`):

Run the `/list-connections` skill. Find the Excel Online (Business) connection in the output. If none exists, direct the user to create one using the environment-specific Connections URL — construct it from the active environment ID in context (from `power.config.json` or a prior step): `https://make.powerapps.com/environments/<environment-id>/connections` → **+ New connection** → search for the connector → Create.

Excel Online is a tabular datasource -- requires `-c` (connection ID), `-d` (drive), and `-t` (table name in workbook):

```bash
# OneDrive workbook
npx power-apps add-data-source -a excelonlinebusiness -c <connection-id> -d 'me' -t 'Table1'

# SharePoint workbook -- dataset is the document library path
npx power-apps add-data-source -a excelonlinebusiness -c <connection-id> -d 'sites/your-site' -t 'Table1'
```

Run for each table the user needs.

### Step 4: Configure

**AddRowIntoTable** -- adds a row to an Excel table:

```typescript
// OneDrive workbook
await ExcelOnlineBusinessService.AddRowIntoTable({
  source: "me",
  drive: "me",
  file: "MyWorkbook.xlsx",
  table: "Table1",
  body: { column1: "value1", column2: "value2" } // Flat object, NO "items" wrapper
});

// SharePoint workbook
await ExcelOnlineBusinessService.AddRowIntoTable({
  source: "sites/your-site",
  drive: "drive-id",
  file: "SharedWorkbook.xlsx",
  table: "Table1",
  body: { column1: "value1", column2: "value2" }
});
```

**Key points:**

- `source: "me"` and `drive: "me"` for OneDrive personal files
- For SharePoint, use the site path and drive ID
- The `body` is a flat key-value object matching column headers -- do NOT wrap in `{ items: ... }`

Use `Grep` to find specific methods in `src/generated/services/ExcelOnlineBusinessService.ts` (generated files can be very large -- see `.agent-docs/connector-reference.md`).

### Step 5: Build

```powershell
npm run build
```

Fix TypeScript errors before proceeding. Do NOT deploy yet.

### Step 6: Update Memory Bank

Update `memory-bank.md` with: connector added, workbook/table configured, build status.
