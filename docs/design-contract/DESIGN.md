---
name: Meridian Asset Register
components:

  # ── Sidebar ──────────────────────────────────────────────────────────────
  sidebar:
    backgroundColor: "{color.surface-2}"
    borderRight: "1px solid {color.border}"
    padding: "{spacing.xl} {spacing.md}"
    width: "220px"

  sidebar-brand:
    typography: "{typography.wordmark}"
    gap: "{spacing.sm}"
    padding: "4px 10px 12px"

  sidebar-nav-item:
    color: "{color.text-muted}"
    borderRadius: "{radius.md}"
    padding: "7px 10px"
    typography: "{typography.body}"
    gap: "{spacing.sm}"
    icon:
      size: "16px"
      stroke: "currentColor"
      fill: "none"

  sidebar-nav-item-active:
    backgroundColor: "{color.surface}"
    color: "{color.text}"
    fontWeight: "500"

  sidebar-nav-item-hover:
    backgroundColor: "rgba(0,0,0,0.03)"
    color: "{color.text}"

  sidebar-nav-count:
    color: "{color.text-subtle}"
    typography: "{typography.caption}"
    marginLeft: "auto"

  sidebar-footer:
    borderTop: "1px solid {color.border}"
    padding: "12px 10px 0"
    gap: "{spacing.sm}"

  # ── Page header ──────────────────────────────────────────────────────────
  page-header:
    padding: "28px {spacing.5xl} {spacing.xl}"
    layout: "horizontal; title+subtitle on left, primary-action on right, vertically centred"
    primaryAction: "btn-primary (+ Add asset) — right-aligned at the same height as the title"

  page-title:
    typography: "{typography.heading-lg}"
    color: "{color.text}"
    content: "Mirrors the active sidebar nav item label (e.g. 'All assets', 'Available', 'Assigned to me')"

  page-sub:
    typography: "{typography.body}"
    color: "{color.text-muted}"
    marginTop: "{spacing.xs}"
    content: "'{totalCount} items — {availableCount} available to assign' — use em dash (—), not middot (·)"

  # ── Toolbar ──────────────────────────────────────────────────────────────
  toolbar:
    padding: "0 {spacing.5xl} {spacing.lg}"
    gap: "{spacing.md}"
    note: "Toolbar contains only search and filter controls — the primary Add action lives in page-header"

  search-input:
    backgroundColor: "{color.surface}"
    border: "1px solid {color.border}"
    borderRadius: "{radius.md}"
    padding: "{spacing.sm} {spacing.md}"
    typography: "{typography.body}"
    color: "{color.text}"
    placeholderColor: "{color.text-subtle}"

  filter-select:
    backgroundColor: "{color.surface}"
    border: "1px solid {color.border}"
    borderRadius: "{radius.md}"
    padding: "{spacing.sm} {spacing.md}"
    typography: "{typography.body}"
    color: "{color.text}"
    placeholders:
      type: "All types"
      status: "Any status"

  # ── Data table ───────────────────────────────────────────────────────────
  table:
    backgroundColor: "{color.surface}"
    border: "1px solid {color.border}"
    borderRadius: "{radius.lg}"

  table-header:
    backgroundColor: "{color.surface-2}"
    borderBottom: "1px solid {color.border}"
    padding: "12px {spacing.lg}"
    typography: "{typography.label}"
    color: "{color.text-subtle}"
    textAlign: "left"

  table-row:
    padding: "14px {spacing.lg}"
    borderBottom: "1px solid {color.border}"
    typography: "{typography.body}"

  table-row-hover:
    backgroundColor: "{color.surface-2}"

  table-row-selected:
    backgroundColor: "{color.accent-soft}"

  asset-name:
    fontWeight: "500"
    color: "{color.text}"

  asset-serial:
    typography: "{typography.label}"
    color: "{color.text-subtle}"
    marginTop: "2px"

  # ── Detail drawer ────────────────────────────────────────────────────────
  detail-drawer:
    backgroundColor: "{color.surface}"
    borderLeft: "1px solid {color.border}"
    padding: "{spacing.4xl}"
    gap: "{spacing.3xl}"
    width: "440px"

  detail-title:
    typography: "{typography.heading-md}"
    color: "{color.text}"

  detail-subtitle:
    typography: "{typography.body}"
    color: "{color.text-muted}"
    marginTop: "{spacing.xs}"

  detail-tags:
    gap: "{spacing.sm}"
    marginTop: "14px"

  detail-section-label:
    typography: "{typography.section-label}"
    color: "{color.text-muted}"
    marginBottom: "{spacing.md}"

  detail-field:
    padding: "10px 0"
    borderBottom: "1px solid {color.border}"
    typography: "{typography.body}"
    labelColor: "{color.text-muted}"
    valueColor: "{color.text}"
    columns: "130px 1fr"

  detail-assignee-card:
    backgroundColor: "{color.surface-2}"
    borderRadius: "{radius.md}"
    padding: "12px 14px"
    gap: "{spacing.md}"

  # ── Buttons ───────────────────────────────────────────────────────────────
  btn-primary:
    backgroundColor: "{color.accent}"
    color: "white"
    border: "none"
    borderRadius: "{radius.md}"
    padding: "{spacing.sm} 14px"
    typography: "{typography.body}"
    fontWeight: "500"
    gap: "{spacing.xs}"

  btn-primary-hover:
    backgroundColor: "{color.accent-hover}"

  btn-secondary:
    backgroundColor: "{color.surface}"
    color: "{color.text}"
    border: "1px solid {color.border-strong}"
    borderRadius: "{radius.md}"
    padding: "{spacing.sm} 14px"
    typography: "{typography.body}"
    fontWeight: "500"
    gap: "{spacing.xs}"

  btn-ghost:
    backgroundColor: "transparent"
    color: "{color.text-muted}"
    border: "1px solid transparent"
    borderRadius: "{radius.md}"
    padding: "7px 10px"
    typography: "{typography.body}"

  btn-ghost-hover:
    backgroundColor: "{color.surface-2}"
    color: "{color.text}"

  # ── Status badge ─────────────────────────────────────────────────────────
  status-badge:
    borderRadius: "{radius.full}"
    padding: "3px 10px"
    typography: "{typography.label}"
    gap: "{spacing.xs}"

  status-badge-available:
    backgroundColor: "{color.status-available-soft}"
    color: "{color.status-available}"
    dotColor: "{color.status-available}"

  status-badge-inuse:
    backgroundColor: "{color.status-inuse-soft}"
    color: "{color.status-inuse}"
    dotColor: "{color.status-inuse}"

  status-badge-maint:
    backgroundColor: "{color.status-maint-soft}"
    color: "{color.status-maint}"
    dotColor: "{color.status-maint}"

  status-badge-retired:
    backgroundColor: "{color.status-retired-soft}"
    color: "{color.status-retired}"
    dotColor: "{color.status-retired}"

  status-dot:
    width: "6px"
    height: "6px"
    borderRadius: "{radius.full}"

  # ── Tag ───────────────────────────────────────────────────────────────────
  tag:
    backgroundColor: "{color.surface-2}"
    border: "1px solid {color.border}"
    borderRadius: "{radius.full}"
    padding: "3px 10px"
    typography: "{typography.label}"
    color: "{color.text-muted}"

  # ── Avatar ────────────────────────────────────────────────────────────────
  avatar:
    backgroundColor: "{color.accent-soft}"
    color: "{color.accent-ink}"
    borderRadius: "{radius.circle}"
    typography: "{typography.caption}"
    fontWeight: "500"
    size: "28px"

  # ── Form modal ────────────────────────────────────────────────────────────
  form-modal:
    backgroundColor: "{color.surface}"
    border: "1px solid {color.border}"
    borderRadius: "{radius.xl}"
    boxShadow: "{shadow.modal}"
    width: "520px"

  form-header:
    padding: "24px {spacing.3xl} 4px"

  form-title:
    typography: "{typography.heading-sm}"
    color: "{color.text}"

  form-sub:
    typography: "{typography.body}"
    color: "{color.text-muted}"
    marginTop: "{spacing.xs}"

  form-body:
    padding: "{spacing.xl} {spacing.3xl}"
    gap: "18px"

  form-footer:
    padding: "{spacing.lg} {spacing.3xl}"
    borderTop: "1px solid {color.border}"
    gap: "{spacing.sm}"

  input:
    backgroundColor: "{color.surface}"
    border: "1px solid {color.border-strong}"
    borderRadius: "{radius.md}"
    padding: "9px 12px"
    typography: "{typography.body}"
    color: "{color.text}"

  input-focus:
    borderColor: "{color.accent}"
    boxShadow: "{shadow.focus-ring}"

  input-label:
    typography: "{typography.label}"
    color: "{color.text-muted}"

  status-picker:
    columns: "repeat(4, 1fr)"
    gap: "{spacing.sm}"

  status-picker-option:
    padding: "12px 10px"
    border: "1px solid {color.border}"
    borderRadius: "{radius.md}"
    backgroundColor: "{color.surface}"

  status-picker-option-selected:
    borderColor: "{color.accent}"
    backgroundColor: "{color.accent-soft}"

  # ── Empty state ───────────────────────────────────────────────────────────
  empty-state:
    padding: "80px {spacing.4xl}"
    textAlign: "center"

  empty-title:
    typography: "{typography.heading-sm}"
    color: "{color.text}"

  empty-sub:
    typography: "{typography.body}"
    color: "{color.text-muted}"
    lineHeight: "1.5"
    maxWidth: "340px"
    marginTop: "{spacing.sm}"

  empty-actions:
    marginTop: "22px"
    gap: "{spacing.sm}"
---

## Meridian Asset Register — Design Language

### Aesthetic

Meridian reads like a well-kept ledger, not a dashboard. The design is unhurried and practical: warm off-white surfaces, hairline borders, and restrained typographic contrast. There are no decorative elements, no gradients, and no heavy visual treatment. Elevation appears in exactly one place — the form modal's large, soft drop shadow — which reserves the sense of depth for genuine interruption.

The accent colour is intentionally swappable (navy is the default, with sage, terracotta, plum, and graphite as alternatives), but all accent variants are muted and professional. Vivid or saturated accent colours should never be introduced.

### Colour

**Backgrounds:** `color.bg` (#fafaf7) is a warm off-white — closer to paper than a clinical white. It is the canvas on which everything sits. `color.surface` (#ffffff) is reserved for content containers (the table, the detail drawer, modal). `color.surface-2` (#f5f4ef) is a barely-visible warm tint used for secondary surfaces (sidebar, table header rows) and hover states. Do not use `color.surface-2` as a primary background.

**Text:** Three text levels exist. `color.text` for primary content, `color.text-muted` for labels, metadata, and secondary info, `color.text-subtle` for the most de-emphasised content (serial numbers, counts, placeholders). Never invent a fourth text level.

**Accent:** The accent colour is used for primary buttons, selected row backgrounds (the soft tint `color.accent-soft`), focused input borders, and interactive states. It should not be used for decorative purposes or to colour non-interactive text.

**Status colours:** Each status has a saturated foreground and a desaturated soft background. The combination must always be used together — the dot, the text, and the pill background are a single unit. Never use a status colour in isolation (e.g., as a border or text colour outside the badge).

**Dark mode:** All colour tokens have dark-mode counterparts in the `color-dark` group. The semantic meaning of each token is preserved; the dark accent shifts to a lighter navy (#7ba2d9) to maintain contrast on dark surfaces.

### Typography

Two typefaces, strictly separated by role.

**Source Serif 4** is the editorial voice. It appears for page titles, drawer headings, form titles, and section labels (italic). It is always weight 500. It signals structure and hierarchy. It must never appear in table cells, form inputs, button labels, or any data value.

**Inter** is the operational voice. It handles every piece of data, every label, every interactive control. Most UI text sits at 13px (`typography.body`). Column headers and form labels drop to 12px weight 500 (`typography.label`). Captions, counts, and metadata drop to 11px (`typography.caption`).

Section labels within the detail drawer use `typography.section-label` — a 13px italic serif. This is the only italic usage in product UI.

Negative letter-spacing is always applied to serif text. The global sans-serif tracking is a subtle -0.003em.

### Spacing

The base unit is 4px. Nearly every dimension in the design is a multiple of 4. The table row padding uses a CSS density multiplier (`--density`, range 0.7–1.4, default 1.0), allowing the same component to accommodate both compact and comfortable views without separate component variants.

The main content column uses a generous 36px (`spacing.5xl`) horizontal inset. This breathing room is a deliberate choice — it reads as professional restraint, not wasted space. Do not reduce it to gain horizontal space; instead, consider whether the content truly needs more room.

### Strong design opinions

- Borders are always `1px solid`. There are no 2px, no dashed, no double borders anywhere in the design.
- Row selection uses `color.accent-soft` as a background fill. It must not use a left-side border accent, an outline, or any other selection indicator.
- The serif typeface marks boundaries. Wherever you encounter it, you are at a structural heading or an editorial label — never mid-sentence inside a table or form.
- Status is always communicated via the full badge (dot + label + background). Colour alone is never sufficient.
- The form modal is the only component that uses box-shadow for elevation. All other components are flat (distinguished by background colour and hairline borders only).
- Icon strokes match the surrounding text colour. Icons are never filled.
