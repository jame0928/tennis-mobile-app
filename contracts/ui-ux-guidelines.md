# UI and UX Guidelines for API Consumer App

## Design Principles

- Clarity first: each screen must expose one primary user intention.
- Progressive disclosure: reveal advanced filters and details only when needed.
- Consistent feedback: loading, empty, success, and error states on every data view.
- Accessibility baseline: contrast, focus visibility, and touch target sizes.

## Color Palette and Usage

Primary palette:

- Navy 900: #0B1F3A (primary surfaces, headers)
- Blue 600: #1E63D8 (primary actions)
- Teal 500: #18A999 (status accents)
- Amber 500: #F59E0B (warnings)
- Red 600: #DC2626 (errors/destructive)
- Gray 900: #111827 (main text)
- Gray 500: #6B7280 (secondary text)
- Gray 100: #F3F4F6 (background sections)
- White: #FFFFFF (cards/background contrast)

Usage rules:

- Use Blue 600 only for primary CTA and selected navigation state.
- Use Teal 500 for positive statuses, never for destructive actions.
- Use Red 600 exclusively for errors, forbidden actions, or destructive confirmations.
- Keep body text on Gray 900 over White or Gray 100 with AA contrast.
- Avoid mixing more than one accent color per component block.

## Component Guidelines

- Buttons:
  - Primary: solid Blue 600, white text.
  - Secondary: outline Navy 900 or Gray 500.
  - Danger: solid Red 600.
- Inputs and filters:
  - Search bar always visible in list screens.
  - Inline validation message below field with error color and concise text.
- Cards:
  - Use for tournament and match summaries.
  - Include title, status badge, and one primary action.
- Status badges:
  - Registration Open: Teal.
  - In Progress: Blue.
  - Completed: Gray.
  - Cancelled/Rejected: Red.

## Screen Behavior and States

Every API-backed screen must include:

- Loading state: skeleton placeholders.
- Empty state: contextual explanation and next action.
- Error state: clear message and retry action.
- Pagination state: visible load-more or infinite scroll trigger, respecting limit default 10.

## Responsive Behavior

- Mobile first breakpoints.
- Single-column layout for lists on small screens.
- Sticky top actions (search/filter) on mobile list views.
- Preserve readable line length for long descriptions.

## Interaction Patterns

- Keep destructive actions behind confirmation dialog.
- Preserve filter/search state when navigating details and returning.
- Use optimistic updates only when rollback strategy is clear.
