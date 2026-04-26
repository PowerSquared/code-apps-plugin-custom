## When to use

Use DataTable as the primary view for the asset register — any list of 5 or more comparable records where users need to scan, filter, or select an item to view its detail.

## When not to use

- Fewer than 5 records with no need for selection — use a definition list or card stack.
- Deeply hierarchical data (assets belonging to assets) — a tree view is more appropriate.
- Single-attribute lookups — a simple select or combobox is sufficient.

## Layout rules

- Table occupies the full width of the main column minus horizontal page inset (36px each side).
- The header row is sticky; it must remain visible when the body scrolls.
- Column order: Asset (name + serial) — Type — Assigned to — Status. This order is fixed.
- The Type column renders as plain `typography.body` text ("Laptop", "Monitor", etc.) — not as a Tag component. Tag is reserved for the DetailDrawer identity block.
- Numeric columns right-align. All current columns are text — left-align all.
- A selected row turns accent-soft; this state coexists with open DetailDrawer only. When the drawer closes, selection clears.
- Row density is adjustable via a CSS variable (0.7–1.4×). Default is 1 (14px vertical padding). Honour the user's setting; do not override it.

## Do

- Provide a visible column header for every column, including future icon-only columns (use aria-label).
- Show a row-level loading skeleton when fetching, not a full-page spinner.
- Maintain the selected row highlight even when the detail drawer is open beside the table.
- Unassigned rows render "— unassigned" in italic subtle text — preserve this convention.

## Don't

- Don't use zebra striping. Hover and selection states provide sufficient row distinction.
- Don't truncate cell text silently — if a name is long, let it wrap or show a tooltip on overflow.
- Don't add more than 5–6 columns. The current 4-column layout is intentional.
- Don't place action buttons inside table rows — all per-row actions live in the DetailDrawer.
