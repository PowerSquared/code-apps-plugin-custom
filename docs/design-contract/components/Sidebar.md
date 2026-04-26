## When to use

The Sidebar is the persistent app-level navigation. It is always visible on the main product screen. There is exactly one Sidebar per screen.

## When not to use

- Do not render the Sidebar inside a modal or on an unauthenticated screen.
- Do not add more than 8 navigation items — this is a focused internal tool, not a portal.

## Layout rules

- Fixed width: 220px. The main column takes the remaining viewport width.
- Nav items use 6px border-radius and 7px vertical / 10px horizontal padding.
- The active item gets the surface background (white); all others are transparent.
- NavCounts appear only on items where a count is meaningful (filtered views like "Available", "Maintenance"). Not every item needs a count.
- The Footer is visually separated by a top border and sits at the very bottom of the sidebar, regardless of how many nav items there are.
- Every nav item must include a 16px stroked icon to the left of its label. Icons use the stroke colour of the surrounding text and are never filled.

**Nav item order and icons** (top to bottom):

| # | Label | Count badge | Icon |
|---|-------|-------------|------|
| 1 | Overview | — | grid / dashboard |
| 2 | All assets | — | list / rows |
| 3 | Assigned to me | ✓ | person / user |
| 4 | Available | ✓ | check-circle |
| 5 | Maintenance | ✓ | wrench / tool |
| 6 | Retired | ✓ | archive / box |

"All assets" carries no count badge — the total appears in the page subtitle instead.

## Do

- Show the Meridian mark (SVG) alongside the wordmark in the brand area. Both are required together.
- Keep nav item labels short — one or two words maximum.
- Display the current user's name and role in the footer, not just their avatar.

## Don't

- Don't add section dividers or subgroups to the nav — keep it flat.
- Don't use the sidebar footer area for settings, logout, or secondary navigation; those belong in a separate settings route.
- Don't show the active state on more than one item at a time.
