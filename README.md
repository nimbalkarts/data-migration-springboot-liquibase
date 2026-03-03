# data-migration-springboot-liquibase

Spring Boot 3, Gradle build, Liquibase changelogs written in SQL format, target database PostgreSQL





Spring Boot will pick up spring.liquibase.change-log and run Liquibase on startup unless spring.liquibase.enabled is set to false. Use contexts to limit changesets per environment.



SQL formatted changelogs — layout

Where to place: src/main/resources/db/changelog/

Master file: db.changelog-master.sql can include other SQL files or contain multiple changesets inline.



SQL formatted changelog rules

\- Start each file (or the first file) with --liquibase formatted sql.

\- Each changeset begins with --changeset author:id.

\- Optionally include --rollback immediately after the changeset.



What contexts are?

changesets run in a given execution. Use contexts to target changes to specific environments, features, or deployment phases. Context filters are logical expressions and are evaluated at runtime to include or exclude changesets





Running migrations: dev, CI, and production

Local development

\- Let Spring Boot auto‑run Liquibase on app startup (fast feedback). For preview, use the Gradle plugin or Liquibase CLI to generate SQL without applying.



Preview SQL (recommended for PRs)

\# Liquibase CLI

liquibase --changeLogFile=src/main/resources/db/changelog/db.changelog-master.sql updateSQL



\# Gradle plugin (task name may vary)

./gradlew updateSql

Review generated SQL in code review to catch unintended DDL/DML.



CI / Production

\- Preferred pattern: run Liquibase as a controlled CI/CD job that applies migrations to the target DB before deploying application instances. This avoids multiple app instances racing to run migrations and reduces startup locking issues. Use contexts or labels to gate environment‑specific changes





Safe data migration patterns and best practices

\- Small, focused changesets: one logical change per changeset for traceability.

\- Idempotency: write SQL so re‑running is safe (IF NOT EXISTS, WHERE NOT EXISTS).

\- Staged deploys for destructive changes: add new column → backfill in separate changeset → switch reads/writes → drop old column later.

\- Backups and snapshots: always snapshot or export data before irreversible transforms.

\- Batch large updates: update in chunks (by primary key ranges) to avoid long locks.

\- Rollback planning: include --rollback when feasible; if not possible, document and ensure backups.

\- Never edit applied changesets: if a changeset has been applied in any environment, create a new changeset to change behavior.











