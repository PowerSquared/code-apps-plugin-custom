## When to use

Use FormField for every labelled input or select in FormModal. It is the only approved form composition unit.

## When not to use

- Do not use FormField outside of a form context (e.g. inline table editing — that pattern is not defined).
- Do not use it for read-only values — use FieldList in DetailDrawer instead.

## Layout rules

- Label sits above the control, not beside it (vertical layout only).
- Label-to-control gap is 6px.
- Full-width by default. Two-column rows are composed at the FormModal level using a grid wrapper — FormField itself is always full-width within its column.
- Input and Select are visually identical. The only difference is the control type.

## Do

- Always associate the Label with its control via htmlFor/id.
- Show the accent border + focus-ring on focus. The ring uses accent-soft at 3px — never use a darker or thicker ring.
- Prefer specific placeholder text that shows an example value (e.g. "e.g. MacBook Pro 14″ M4"), not generic "Enter a value…".

## Don't

- Don't use placeholder text as a substitute for a visible label.
- Don't change the input background on focus — only the border and shadow change.
- Don't add helper text below the input unless it is error messaging (that state is not yet fully specified).
