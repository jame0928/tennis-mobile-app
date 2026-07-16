# Security Guidelines for API Integration

## Authentication and Authorization

- Use bearer JWT tokens from trusted authentication flow.
- Send token only in Authorization header.
- Never send profile_id in private endpoint payloads; identity is token-derived.
- Respect endpoint scope model:
  - profile:read, profile:write
  - tournaments:read
  - registrations:read:own, registrations:write:own
  - schedule:read:own, schedule:read:tournament

## Transport Security

- Use HTTPS only in all non-local environments.
- Reject mixed-content API usage from clients.
- Pin trusted hostnames for production and staging API base URLs.

## Secret Management

- Do not hardcode tokens, API hosts, or credentials in source code.
- Store secrets in secure client storage according to platform best practices.
- Rotate tokens and invalidate sessions on suspicious activity.

## Request and Response Safety

- Validate all user-provided input before sending requests.
- Avoid logging full tokens or sensitive payloads.
- In telemetry/logging, mask identifiers where possible.
- Handle API error responses safely and avoid exposing internals to end users.

## Pagination and Search Safety

- Use bounded limits; default to 10 where client does not specify.
- Never attempt client-side bulk fetches for protected resources.
- Use q search and cursor pagination as contract-defined.

## Operational Security Practices

- Monitor 401, 403, 409, and 422 trends for integration anomalies.
- Use request_id from error responses for traceability and support.
- Keep OpenAPI and Postman artifacts aligned to avoid unsafe fallback behavior.

## Consumer Security Checklist

- Token stored securely and refreshed safely.
- HTTPS enforced in all configured environments.
- Error handling implemented with request_id capture.
- No sensitive values in logs or crash reports.
- Contract artifacts reviewed on each API version update.
