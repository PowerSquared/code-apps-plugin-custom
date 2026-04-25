# Prerequisites Reference

## Required Tools

| Tool               | Minimum Version | Check Command                    | Install                     |
| ------------------ | --------------- | -------------------------------- | --------------------------- |
| Node.js            | **v22+**        | `node --version`                 | https://nodejs.org/         |
| Git (optional)     | Any             | `git --version`                  | https://git-scm.com/        |
| pac CLI (optional) | **latest**      | `pwsh -NoProfile -Command "pac"` | https://aka.ms/PowerAppsCLI |

pac CLI is **only required** for environment listing (`pac env list`) and connection listing (`pac connection list`). All code app commands use the npm CLI (`npx power-apps`).

```bash
npx power-apps init --display-name "<name>" --environment-id <id>
npx power-apps add-data-source -a <api> -c <connection-id>
npx power-apps push
pwsh -NoProfile -Command "pac env list"          # list environments (pac needed)
pwsh -NoProfile -Command "pac connection list"   # list connections (pac needed)
```

## Required Account

- Power Platform account with code apps enabled
- At least one environment available

## Required Permissions (allowedPrompts)

When using plan mode, include these in `allowedPrompts`:

```json
{
  "allowedPrompts": [
    { "tool": "Bash", "prompt": "check tool versions (node, git)" },
    { "tool": "Bash", "prompt": "scaffold power apps template (npx degit)" },
    { "tool": "Bash", "prompt": "install npm dependencies" },
    { "tool": "Bash", "prompt": "build for production (npm run build)" },
    { "tool": "Bash", "prompt": "list environments (pwsh -NoProfile -Command 'pac env list')" },
    { "tool": "Bash", "prompt": "initialize power apps project (npx power-apps init)" },
    { "tool": "Bash", "prompt": "list connections (/list-connections skill via Power Platform REST API)" },
    { "tool": "Bash", "prompt": "add data sources (npx power-apps add-data-source)" },
    { "tool": "Bash", "prompt": "deploy to power platform (npx power-apps push)" }
  ]
}
```