# Mobile V1 Rollout and Rollback Triggers

## Staged Rollout

1. Internal QA build against staging API with test tokens.
2. Beta cohort release with limited production access.
3. Full release after error and latency thresholds are stable for 24h.

## Operational Triggers

- Roll back if p95 latency increases by 30% for core endpoints.
- Roll back if `UNAUTHENTICATED` or `FORBIDDEN` error rate exceeds 5% unexpectedly.
- Roll back if `CONFLICT` or `BUSINESS_RULE_VIOLATION` spikes indicate client-side rule mismatch.

## Rollback Actions

1. Disable mobile feature flag / distribution ring.
2. Revert to previous mobile release channel.
3. Capture endpoint-level `error.code` and `request_id` trends for incident report.
