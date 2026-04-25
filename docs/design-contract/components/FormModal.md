## When to use

Use FormModal when the user initiates creation of a new asset from the "Add asset" primary button in the page header. It is the only creation entry point.

## When not to use

- Do not use FormModal for editing an existing asset — editing opens inline within the DetailDrawer (not yet designed; reserve that pattern).
- Do not use FormModal for destructive confirmation — use a simpler confirmation dialog.
- Do not stack two modals. FormModal is always the top-most layer.

## Layout rules

- Width: 520px, centred on screen.
- The background app screen receives a blur (2px) and a dark overlay (rgba 0.35) when the modal is open.
- StatusPicker is always a 4-column grid matching the four status options exactly. Never add a fifth column.
- Form rows stack vertically with 18px gap. The Type + Serial row uses a 2-column grid. All other fields are full-width.
- Footer buttons are right-aligned: Cancel (secondary) then Save asset (primary). No other actions in the footer.

## Do

- Focus the Name field on open.
- Validate all fields before enabling Save; show field-level errors inline below the input (error state not yet fully specified — flag this for design).
- Close on Escape, clicks outside the modal, and the Cancel button.

## Don't

- Don't use the modal for bulk operations.
- Don't allow the modal to scroll internally if fields are added — redesign the layout before adding more than 6 fields.
- Don't remove the subtitle from the form header. "Register a new laptop, monitor or accessory." anchors the user's context.
