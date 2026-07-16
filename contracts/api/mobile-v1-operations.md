# Mobile API v1 Operations Runbook

## Rollout Strategy (6.1)

1. Deploy API routes behind environment flag for mobile client enablement.
2. Start with internal QA tokens and staging mobile builds.
3. Enable for beta cohort (small percentage of authenticated users).
4. Increase traffic gradually based on error and latency thresholds.

## Metrics (6.2)

Track minimum metrics by endpoint:
- p50, p95, p99 latency
- Error rate by `error.code`
- Requests per minute
- Auth failures (`UNAUTHENTICATED`, `FORBIDDEN`)
- DB query duration and row count where available

## Rollback (6.3)

If critical regression appears:
1. Disable mobile feature flag for affected endpoint group.
2. Revert deployment containing route handlers.
3. Validate web flows are unaffected.
4. Publish incident summary with failing endpoint, error code trend, and rollback timestamp.

## Incident Triage Checklist

1. Confirm request path and request_id from client logs.
2. Identify whether issue is auth, validation, business rule, or DB query.
3. Validate pagination/search parameters in failing requests.
4. Verify data access constraints (own-data filtering and scope requirement).

## Memory/Performance Guardrails

- Never load full collections in API memory and slice afterward.
- Keep filtering and pagination in DB query builder.
- Keep default page size at 10.
- Use deterministic ordering for paginated lists.
