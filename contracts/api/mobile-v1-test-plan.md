# Mobile API v1 Test Plan

## Contract Tests (5.1)

For each endpoint, verify:
- Response envelope success shape
- Error envelope shape
- Correct HTTP status mapping
- `request_id` presence

Endpoints:
- `GET /api/v1/me`
- `PATCH /api/v1/me`
- `GET /api/v1/tournaments`
- `GET /api/v1/tournaments/{tournamentId}`
- `POST /api/v1/tournaments/{tournamentId}/registrations`
- `GET /api/v1/me/registrations`
- `DELETE /api/v1/me/registrations/{registrationId}`
- `GET /api/v1/me/schedule`
- `GET /api/v1/tournaments/{tournamentId}/schedule`

## Authorization Tests (5.2)

- Missing bearer token -> `401`
- Missing scope -> `403`
- Attempt to pass `profile_id` in private payload -> `400`
- Attempt to retrieve non-owned registration/schedule -> `403` or `404`

## Pagination Tests (5.3)

- No `limit` -> returns at most 10
- `limit` provided -> respects limit
- `next_cursor` drives next page
- Stable ordering between pages

## Search Tests (5.5)

Validate `q` against defined model text fields:
- tournaments: `name`, `slug`, `description`, `venue`
- my registrations: `payment_reference`, `payment_proof_notes`
- my schedule / tournament schedule: `round_name`, `court_name`, `score_summary`

## Performance/Memory Tests (5.6)

- Load test list endpoints with large datasets
- Verify memory does not scale linearly with total dataset size
- Verify query planner uses filtered/paginated SQL path

## Business Regression Tests (5.4)

- Duplicate registration -> `409`
- Closed registration window -> `422`
- Full category capacity -> `409`
- Withdraw allowed only while registration is open -> `422` otherwise
