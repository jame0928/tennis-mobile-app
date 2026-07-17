# Integration Contracts Resources

This folder contains consumer-facing integration resources for the API.

## Structure and Naming Convention

- openapi-consumer.yaml: OpenAPI contract as source of truth.
- openapi-consumer-v1.1.yaml: OpenAPI contract for API v1.1 incrementals.
- postman-consumer-collection.json: Postman collection aligned with OpenAPI.
- ui-ux-guidelines.md: UI and UX guidelines for consumer application components.
- functional-screens.md: Functional screen descriptions mapped to API resources.
- security-guidelines.md: Security requirements and best practices for API integration.
- maintenance-checklist.md: Consistency checklist for future updates.

## Versioning Rules

- Keep all endpoints, parameter names, and examples synchronized between OpenAPI and Postman.
- When adding an endpoint, update all relevant documents in this folder in the same PR.
- Preserve backward-compatible naming unless an explicit breaking change is approved.
- Versioned contracts MUST use suffix naming: `openapi-consumer-v<major>.<minor>.yaml`.

## v1 to v1.1 Compatibility Matrix

| Domain | v1 | v1.1 | Compatibility Notes |
|---|---|---|---|
| Auth | No facade endpoints in contract | `/api/v1.1/auth/login`, `/auth/refresh`, `/auth/logout`, `/auth/session` | New capability. Existing clients can remain on v1 bearer flow. |
| Profile | `/api/v1/me` | `/api/v1.1/me` | Same envelope and private access model. |
| Tournaments List | `/api/v1/tournaments` (authenticated in current contract) | `/api/v1.1/tournaments` (public-read) | Auth requirement changed to public for discovery. |
| Tournament Detail | `/api/v1/tournaments/{tournamentId}` (authenticated in current contract) | `/api/v1.1/tournaments/{tournamentId}` (public-read) | Auth requirement changed to public for detail view. |
| Registrations | `/api/v1/tournaments/{tournamentId}/registrations`, `/api/v1/me/registrations*` | Equivalent `/api/v1.1/*` routes | Same private-domain behavior and envelope. |
| Schedule | `/api/v1/me/schedule`, `/api/v1/tournaments/{tournamentId}/schedule` | Equivalent `/api/v1.1/*` routes | Same behavior, moved to versioned namespace. |
| Rankings | Not available | `/api/v1.1/rankings`, `/api/v1.1/rankings/{rankingId}` | New public resource domain in v1.1. |
| Academies | Not available | `/api/v1.1/academies`, `/api/v1.1/academies/{academyId}` | New public resource domain in v1.1. |
