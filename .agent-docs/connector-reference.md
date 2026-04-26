# Connector Reference

Applies to all connector skills (`/add-azuredevops`, `/add-teams`, `/add-excel`, `/add-onedrive`, `/add-sharepoint`, `/add-office365`, `/add-mcscopilot`, `/add-connector`). Does NOT apply to Dataverse (`/add-dataverse`).

## Connection Reference (Required)

All non-Dataverse connectors require a **connection reference logical name** (`-cr`) and a **solution ID** (`-s`) when adding via `npx power-apps add-data-source`. Using connection references (instead of raw connection IDs) is required for proper Power Platform ALM — connection references are solution-aware and portable across environments.

### Getting the Connection Reference Logical Name

If the user has not provided the `connectionReferenceLogicalName`, ask for it before proceeding:

> "What is the connection reference logical name for this connector? You can find it in the Power Platform maker portal under **Solutions → [your solution] → Connection References**. It typically looks like `new_office365outlook_abc12`."

If no connection reference exists yet for the connector in their solution, direct the user to:
1. Open the maker portal: `https://make.powerapps.com/environments/<environment-id>/solutions`
2. Open their solution
3. Select **New → More → Connection reference**
4. Choose the connector (e.g., "Office 365 Outlook", "Azure DevOps", "Teams") and link an existing connection
5. Note the **logical name** that gets assigned

### Getting the Solution ID

The solution ID (`-s`) is typically available in `power.config.json` in the project root. If not found there, ask the user for it — it can be found in the maker portal under **Solutions → [your solution] → Solution ID**.

### Command Syntax

```bash
# Non-tabular connectors
npx power-apps add-data-source -a <api-name> -cr <connectionReferenceLogicalName> -s <solutionID>

# Tabular connectors (also need -d and -t)
npx power-apps add-data-source -a <api-name> -cr <connectionReferenceLogicalName> -s <solutionID> -d '<dataset>' -t '<table>'
```


## Inspecting Large Generated Files

Generated service files (e.g., `Office365OutlookService.ts`) can be thousands of lines. **Do NOT read the entire file.** Instead:

1. **List available methods** with Grep:
   ```
   Grep pattern="async \w+" path="src/generated/services/<Connector>Service.ts"
   ```

2. **Find a specific method** and read just that section:
   ```
   Grep pattern="async GetEventsCalendarViewV2" path="src/generated/services/Office365OutlookService.ts" -A 20
   ```

3. **Find parameter types** in the models file:
   ```
   Grep pattern="interface CalendarEventHtmlClient" path="src/generated/models/Office365OutlookModel.ts" -A 30
   ```

This avoids context window bloat and is much faster than reading entire generated files.

## Sub-Skill Invocation

When a connector skill is invoked from another skill (e.g., `/create-code-app` calls `/add-office365`):

- **Check `$ARGUMENTS`** -- if provided, use it as the connector name or configuration
- **Skip redundant questions** -- don't re-ask things the caller already provided (connector name, project path, etc.)
- **Memory bank is still read** -- but skip the summary if the caller just updated it
