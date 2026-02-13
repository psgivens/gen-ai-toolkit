# Project Development Guide

> **Purpose:** This document contains project-specific guidelines for AI-assisted development with Claude Code.
>
> **Location:** Keep this at `docs/CLAUDE.md` in your project repository.
>
> **Audience:** Claude Code and human developers working on this project.
>
> This complements the global `~/.claude/CLAUDE.md` with repository-specific context.

## Quick Reference

### Build & Test Commands

```bash
# Install dependencies
[e.g., npm install, pip install -r requirements.txt, go mod download]

# Run all tests
[e.g., npm test, pytest, go test ./...]

# Run specific test
[e.g., npm test path/to/test, pytest tests/test_file.py, go test ./internal/pkg]

# Build
[e.g., npm run build, python setup.py build, go build]

# Run locally
[e.g., npm start, python main.py, go run main.go]

# Lint
[e.g., npm run lint, flake8, golangci-lint run]

# Format code
[e.g., npm run format, black ., gofmt -w .]
```

### Common File Locations

- **Main entry:** `[e.g., src/main.ts, main.py, cmd/app/main.go]`
- **Configuration:** `[e.g., config/, .env, settings.py]`
- **Tests:** `[e.g., tests/, __tests__/, internal/*/test]`
- **Documentation:** `docs/`
- **Build output:** `[e.g., dist/, build/, bin/]`

## Development Workflow

### Before Starting Work

1. **Pull latest changes:** `git pull origin main`
2. **Create feature branch:** `git checkout -b feature/your-feature-name`
3. **Install dependencies:** `[install command]`
4. **Run tests to ensure baseline:** `[test command]`

### Making Changes

1. **Follow branching strategy:** [e.g., feature/*, bugfix/*, hotfix/*]
2. **Commit message format:** [e.g., "feat: add user authentication", "fix: resolve login timeout"]
3. **Testing requirements:** All new code must have tests, maintain >80% coverage
4. **Code review:** Required before merge, at least one approval

### Before Committing

```bash
# Run tests
[test command]

# Run linter
[lint command]

# Run formatter
[format command]

# Check test coverage
[coverage command]
```

## Key Patterns

### Pattern 1: [Name, e.g., "Error Handling"]

**When to use:** [Context where this pattern applies]

**Implementation:**
```[language]
// Example implementation
try {
  await riskyOperation();
} catch (error) {
  logger.error('Operation failed', { error, context });
  throw new CustomError('User-friendly message', error);
}
```

**Files using this pattern:**
- `[example file 1]`
- `[example file 2]`

**Why this pattern:** [Rationale - e.g., "Consistent error logging and user-facing messages"]

### Pattern 2: [Name, e.g., "Repository Pattern for Data Access"]

**When to use:** [e.g., "All database access"]

**Implementation:**
```[language]
// Repository interface
interface UserRepository {
  findById(id: string): Promise<User | null>;
  save(user: User): Promise<User>;
}

// Usage in service layer
class UserService {
  constructor(private userRepo: UserRepository) {}

  async getUser(id: string): Promise<User> {
    const user = await this.userRepo.findById(id);
    if (!user) throw new NotFoundError('User not found');
    return user;
  }
}
```

**Files using this pattern:**
- `src/repositories/` - Repository implementations
- `src/services/` - Services that use repositories

**Why this pattern:** [e.g., "Decouples business logic from data access, easier to test"]

### Pattern 3: [Name, e.g., "Feature Flags"]

**When to use:** [e.g., "Gradual rollouts, experimental features"]

**Implementation:**
```[language]
if (featureFlags.isEnabled('new-search-algorithm')) {
  return newSearchAlgorithm(query);
} else {
  return legacySearchAlgorithm(query);
}
```

**Configuration:** `[e.g., config/features.json, environment variables]`

**Why this pattern:** [e.g., "Safe rollouts, easy rollback, A/B testing"]

## Common Gotchas

### Gotcha 1: [Description, e.g., "Database Connections Not Closed"]

**Problem:** Database connection pool exhaustion causing timeouts

**Symptom:**
```
Error: Connection pool timeout
ECONNREFUSED at db.query()
```

**Cause:** Forgetting to close database connections after queries

**Solution:**
```[language]
// Bad - connection not released
const result = await db.query('SELECT * FROM users');
return result;

// Good - use try/finally or connection pooling
const conn = await db.getConnection();
try {
  const result = await conn.query('SELECT * FROM users');
  return result;
} finally {
  conn.release();
}
```

**Prevention:** Always use connection pooling library and ensure connections are released

**Files to watch:** `[e.g., src/database/*.ts, src/repositories/*.ts]`

### Gotcha 2: [Description, e.g., "Race Conditions in Async Code"]

**Problem:** [Description of what goes wrong]

**Symptom:** [What you see when this happens]

**Cause:** [Root cause explanation]

**Solution:** [Code example showing fix]

**Prevention:** [How to avoid this in the future]

### Gotcha 3: [Description, e.g., "Environment Variables Not Loaded"]

**Problem:** Application crashes with "undefined" config values

**Cause:** Environment variables loaded after they're referenced

**Solution:**
```[language]
// At the very start of main.ts/main.py/main.go
import { config } from './config'; // Loads .env
// Now safe to use process.env.DATABASE_URL
```

**Prevention:** Always load environment config first in entry point

## Integration Points

### [External System 1, e.g., "AWS S3"]

**Purpose:** File storage for user uploads

**Location:** `src/services/storage/s3Client.ts`

**Authentication:**
- Uses AWS IAM roles in production
- Uses access keys in development (stored in `.env`)
- Required env vars: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_REGION`

**Key operations:**
```[language]
// Upload file
await s3Client.uploadFile(bucket, key, fileStream);

// Download file
const stream = await s3Client.downloadFile(bucket, key);

// Delete file
await s3Client.deleteFile(bucket, key);
```

**Common Issues:**
- **Issue:** "Access Denied" errors
  - **Cause:** IAM role missing permissions
  - **Solution:** Check IAM policy includes `s3:PutObject`, `s3:GetObject`, `s3:DeleteObject`
- **Issue:** Large file uploads timing out
  - **Solution:** Use multipart upload for files >5MB

**Documentation:** [Link to AWS S3 docs or internal wiki]

### [External System 2, e.g., "Stripe Payment API"]

**Purpose:** [Why we integrate]

**Location:** [Where integration code lives]

**Authentication:** [How auth works]

**Key operations:** [Common API calls with examples]

**Common Issues:** [Known problems and solutions]

## Testing Guidelines

### What to Test

**Must test:**
- ✅ All business logic (service layer)
- ✅ API endpoints (integration tests)
- ✅ Database queries (repository layer)
- ✅ Error handling and edge cases
- ✅ Authentication and authorization
- ✅ Data validation

**Should test:**
- UI components with complex logic
- Utility functions
- Configuration loading

### What NOT to Test

**Don't test:**
- ❌ Third-party library internals
- ❌ Simple getters/setters without logic
- ❌ Framework code (Express, React, etc.)
- ❌ Generated code
- ❌ Trivial pass-through functions

### Test Organization

**Unit tests:**
- **Location:** `tests/unit/` or next to source files as `*.test.ts`
- **Pattern:** Test individual functions/classes in isolation
- **Mocking:** Mock all external dependencies (DB, APIs, file system)
- **Naming:** `describe('[ClassName/FunctionName]')` and `it('should [behavior]')`

**Integration tests:**
- **Location:** `tests/integration/`
- **Pattern:** Test multiple components working together
- **Setup:** Use test database, mock external APIs only
- **Naming:** `describe('[Feature] integration')` and `it('should [end-to-end behavior]')`

**E2E tests:**
- **Location:** `tests/e2e/`
- **Pattern:** Test complete user workflows through UI/API
- **Setup:** Full application stack, test database
- **Naming:** `describe('[User journey]')` and `it('user should be able to [action]')`

### Test Data

**Test fixtures:** `tests/fixtures/` - Reusable test data

**Test database:**
- Separate test database: `[e.g., myapp_test]`
- Reset before each test suite: `[command to reset]`
- Seed script: `[script location]`

## Code Review Checklist

Before requesting review, ensure:

- [ ] All tests pass locally
- [ ] Test coverage maintained or improved
- [ ] Code follows project style guide
- [ ] No console.log/print statements (use logger)
- [ ] Error handling is explicit
- [ ] [Project-specific check 1, e.g., "API endpoints have rate limiting"]
- [ ] [Project-specific check 2, e.g., "Database migrations included if schema changed"]
- [ ] [Project-specific check 3, e.g., "Feature flags added for new features"]
- [ ] Documentation updated (README, API docs, inline comments for complex logic)
- [ ] No hardcoded secrets (use environment variables)
- [ ] Commit messages follow format

## Learnings & Evolution

Document significant learnings and pattern changes over time.

### 2026-02-13: Switched from REST to GraphQL for Complex Queries

**What changed:** New endpoints use GraphQL instead of REST

**Why:** REST endpoints were becoming too numerous and complex for our data model

**Impact:**
- New features should use GraphQL
- Existing REST endpoints remain for backward compatibility
- See `docs/code/GRAPHQL_GUIDE.md` for implementation pattern

**Migration:** No action needed, both APIs coexist

### [Date]: [Learning or Pattern Change Title]

**What changed:** [Description of what's different now]

**Why:** [Rationale for the change]

**Impact:** [How this affects development going forward]

**Migration:** [What existing code needs to change, if any]

## Related Documentation

- [ARCHITECTURE.md](./ARCHITECTURE.md) - System architecture and design
- [docs/code/](./code/) - Component guides and subsystem documentation
- [docs/adrs/](./adrs/) - Architecture Decision Records
- [API Documentation](./API.md) - API endpoint reference
- [CONTRIBUTING.md](../CONTRIBUTING.md) - Contribution guidelines
- [README.md](../README.md) - Project overview and quick start

## Maintaining This Document

**Update this document when:**
- ✅ New patterns are established (add to Key Patterns)
- ✅ Common issues are discovered (add to Gotchas)
- ✅ Build/test commands change (update Quick Reference)
- ✅ Integration points are added or changed (update Integration Points)
- ✅ Significant learnings occur (add to Learnings & Evolution)
- ✅ Development workflow changes (update Development Workflow)

**How to update:**
1. Edit `docs/CLAUDE.md`
2. Commit with message: `docs: update CLAUDE.md - [what changed]`
3. Keep it focused on high-value, actionable information

**Who can update:**
- Any team member who discovers valuable information worth documenting
- Keep it concise - remove outdated information as it's replaced

---

*This document makes the codebase easier to navigate and reduces repetitive explanations of project-specific patterns.*
