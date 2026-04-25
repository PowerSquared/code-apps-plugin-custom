## When to use

Use StatusBadge wherever an asset's lifecycle state must be communicated — in table rows, the detail drawer identity block, and the form status picker.

## When not to use

- Do not use StatusBadge for boolean flags (e.g. "has warranty", "is remote") — use plain text or a Tag instead.
- Do not use StatusBadge outside the four defined statuses. Adding a fifth status requires updating tokens and status-colour definitions, not improvising a colour.

## Layout rules

- Always render the full badge (dot + label + background). Never show the dot alone or the label alone.
- In table cells, the badge is inline; it does not expand to fill the cell.
- In the detail drawer, the badge sits in a horizontal tag row alongside the asset type Tag.

## Do

- Let the badge speak for itself. No additional colour treatment (e.g. coloured row backgrounds) is needed to reinforce status.
- Match dark-mode soft backgrounds: each status has a distinct `status-*-soft` dark value — use those, not opacity tricks.

## Don't

- Don't change the dot colour independently of the text colour — they are always the same token.
- Don't use status colours (saturated foregrounds) as backgrounds, borders, or text elsewhere in the UI.
- Don't truncate the label. "Maintenance" must always be fully visible; widen the column instead.
