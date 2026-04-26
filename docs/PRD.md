# Product Requirements Document — Meridian Asset Register

**Version:** 1.0  
**Date:** 2026-04-25  
**Status:** Draft for review  
**Author:** TBD  
**Stakeholders:** IT Operations, Engineering, Finance (read-only)

---

## 1. Problem Statement

The firm currently has no centralised way to know which IT assets exist, who holds them, or whether equipment is available for new starters. Asset information lives in spreadsheets, email threads, and individual memory. This creates friction during onboarding/offboarding, makes warranty and maintenance tracking reactive rather than proactive, and leaves finance unable to see real asset value without manual reconciliation.

---

## 2. Goal

Build a lightweight, internal web application that serves as the single source of truth for all IT hardware assets — what the firm owns, who holds each item, and where it is in its lifecycle. The tool should be fast to update and easy to query without training.

---

## 3. Scope

**In scope (v1.0):**

- Asset register (create, view, edit, retire assets)
- Assignment tracking (assign/reassign assets to employees)
- Lifecycle status management (Available → In use → Maintenance → Retired)
- Search and filter across the asset list
- Warranty expiry warnings for assets nearing or past their warranty date
- Empty state onboarding (add first asset)

**Out of scope (v1.0):**

- MDM or automated hardware discovery
- Financial depreciation or reporting
- Purchase order / procurement workflows
- Barcode or QR code scanning
- CSV import
- Audit/activity log
- Mobile native application

---

## 4. Users & Personas

| Persona            | Role                          | Primary Jobs to Be Done                                                                        |
| ------------------ | ----------------------------- | ---------------------------------------------------------------------------------------------- |
| **IT Manager**     | Power user; owns the register | Add new assets, reassign equipment, retire old devices, confirm availability before onboarding |
| **IT Coordinator** | Daily operator                | Look up who holds a specific laptop, check maintenance queue, update serial numbers            |
| **Team Lead**      | Occasional viewer             | Confirm what equipment a team member holds; check if spares are available                      |

---

## 5. User Stories & Acceptance Criteria

### 5.1 Browse the Asset Register

**As an IT Coordinator, I want to see all assets in a table so I can understand the full inventory at a glance.**

Acceptance criteria:

- Displays all assets with columns: Asset (name + serial), Type, Assigned to, Status.
- Table header is sticky when scrolling.
- Each row shows the correct status badge (colour + label) for the asset's current lifecycle state.
- Sidebar shows total asset count and counts per status category.
- Page loads within 2 seconds for up to 500 assets.

---

### 5.2 Search & Filter Assets

**As an IT Manager, I want to search by name, serial number, or assignee so I can find a specific asset without scrolling.**

Acceptance criteria:

- Single search field queries asset name, serial number, and assignee name simultaneously.
- Results update as the user types (debounced ≤ 200ms).
- Type filter dropdown narrows results to: Laptop / Monitor / Accessory / Tablet.
- Status filter dropdown narrows results to: Available / In use / Maintenance / Retired.
- Filters combine with AND logic.
- When results are empty, an inline "No assets match your search" message is shown with a "Clear filters" action.
- Sidebar counts always reflect total records, not filtered results.

---

### 5.3 View Asset Details

**As an IT Coordinator, I want to click an asset and see its full details without leaving the list so I can answer questions quickly without losing my place.**

Acceptance criteria:

- Clicking a row opens a 440px detail drawer on the right; the table remains visible and interactive.
- Drawer shows: asset name, ID, serial number, status badge, type tag, assignee (name + email), and all detail fields (location, purchased, warranty, value).
- If the warranty date is within 30 days or has already passed, the warranty field shows a visual warning indicator alongside the date.
- If the asset is unassigned, the assignee area shows "In store — not assigned".
- Clicking the same row a second time, pressing Escape, or clicking the close button closes the drawer and deselects the row.
- Clicking a different row updates the drawer without closing it.
- Focus returns to the triggering row when the drawer closes.

---

### 5.4 Add a New Asset

**As an IT Manager, I want to register a new asset so it is tracked from the day it arrives.**

Acceptance criteria:

- "Add asset" button opens a centred modal with fields: Name, Type (select), Serial number, Assigned to (employee lookup, optional), Status (visual picker).
- Name, Type, Serial number, and Status are required; the Save button is disabled until these are valid.
- Inline validation errors appear below each invalid field on attempted save.
- Saving closes the modal and the new asset appears in the table immediately.
- The background list blurs while the modal is open.
- Pressing Escape or clicking outside the modal cancels without saving.
- Auto-focus moves to the Name field when the modal opens.
- Focus is trapped inside the modal while it is open.

---

### 5.5 Edit an Existing Asset

**As an IT Manager, I want to correct or update an asset's details so the register stays accurate.**

Acceptance criteria:

- The "Edit" button in the detail drawer opens the asset's fields for editing.
- All fields from the add form are editable.
- Saving updates the asset in place; the drawer reflects the new values immediately.
- Cancelling discards all changes.

---

### 5.6 Assign or Reassign an Asset

**As an IT Manager, I want to assign an available asset to an employee — or move it from one person to another — so the register reflects the current holder.**

Acceptance criteria:

- The "Reassign" button in the detail drawer opens an assignee picker.
- The picker searches employees by name or email.
- Saving updates the "Assigned to" field and changes status to "In use" if it was "Available".
- The action is reflected immediately in both the drawer and the table row.
- Clearing the assignee marks the asset as "Available".

---

### 5.7 Retire an Asset

**As an IT Manager, I want to mark an asset as retired so it no longer appears in the active inventory but is not deleted.**

Acceptance criteria:

- Status can be set to "Retired" via the Add/Edit form or via a direct status change in the drawer.
- Retired assets remain in the register and are visible via the Retired filter or the Retired section in the sidebar.
- Retiring an assigned asset automatically clears the assignee.

---

### 5.8 Onboard with an Empty Register

**As a first-time IT Manager, I want to be guided to add my first asset so I am not stuck in front of a blank screen.**

Acceptance criteria:

- When no assets exist, the main area shows a full empty state with the heading "Start your register".
- An "Add asset" primary button is prominently offered.
- After the first asset is added, the empty state is replaced by the normal table view.

---

### 5.9 Navigate by Status Category

**As an IT Coordinator, I want to jump directly to available or maintenance assets from the sidebar so I can manage the relevant queue without manual filtering.**

Acceptance criteria:

- Sidebar links for Available, Maintenance, Retired, and Assigned to me pre-apply the corresponding status (or assignee) filter.
- The count badge next to each link reflects the live total for that category.
- The active link is visually distinguished from inactive links.

---

## 6. Functional Requirements

### 6.1 Asset Data Fields

| Field          | Required | Type         | Notes                                         |
| -------------- | -------- | ------------ | --------------------------------------------- |
| Name           | Yes      | Text         | Human-readable, e.g. "MacBook Pro 14" M4"     |
| Serial number  | Yes      | Text         | Manufacturer serial                           |
| Type           | Yes      | Enum         | Laptop \| Monitor \| Accessory \| Tablet      |
| Status         | Yes      | Enum         | Available \| In use \| Maintenance \| Retired |
| Assigned to    | No       | Employee ref | Null if unassigned                            |
| Location       | No       | Text         | e.g. "London HQ · Floor 3"                    |
| Purchased      | No       | Date         |                                               |
| Warranty until | No       | Date         |                                               |
| Value          | No       | Currency     |                                               |
| Supplier       | No       | Text         |                                               |
| Purchase order | No       | Text         | Reference only                                |
| Notes          | No       | Text         | Free text; e.g. maintenance context           |

### 6.2 Asset Status Lifecycle

```
available  ──→  inuse        (on assignment)
inuse      ──→  available    (on unassignment)
inuse      ──→  maint        (on fault)
maint      ──→  available    (on repair completion)
any        ──→  retired      (on disposal decision)
```

### 6.3 Permissions Model

All authenticated users have full access to all features in v1.0. Role-based access control is not required at this stage.

---

## 7. Technical Stack

| Concern            | Decision                                                                                    |
| ------------------ | ------------------------------------------------------------------------------------------- |
| Platform           | Power Apps Code App (React + Vite)                                                          |
| Authentication     | Handled by Power Apps; no separate login required                                           |
| Data persistence   | Dataverse                                                                                   |
| Employee directory | Existing Microsoft Entra ID (aaduser) table (name and email lookup for "Assigned to" field) |

---

## 8. Non-Functional Requirements

| Requirement              | Target                                      |
| ------------------------ | ------------------------------------------- |
| Page load (≤ 500 assets) | < 2 seconds                                 |
| Search response          | ≤ 200ms debounce                            |
| Accessibility            | WCAG 2.1 AA                                 |
| Browser support          | Chrome, Edge, Safari, Firefox (current − 1) |
| Responsive               | Desktop-first; usable down to 1024px width  |

---

## 9. User Flows

### 9.1 Add a New Asset

```
Landing on asset list
  → Click "Add asset"
  → Modal opens; focus on Name field
  → Fill Name, Type, Serial, Assigned to, Status
  → Click "Save asset"
  → Modal closes
  → New row appears in table
```

### 9.2 Look Up Who Holds a Specific Device

```
Landing on asset list
  → Type serial number in search field
  → Table filters to matching asset(s)
  → Click the asset row
  → Detail drawer opens showing assignee name and email
```

### 9.3 Prepare Equipment for a New Starter

```
Click "Available" in sidebar
  → Table filtered to all available assets
  → Find the appropriate device
  → Click row to open drawer
  → Click "Reassign"
  → Search for new starter's name
  → Save
  → Asset status changes to "In use"; assignee updated
```

### 9.4 Log a Device for Repair

```
Click the asset row
  → Detail drawer opens
  → Click "Edit"
  → Change Status to "Maintenance"
  → Add a note (e.g. "Keyboard fault — sent to supplier 2026-04-25")
  → Save
  → Asset badge updates to Maintenance in table and drawer
```

---

## 10. Success Metrics

| Metric                                         | Baseline                     | Target (90 days post-launch)           |
| ---------------------------------------------- | ---------------------------- | -------------------------------------- |
| % of IT assets registered in the system        | ~0% (spreadsheets only)      | 100% of active hardware                |
| Time to look up asset holder                   | ~5 min (email / spreadsheet) | < 30 seconds                           |
| Onboarding equipment allocation time           | Ad hoc                       | Same day, self-serve by IT Coordinator |
| Data staleness (assets with outdated assignee) | Unknown                      | < 5% of records                        |
| User adoption (IT team logins per week)        | 0                            | All IT staff weekly active             |
