## When to use

- **Primary** — exactly one per view region; the single most important action (e.g. "Add asset", "Save asset").
- **Secondary** — supporting actions that are important but not the default path (e.g. "Cancel", "Edit", "Import CSV").
- **Ghost** — low-priority or destructive-adjacent actions that should recede visually (e.g. "Reassign", close icons).

## When not to use

- Do not use a primary button when no action is meaningfully more important than others — use secondary for all.
- Do not use a button for navigation to another page; use a link.
- Do not use ghost for the primary action of a surface. Ghost is only for tertiary actions.

## Layout rules

- Buttons in a footer row are right-aligned. The primary action is always rightmost.
- Icon is always leading (left), never trailing.
- Minimum touch target is 36px tall; the default 8px vertical padding on 13px type achieves ~34px — pad the hit area with invisible space in touch contexts.
- Never stretch a button to full width except when it is the sole CTA in a constrained column.

## Do

- Keep labels to 1–3 words. Labels describe the outcome, not the mechanism ("Save asset", not "Submit form").
- Use a leading icon only when it adds meaning at a glance (plus for create, download for export).
- Pair primary with secondary in footers; primary with ghost in inline action rows.

## Don't

- Don't place two primary buttons side by side.
- Don't use colour alone to distinguish button variants — always rely on background, border, and weight differences.
- Don't abbreviate labels to save space; resize the container instead.
