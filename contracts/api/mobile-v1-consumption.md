# Mobile API v1 Consumption Guide

## Base URL and Auth

- Base path: `/api/v1`
- Auth: `Authorization: Bearer <supabase_access_token>`
- Private endpoints derive user identity from token; clients must not send `profile_id`.

## Response Envelope

### Success

```json
{
  "success": true,
  "data": {},
  "meta": {
    "request_id": "uuid",
    "has_more": false,
    "next_cursor": null,
    "limit": 10
  }
}
```

### Error

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid query parameters",
    "details": {}
  },
  "request_id": "uuid"
}
```

## Error Codes

- `VALIDATION_ERROR`
- `UNAUTHENTICATED`
- `FORBIDDEN`
- `NOT_FOUND`
- `CONFLICT`
- `BUSINESS_RULE_VIOLATION`
- `RATE_LIMITED`
- `INTERNAL_ERROR`

## Scope Matrix

- `GET /api/v1/me` -> `profile:read`
- `PATCH /api/v1/me` -> `profile:write`
- `GET /api/v1/tournaments` -> `tournaments:read`
- `GET /api/v1/tournaments/{tournamentId}` -> `tournaments:read`
- `POST /api/v1/tournaments/{tournamentId}/registrations` -> `registrations:write:own`
- `GET /api/v1/me/registrations` -> `registrations:read:own`
- `DELETE /api/v1/me/registrations/{registrationId}` -> `registrations:write:own`
- `GET /api/v1/me/schedule` -> `schedule:read:own`
- `GET /api/v1/tournaments/{tournamentId}/schedule` -> `schedule:read:tournament`

## Pagination

All GET list endpoints use cursor pagination.

Query params:
- `limit` (optional, default `10`, max `100`)
- `cursor` (optional)

Meta response:
- `has_more`
- `next_cursor`
- `limit`

## Search Field (`q`) by Model

Search is executed at database query level.

- `GET /api/v1/tournaments`
  - Text fields: `name`, `slug`, `description`, `venue`
- `GET /api/v1/me/registrations`
  - Text fields: `payment_reference`, `payment_proof_notes`
- `GET /api/v1/me/schedule`
  - Text fields: `round_name`, `court_name`, `score_summary`
- `GET /api/v1/tournaments/{tournamentId}/schedule`
  - Text fields: `round_name`, `court_name`, `score_summary`

## Examples

### Get tournaments with search and pagination

`GET /api/v1/tournaments?q=open&limit=10&cursor=<cursor>`

### Get own registrations filtered by state

`GET /api/v1/me/registrations?state=active&limit=10`

### Get own schedule filtered by date range

`GET /api/v1/me/schedule?from=2026-07-15T00:00:00.000Z&to=2026-07-20T23:59:59.999Z`
