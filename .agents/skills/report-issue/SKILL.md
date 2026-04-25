---
name: report-issue
description: Collect issue details and direct the user to file a GitHub bug report. Use when the user encounters a problem with these skills.
---

# Report Issue

Collect information about the problem and direct the user to file a GitHub issue.

## Steps

1. Ask the user (if not already provided):
   - Which skill or command were they running? (e.g., `/create-code-app`, `/add-dataverse`)
   - What did they expect to happen?
   - What actually happened? (include any error messages verbatim)
   - Operating system and Node.js version (`node --version`)
   - PAC CLI version (`pwsh -NoProfile -Command "pac --version"`)

2. Summarize the collected information in a clear bug report format.

3. Direct the user to file the issue at:
   **https://github.com/microsoft/power-platform-skills/issues**

   Suggest they include:
   - The skill name
   - Steps to reproduce
   - Expected vs actual behavior
   - Error messages (verbatim)
   - Environment details (OS, Node version, PAC CLI version)
