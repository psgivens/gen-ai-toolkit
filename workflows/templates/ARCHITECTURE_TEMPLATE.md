# Project Architecture (Living Document)

> **Purpose:** This document captures architectural decisions and patterns for this project.
> It should be updated as new patterns are established. Reference this when making design
> decisions for new features.
>
> **Location:** Keep this at project root as `ARCHITECTURE.md` or `docs/ARCHITECTURE.md`
>
> **When to update:** After establishing new patterns, making significant architectural
> decisions, or changing technology choices.

## Technology Stack

### Frontend
- **Framework:** [e.g., React 18.2]
- **UI Library:** [e.g., Material-UI v5, Tailwind CSS]
- **State Management:** [e.g., Redux Toolkit, Zustand, React Context]
- **Routing:** [e.g., React Router v6]
- **Build Tool:** [e.g., Vite, Webpack]
- **Package Manager:** [e.g., npm, yarn, pnpm]

### Backend
- **Runtime:** [e.g., Node.js 18, Python 3.11]
- **Framework:** [e.g., Express 4.18, FastAPI]
- **Database:** [e.g., PostgreSQL 15, MongoDB 6]
- **ORM/ODM:** [e.g., Prisma 5, SQLAlchemy, Mongoose]
- **API Style:** [e.g., REST, GraphQL, gRPC]
- **Authentication:** [e.g., JWT, OAuth2, Session-based]

### Testing
- **Unit Tests:** [e.g., Jest, Pytest, Go testing]
- **Integration Tests:** [e.g., Supertest, Pytest fixtures]
- **E2E Tests:** [e.g., Playwright, Cypress]
- **Test Coverage Tool:** [e.g., Istanbul, Coverage.py]

### Infrastructure
- **Hosting:** [e.g., AWS, GCP, Azure, Vercel]
- **Container Platform:** [e.g., Docker, Kubernetes]
- **CI/CD:** [e.g., GitHub Actions, GitLab CI, Jenkins]
- **Monitoring:** [e.g., Datadog, New Relic, Prometheus]
- **Logging:** [e.g., Winston, Pino, Python logging]

## Code Organization

### Directory Structure

```
project-root/
├── src/                    # Source code
│   ├── api/               # API routes and controllers
│   ├── components/        # UI components (if frontend)
│   ├── services/          # Business logic layer
│   ├── models/            # Data models and schemas
│   ├── middleware/        # Request/response middleware
│   ├── utils/             # Shared utilities
│   ├── config/            # Configuration files
│   └── types/             # TypeScript types (if using TS)
├── tests/                 # Test files
│   ├── unit/             # Unit tests
│   ├── integration/      # Integration tests
│   └── e2e/              # End-to-end tests
├── docs/                  # Documentation
├── scripts/               # Build and utility scripts
└── [config files]         # package.json, tsconfig.json, etc.
```

**Rationale:** [Explain why this structure was chosen]

### Naming Conventions

- **Files:** [e.g., camelCase.ts, snake_case.py]
- **Components:** [e.g., PascalCase for React components]
- **Functions:** [e.g., camelCase for functions]
- **Constants:** [e.g., UPPER_SNAKE_CASE]
- **Classes:** [e.g., PascalCase]

## Entry Points

Key files where execution begins or components are wired together:

- **Main entry point:** `[e.g., src/main.ts, cmd/main.go, index.js]` - Application starts here
- **CLI root:** `[e.g., cmd/root.go, src/cli.ts]` - Command-line interface entry (if applicable)
- **API entry:** `[e.g., src/api/server.ts, internal/server/server.go]` - HTTP server setup
- **Key orchestration:** `[e.g., src/app.ts, internal/app/app.go]` - Where components are initialized and wired together
- **Plugin system:** `[e.g., src/plugins/index.ts, internal/plugin/composite.go]` - Extensibility entry point (if applicable)
- **Database setup:** `[e.g., src/db/connection.ts, internal/database/db.go]` - Database initialization

**Why this matters:** These files are your starting points for understanding how the system works. Start here when exploring the codebase.

## Architectural Patterns

### API Design Pattern

**Style:** [REST / GraphQL / RPC]

**Conventions:**
- **Endpoint naming:** [e.g., /api/v1/resources, plural nouns]
- **HTTP methods:** [e.g., GET for read, POST for create, PUT for full update, PATCH for partial, DELETE]
- **Request format:** [e.g., JSON body with snake_case keys]
- **Response format:**
  ```json
  {
    "data": {...},
    "error": null,
    "meta": {...}
  }
  ```
- **Error responses:**
  ```json
  {
    "data": null,
    "error": {
      "code": "VALIDATION_ERROR",
      "message": "User-friendly message",
      "details": [...]
    }
  }
  ```
- **Authentication:** [e.g., Bearer token in Authorization header]
- **Versioning:** [e.g., URL path versioning /api/v1/]

**Example:**
```
GET /api/v1/users/:id
POST /api/v1/users
PUT /api/v1/users/:id
DELETE /api/v1/users/:id
```

### Database Pattern

**Access Layer:** [e.g., Repository pattern, Active Record, Query builders]

**Schema Management:**
- **Migrations:** [e.g., How migrations are created and run]
- **Seeding:** [e.g., How test/dev data is loaded]

**Query Patterns:**
- [e.g., Use ORM query builders, avoid raw SQL unless necessary]
- [e.g., Implement pagination using cursor-based approach]
- [e.g., Use transactions for multi-step operations]

**Example:**
```typescript
// Repository pattern example
class UserRepository {
  async findById(id: string): Promise<User | null> {
    return prisma.user.findUnique({ where: { id } });
  }
}
```

### Error Handling Pattern

**Philosophy:** [e.g., Explicit errors, fail fast, provide context]

**Implementation:**
- **Custom error classes:** [e.g., ValidationError, NotFoundError, AuthError]
- **Error middleware:** [e.g., Centralized error handler in Express]
- **Logging:** [e.g., Log all errors with context, PII scrubbing]
- **User-facing messages:** [e.g., Generic messages for security, detailed for validation]

**Example:**
```typescript
// Throw custom errors
throw new ValidationError('Email is required', { field: 'email' });

// Centralized handler catches and formats
app.use((err, req, res, next) => {
  logger.error(err);
  res.status(err.statusCode || 500).json({
    error: {
      code: err.code,
      message: err.message
    }
  });
});
```

### State Management Pattern

**Approach:** [e.g., Redux with slices, React Context, Zustand stores]

**Organization:**
- **Global state:** [e.g., User auth, app settings]
- **Feature state:** [e.g., Feature-specific slices or contexts]
- **Server state:** [e.g., React Query for API data caching]
- **Local state:** [e.g., useState for component-only state]

**Example:**
```typescript
// Redux slice for user state
const userSlice = createSlice({
  name: 'user',
  initialState: { data: null, loading: false },
  reducers: { ... }
});
```

### Testing Pattern

**Test Organization:**
- **Location:** [e.g., Tests adjacent to source files __tests__/, or separate tests/ directory]
- **Naming:** [e.g., filename.test.ts, test_filename.py]

**Testing Strategy:**
- **Unit tests:** Test individual functions/classes in isolation
- **Integration tests:** Test feature workflows with real dependencies
- **E2E tests:** Test critical user journeys through UI

**Mocking Approach:**
- [e.g., Mock external APIs, use test database for DB tests]
- [e.g., Mock date/time for deterministic tests]

**Example:**
```typescript
describe('UserService', () => {
  it('should create user with valid data', async () => {
    const user = await userService.create({ email: 'test@example.com' });
    expect(user.email).toBe('test@example.com');
  });
});
```

## Design Principles

### Principle 1: [Name, e.g., "Consistency over novelty"]
**What:** [Describe the principle]
**Why:** [Explain the rationale]
**How:** [Provide concrete guidance]
**Example:** [Show code or pattern example]

### Principle 2: [Name, e.g., "Explicit over implicit"]
**What:** Prefer explicit code that's easy to understand over clever implicit code
**Why:** Makes code more maintainable, easier to debug, reduces cognitive load
**How:**
- Use descriptive variable names over abbreviations
- Prefer explicit error handling over silent failures
- Avoid magic numbers/strings, use named constants
**Example:**
```typescript
// Bad (implicit)
if (u.s === 1) { ... }

// Good (explicit)
const USER_STATUS_ACTIVE = 1;
if (user.status === USER_STATUS_ACTIVE) { ... }
```

### Principle 3: [Name, e.g., "Robustness over performance"]
**What:** Prioritize correctness and data integrity over raw speed
**Why:** This is a critical business application where data accuracy is paramount
**How:**
- Use database transactions for multi-step operations
- Validate all inputs thoroughly
- Prefer ACID-compliant databases
- Add performance optimizations only after measuring bottlenecks

## Common Operations

Step-by-step guides for frequent development tasks.

### How to Add a New API Endpoint

1. Create route handler in `src/api/routes/[resource].ts`
2. Implement business logic in `src/services/[resource]Service.ts`
3. Add request validation using [validation library]
4. Add response types in `src/types/api.ts`
5. Write unit tests for service logic
6. Write integration tests for endpoint
7. Update API documentation

**Example:**
```typescript
// 1. Route (src/api/routes/users.ts)
router.post('/users', validateRequest(createUserSchema), async (req, res) => {
  const user = await userService.create(req.body);
  res.json({ data: user });
});

// 2. Service (src/services/userService.ts)
export class UserService {
  async create(data: CreateUserDto): Promise<User> {
    // Business logic here
  }
}
```

### How to Add a New UI Component

1. Create component file in `src/components/[ComponentName]/`
2. Follow [design system] for styling
3. Add TypeScript prop types
4. Write component tests
5. Add to component index for easy imports
6. Document props and usage in Storybook (if applicable)

**Example:**
```typescript
// src/components/Button/Button.tsx
interface ButtonProps {
  label: string;
  onClick: () => void;
  variant?: 'primary' | 'secondary';
}

export const Button: React.FC<ButtonProps> = ({ label, onClick, variant = 'primary' }) => {
  return <button className={variant} onClick={onClick}>{label}</button>;
};
```

### How to Add a New Database Table

1. Create migration file: `[timestamp]_create_[table].sql`
2. Define table schema with appropriate constraints
3. Add indexes for commonly queried columns
4. Create corresponding model in `src/models/[table].ts`
5. Write repository methods for CRUD operations
6. Add model tests
7. Run migration in dev and test environments

## Decision Log

Use this section to record significant architectural decisions. Add new entries as decisions are made.

### [Decision]: Use React instead of Vue
**Date:** 2026-01-15
**Context:** Needed to choose frontend framework for new application
**Decision:** Selected React 18 with TypeScript
**Rationale:**
- Team has more React experience
- Larger ecosystem and component library availability
- Better TypeScript support
- Easier to hire developers with React skills
**Consequences:**
- All new frontend work will use React
- Need to establish React coding standards
- Component library chosen: Material-UI v5
**Alternatives considered:**
- Vue 3: Good framework but less team experience
- Angular: Too heavyweight for our needs

### [Decision]: Use PostgreSQL over MongoDB
**Date:** 2026-01-20
**Context:** Needed to choose primary database
**Decision:** PostgreSQL 15 with Prisma ORM
**Rationale:**
- Data is highly relational (users, orders, products)
- Need ACID guarantees for financial transactions
- Complex query requirements for reporting
- Team prefers SQL
**Consequences:**
- All data models will have defined schemas
- Use migrations for schema changes
- Can leverage PostgreSQL advanced features (JSON columns, full-text search)
**Alternatives considered:**
- MongoDB: Better for document storage but our data is relational
- MySQL: Similar to PostgreSQL but less feature-rich

---

## When to Update This Document

Update this living document when:

- ✅ Making a significant architectural decision (add to Decision Log)
- ✅ Establishing a new pattern that will be used in 2+ places
- ✅ Changing technology choices (update Technology Stack)
- ✅ Discovering that existing documentation is outdated (fix it)
- ✅ Onboarding new team members reveals missing information
- ✅ Completing a feature that introduces new patterns

**How to update:**
1. Make your changes to this file
2. Commit with message: "docs: update architecture - [what changed]"
3. Notify team of significant changes

**Who can update:**
- Any team member can propose updates
- Senior engineers approve major architectural changes
- Keep changes focused and well-documented

---

## Related Documentation

- [Design Decisions](./DESIGN.md) - Feature-specific design documents
- [API Documentation](./api/README.md) - API endpoint details
- [Development Guide](./DEVELOPMENT.md) - How to set up and run the project
- [Contributing Guide](./CONTRIBUTING.md) - How to contribute to the project
