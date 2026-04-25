## When to use

Use DetailDrawer when a user selects a table row and needs to view or act on the full record without leaving the list context. The list and drawer coexist on screen simultaneously.

## When not to use

- Do not use DetailDrawer as a form entry point for creating new records — use FormModal.
- Do not use DetailDrawer for content that requires more than 440px width (e.g. rich text, large images).
- Do not open DetailDrawer inside a modal or another drawer — it is a page-level panel.

## Layout rules

- Fixed width: 440px. Non-negotiable; the table narrows to accommodate it.
- The drawer occupies the full height of the screen alongside the table. It does not float.
- The Actions row (Edit + Reassign) pins to the bottom via `margin-top: auto` on the flex column.
- The FieldList label column is fixed at 130px. Values fill the remaining width.
- When an asset has no assignee, the AssigneeCard still renders — with italic "In store — not assigned" centred inside it. Never omit the section.

## Do

- Close the drawer (and clear selection) when Escape is pressed.
- Return keyboard focus to the triggering row on close.
- Show the same StatusBadge and type Tag combination as the table row — the identity block is the source of truth for a glance.

## Don't

- Don't put a Delete action in the drawer — destructive actions require confirmation UI not yet defined.
- Don't show more than 5 fields in the FieldList before hiding behind a "show more" expansion.
- Don't animate the drawer entry with anything other than a simple slide from the right. No fade, no scale.
