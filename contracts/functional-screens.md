# Functional Screen Description for Current API Resources

## Scope

This document describes the functional behavior of screens that consume the API contract defined in contracts/openapi-consumer.yaml.

## Screen Map

## 1. Profile Screen

- Resource: GET /api/v1/me
- Actions:
  - Load authenticated profile data.
  - Update editable fields via PATCH /api/v1/me.
- Expected behavior:
  - Show current personal data and save confirmation.
  - Block update when payload is invalid.

## 2. Tournaments Directory Screen

- Resource: GET /api/v1/tournaments
- Actions:
  - List tournaments with search q and filters (status, dates, academy).
  - Paginate with cursor and default limit 10.
- Expected behavior:
  - Show filtered cards with basic tournament metadata.
  - Preserve list/search state across navigation.

## 3. Tournament Detail Screen

- Resource: GET /api/v1/tournaments/{tournamentId}
- Actions:
  - Display category and registration-relevant details.
- Expected behavior:
  - Show not found state for invalid or invisible tournament.

## 4. Registration Creation Flow

- Resource: POST /api/v1/tournaments/{tournamentId}/registrations
- Actions:
  - Submit selected tournament category for authenticated user.
- Expected behavior:
  - Success state with registration id.
  - Handle 409 conflict (duplicate/capacity) and 422 business rules.

## 5. My Registrations Screen

- Resource: GET /api/v1/me/registrations
- Actions:
  - List own registrations using state/payment/tournament filters and q search.
  - Paginate using cursor with default limit 10.
- Expected behavior:
  - Never show records from other users.

## 6. Withdraw Registration Action

- Resource: DELETE /api/v1/me/registrations/{registrationId}
- Actions:
  - Withdraw own registration under allowed tournament status.
- Expected behavior:
  - Success confirmation for valid withdrawal.
  - Business error for invalid state transitions.

## 7. My Schedule Screen

- Resource: GET /api/v1/me/schedule
- Actions:
  - List own matches using q, date range, tournament and status filters.
  - Paginate with cursor default limit 10.
- Expected behavior:
  - Show only matches where authenticated user is participant.

## 8. Tournament Schedule Screen

- Resource: GET /api/v1/tournaments/{tournamentId}/schedule
- Actions:
  - List tournament schedule with date/court/status/search filters.
- Expected behavior:
  - Respect schedule visibility policy (public or restricted).
  - Return forbidden for users outside policy constraints.

## Cross-Screen Rules

- All list endpoints use server-side filtering and pagination.
- All private screens require bearer authentication.
- Error payload rendering should use error.code and request_id for support traces.
