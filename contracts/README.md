# Integration Contracts Resources

This folder contains consumer-facing integration resources for the API.

## Structure and Naming Convention

- openapi-consumer.yaml: OpenAPI contract as source of truth.
- postman-consumer-collection.json: Postman collection aligned with OpenAPI.
- ui-ux-guidelines.md: UI and UX guidelines for consumer application components.
- functional-screens.md: Functional screen descriptions mapped to API resources.
- security-guidelines.md: Security requirements and best practices for API integration.
- maintenance-checklist.md: Consistency checklist for future updates.

## Versioning Rules

- Keep all endpoints, parameter names, and examples synchronized between OpenAPI and Postman.
- When adding an endpoint, update all relevant documents in this folder in the same PR.
- Preserve backward-compatible naming unless an explicit breaking change is approved.
