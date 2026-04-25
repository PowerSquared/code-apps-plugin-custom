## When to use

Use EmptyState in the main content column when the asset list has no records — either on first use ("Start your register") or after a search/filter returns no results.

## When not to use

- Do not use EmptyState while data is still loading — use a skeleton loader instead.
- Do not use EmptyState inside a table body row — it replaces the entire content area, not individual rows.
- Do not use EmptyState inside the DetailDrawer or FormModal.

## Layout rules

- Centre everything horizontally and vertically within the main content area.
- Subtitle max-width is 340px to keep line lengths readable.
- Actions row is centred. Primary action appears first (left), secondary second.
- Vertical padding above and below the content block is 80px — do not reduce it to make the empty state feel less empty.

## Do

- Tailor the title and subtitle to the specific empty condition. "Start your register" is for zero records; if a search returns nothing, say "No assets matched your search" and offer a clear-filters action.
- Provide at most two actions: one to create and one to import/load. More than two actions dilutes urgency.

## Don't

- Don't use an illustration or decorative graphic — the design is text-only.
- Don't use the empty state as a holding pattern for "coming soon" features. If the feature doesn't exist, don't surface a route to it.
- Don't omit the EmptyState — a blank main column with no message is never acceptable.
