## When to use

Use Avatar to represent a named person in compact contexts: the sidebar user footer (28px) and the detail drawer assignee card (36px).

## When not to use

- Do not use Avatar for asset types or non-person entities.
- Do not use Avatar at sizes smaller than 24px — initials become illegible.
- Do not substitute Avatar for a full name where space allows.

## Layout rules

- Sidebar footer: 28px diameter, paired with name (12px 500) and role (11px muted).
- Assignee card: 36px diameter, paired with name (13px 500) and email (12px subtle).
- Always render alongside a visible text name. Avatar alone is not sufficient identification.

## Do

- Derive initials automatically from the name (first letter of each space-delimited word, max 2).
- Keep background accent-soft and text accent-ink regardless of the accent colour variant in use.

## Don't

- Don't use a photo or custom background — the initials treatment is the only approved form.
- Don't render Avatar in a context where the person's name is not also visible nearby.
