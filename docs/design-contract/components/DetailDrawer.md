## When to use

Use DetailDrawer when a user selects a table row and needs to view or act on the full record without leaving the list context. The list and drawer coexist on screen simultaneously.

## When not to use

- Do not use DetailDrawer as a form entry point for creating new records — use FormModal.
- Do not use DetailDrawer for content that requires more than 440px width (e.g. rich text, large images).
- Do not open DetailDrawer inside a modal or another drawer — it is a page-level panel.

## Layout rules

- Fixed width: 440px. Non-negotiable; the table narrows to accommodate it.
- The drawer spans the entire visible page height — from the very top edge to the bottom edge — on the right side. It is not confined to the content column beneath the page header; it runs alongside the header as well. It does not scroll with the page.
- The Actions row (Edit + Reassign) pins to the bottom of the drawer, regardless of content length.
- The FieldList label column is fixed at 130px. Values fill the remaining width.
- When an asset has no assignee, the AssigneeCard still renders — with italic "In store — not assigned" centred inside it. Never omit the section.
- The Identity subtitle format is: `"{assetTag} · Serial {serialNumber}"` where `assetTag` is the short human-readable asset identifier (e.g. "AST-0142"). The full Dataverse UUID is never shown in the subtitle.
- Default visible FieldList rows (in order): Type, Location, Purchased, Warranty until, Value. All remaining fields (Supplier, Purchase order, Notes, Asset ID, Serial number) appear behind an inline "Show more" toggle.

## Do

- Close the drawer (and clear selection) when Escape is pressed.
- Return keyboard focus to the triggering row on close.
- Show the same StatusBadge and type Tag combination as the table row — the identity block is the source of truth for a glance.
- Always show the assignee's email address beneath their name in the AssigneeCard when the asset is assigned.
- Render Edit and Reassign as equal-weight secondary buttons — they are co-equal actions, neither should visually dominate.

## Don't

- Don't put a Delete action in the drawer — destructive actions require confirmation UI not yet defined.
- Don't show more than 5 fields in the FieldList before hiding behind a "show more" expansion. The 5 default fields are: Type, Location, Purchased, Warranty until, Value.
- Don't animate the drawer entry with anything other than a simple slide from the right. No fade, no scale.
