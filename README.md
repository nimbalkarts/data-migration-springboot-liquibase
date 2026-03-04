# \# Data Migration with Spring Boot \& Liquibase

# 

 This project demonstrates database migrations using **Spring Boot 3**, **Gradle**, and **Liquibase** with SQL‑formatted changelogs. Target database: **PostgreSQL**.


---

## Liquibase Integration

- Spring Boot automatically runs Liquibase on startup using `spring.liquibase.change-log`.  

- Disable with `spring.liquibase.enabled=false`.  

- Use \*\*contexts\*\* to control which changesets run in different environments.

---


## SQL Changelog Layout

- Place changelogs in: `src/main/resources/db/changelog/`  

 - Master file: `db.changelog-master.sql`  

 - Can include other SQL files  

 - Or contain multiple inline changesets
 

### Rules


\- Start each file with:  

```sql

 --liquibase formatted sql

```

\- Each changeset begins with:  

```sql
 --changeset author:id
 ```

\- Optionally add rollback logic with:  

```sql
 --rollback <SQL>
```

---

## Contexts 

\- Contexts filter which changesets run in a given execution.  

\- Useful for environment‑specific, feature‑specific, or phased deployments.  

\- Filters are logical expressions evaluated at runtime.


---


## Running Migrations


### Local Development

\- Let Spring Boot auto‑run Liquibase on startup for fast feedback.  

\- For preview, generate SQL without applying changes:


 ### Liquibase CLI
  
```bash
 liquibase --changeLogFile=src/main/resources/db/changelog/db.changelog-master.sql updateSQL
``` 

 ### Gradle plugin (task name may vary)
```bash
 ./gradlew updateSql
``` 
> Recommended for PRs: review generated SQL to catch unintended DDL/DML.


### CI / Production

- Run Liquibase as a \*\*controlled CI/CD job\*\* before deploying application instances.  

- Prevents race conditions and startup locking issues.  

- Use contexts/labels to gate environment‑specific changes.

---
 

## Best Practices for Safe Data Migration


- **Small, focused changesets** → one logical change per changeset.  
 
 - **Idempotency** → use `IF NOT EXISTS`, `WHERE NOT EXISTS`.  

- **Staged deploys** for destructive changes:  

- Add new column → backfill → switch reads/writes → drop old column later.  

- **Backups \& snapshots** before irreversible transforms.  

- **Batch updates** → process in chunks to avoid long locks.  

- **Rollback planning** → include `--rollback` when feasible; otherwise document and ensure backups.  

- **Never edit applied changesets** → always create a new changeset for modifications.

---




