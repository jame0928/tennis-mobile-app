# Contracts Maintenance Checklist

Use this checklist whenever the consumer API contract changes.

## Consistency Checks

- Endpoint paths in OpenAPI and Postman are identical.
- Required parameters and payload fields are aligned.
- Authentication assumptions are identical across all artifacts.
- Error code examples are consistent with contract implementation.
- Search and pagination behavior (q, limit, cursor, default limit 10) is consistently documented.

## Documentation Checks

- ui-ux-guidelines.md reflects current component and state rules.
- functional-screens.md reflects current screen-to-resource mapping.
- security-guidelines.md reflects current security practices and scope model.

## Review and Ownership

- Change reviewed by API owner and consumer app owner.
- Version/date note added in PR description for contract update.
- Breaking contract changes flagged before merge.
