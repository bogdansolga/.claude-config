# finances-manager - Developer Context

## Tech Stack

- **Framework**: Next.js 16 with App Router and Turbopack
- **Language**: TypeScript (strict mode)
- **Database**: PostgreSQL with Drizzle ORM
- **Auth**: better-auth library
- **Testing**: Vitest (unit + integration)
- **Linting/Formatting**: Biome
- **Package Manager**: Bun
- **UI**: Tailwind CSS, Radix UI components

## Architecture Layers

```
src/
  app/
    [locale]/           # Internationalized pages (do NOT restructure)
    api/v1/             # API routes
  lib/
    core/
      db/schema/        # Drizzle schema definitions (source of truth)
      auth/             # Authentication middleware
      http/             # Error handling, response utilities
    repositories/       # Data access layer (raw DB queries)
    services/           # Business logic layer
    schemas/            # Zod validation schemas for API requests
    types/              # TypeScript types (re-exports from schema)
tests/
  unit/               # Unit tests (mocked dependencies)
  integration/        # Integration tests (real database)
```

**Data flow**: API Route -> Service -> Repository -> Schema

## Core Business Entities

### Holdings (src/lib/core/db/schema/holdings.schema.ts)
- **Account**: Financial holding (cash, stocks, crypto, commodities)
  - Key fields: `name`, `currency`, `amount`, `assetClass`, `ownerType`, `isArchived`, `householdId`
  - Supports multi-currency wallets via `accountGroup`
  - `isArchived`: Hidden from dropdowns but preserved for history
- **AccountHistory**: Tracks balance changes over time

### Inbound (src/lib/core/db/schema/inbound.schema.ts)
- **Customer**: Client with invoicing details and forecast settings
- **Invoice**: Issued invoices with payment tracking
- **Receivable**: Money owed TO you (counterparty, amount, dueDate, status)
  - Status lifecycle: `pending` -> `settled` (or `cancelled`)
  - Supports partial payments via `paidAmount` field
  - When `paidAmount` equals `amount`, status transitions to `settled`
- **RecurringIncome**: Fixed monthly income (e.g., rent)

### Outbound (src/lib/core/db/schema/outbound.schema.ts)
- **Payable**: Money YOU owe (counterparty, amount, dueDate, status)
  - Status lifecycle: `pending` -> `settled` (or `cancelled`)
  - Supports partial payments via `paidAmount` field
  - When `paidAmount` equals `amount`, status transitions to `settled`
- **RecurringExpense**: Fixed monthly expenses with categories
- **Asset**: One-time purchases with VAT recovery potential
- **InvestmentProperty**: Land/property investments with contracts
- **InvestmentPlan**: Multi-investment planning and allocation

### Auth (src/lib/core/db/schema/auth.schema.ts)
- **Household**: Family grouping for shared resources
- **User**: better-auth user with `householdId` for family features

## Common Patterns

### Repository Pattern
Repositories return Drizzle result types directly:
```typescript
export const accountRepository = {
  async findAll(userId: string): Promise<Account[]> {
    return await db.select().from(accounts).where(eq(accounts.userId, userId));
  },
  async findById(id: number, userId: string): Promise<Account | null> {
    const result = await db.select().from(accounts)
      .where(and(eq(accounts.id, id), eq(accounts.userId, userId))).limit(1);
    return result[0] ?? null;
  },
};
```

### Service Layer
Services are thin wrappers that delegate to repositories:
```typescript
export const accountService = {
  findAll(userId: string) {
    return accountRepository.findAll(userId);
  },
};
```

### API Route HOCs
All API routes use `withAuth` and `withErrorHandling` higher-order functions:
```typescript
export const GET = withErrorHandling(
  withAuth(async (_request: NextRequest, _context: unknown, user: AuthenticatedUser) => {
    const accounts = await accountService.findAllWithShared(user.userId, user.householdId);
    return json(accounts);
  }),
);
```

### Error Handling
Throw typed errors that map to HTTP status codes:
```typescript
throw new NotFoundError("Account not found");     // 404
throw new InvalidRequestError("Invalid data");    // 400
throw new ConflictError("Already exists");        // 409
throw new ForbiddenError("Not allowed");          // 403
```

### Shared/Household Access
Many entities support household sharing:
```typescript
// Pattern for finding with shared access
async findAllWithShared(userId: string, householdId: string | null): Promise<Account[]> {
  if (householdId) {
    return db.select().from(accounts)
      .where(or(eq(accounts.userId, userId), eq(accounts.householdId, householdId)));
  }
  return db.select().from(accounts).where(eq(accounts.userId, userId));
}
```

### Zod Validation
Request bodies are validated with Zod schemas in `src/lib/schemas/`:
```typescript
// In API route (src/app/api/v1/receivables/route.ts)
import { CreateReceivableSchema } from "@/lib/schemas/receivables.schema";
import { badRequest, json, HTTP_STATUS } from "@/lib/core/http/responses";

export const POST = withErrorHandling(
  withAuth(async (request: NextRequest, _context: unknown, user: AuthenticatedUser) => {
    const body = await request.json();
    const parsed = CreateReceivableSchema.safeParse(body);

    if (!parsed.success) {
      return badRequest(parsed.error.message);  // Returns 400
    }

    const receivable = await receivableService.create({ ...parsed.data, userId: user.userId });
    return json(receivable, HTTP_STATUS.CREATED);
  }),
);
```

### TypeScript Types Re-export
Types are re-exported from schema to decouple pages from database layer:
```typescript
// src/lib/types/inbound.types.ts
export type {
  Receivable,
  NewReceivable,
  // ...other types
} from "@/lib/core/db/schema";

// Usage in pages/components: import from @/lib/types, not @/lib/core/db/schema
import type { Receivable } from "@/lib/types";
```

## Testing Patterns

### Test Structure
- **Unit tests**: `tests/unit/` - Mock external dependencies with `vi.mock()`
- **Integration tests**: `tests/integration/` - Real database, organized by domain
- **File naming**: `*.test.ts` co-located with test subject path

### Vitest Conventions
```typescript
import { beforeEach, describe, expect, it, vi } from "vitest";
import type { Account, Receivable } from "@/lib/core/db/schema";

// Mock repositories BEFORE importing services
vi.mock("@/lib/repositories/inbound/receivable.repository", () => ({
  receivableRepository: {
    findAll: vi.fn(),
    findById: vi.fn(),
  },
}));

// Import after mocks
import { receivableRepository } from "@/lib/repositories/inbound/receivable.repository";
import { receivableService } from "@/lib/services/receivable.service";

describe("receivableService", () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it("should return receivables", async () => {
    vi.mocked(receivableRepository.findAll).mockResolvedValue([]);
    const result = await receivableService.findAll("user-123");
    expect(receivableRepository.findAll).toHaveBeenCalledWith("user-123");
  });
});
```

### Running Tests
```bash
bun test              # Run all tests
bun test:unit         # Unit tests only
bun test:integration  # Integration tests only
```

## Anti-Patterns to Avoid

### DO NOT restructure pages
- Never move or reorganize files under `src/app/[locale]/`
- Page structure is intentional for i18n routing
- If a page has issues, fix them in place

### DO NOT touch telemetry
- `src/lib/telemetry/` handles error reporting
- `src/instrumentation.ts` is for OpenTelemetry setup
- These are correctly configured - do not modify

### DO NOT touch layout files
- `src/app/layout.tsx` and `src/app/[locale]/layout.tsx` are stable
- Layout changes affect the entire app

### DO NOT add global-error.tsx
- Error boundaries are handled at the appropriate level
- Adding global error handlers can mask real issues

### DO NOT over-engineer
- Repository methods should be simple query wrappers
- Services should be thin - no unnecessary abstraction
- Avoid creating utility functions for one-time operations

### Schema column order matters
- Drizzle generates INSERT columns in definition order
- IMPORTANT comment in schema files: "Column order MUST match database exactly"
- Run `bun db:validate-schema` to verify

### Avoid touching unrelated code
- Fix only what's requested
- Don't "improve" formatting, imports, or comments in unrelated files
- Don't add backwards-compatibility shims when you can just change the code
