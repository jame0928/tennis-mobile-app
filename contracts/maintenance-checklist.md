# Contracts Maintenance Checklist

Use this checklist whenever the consumer API contract changes.

## Consistency Checks

- Endpoint paths in OpenAPI and Postman are identical.
- Required parameters and payload fields are aligned.
- Authentication assumptions are identical across all artifacts.
- Error code examples are consistent with contract implementation.
- Search and pagination behavior (q, limit, cursor, default limit 10) is consistently documented.
- v1 and v1.1 artifacts keep explicit version naming and namespace parity.
- Public-read vs private endpoints are identical between OpenAPI v1.1 and Postman examples.
- Auth facade endpoints in v1.1 do not require direct provider endpoint references.

## Documentation Checks

- ui-ux-guidelines.md reflects current component and state rules.
- functional-screens.md reflects current screen-to-resource mapping.
- security-guidelines.md reflects current security practices and scope model.
- README.md includes updated compatibility matrix for active contract versions.

## Review and Ownership

- Change reviewed by API owner and consumer app owner.
- Version/date note added in PR description for contract update.
- Breaking contract changes flagged before merge.
