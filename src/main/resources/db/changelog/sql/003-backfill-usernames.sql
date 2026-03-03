--liquibase formatted sql

--changeset tejraj:003-backfill-usernames
-- Backfill username from email for rows missing username
UPDATE users
SET username = lower(split_part(email, '@', 1))
WHERE (username IS NULL OR username = '')
  AND email IS NOT NULL
  AND email <> '';

--rollback
-- No reliable automatic rollback; rely on backup or snapshot