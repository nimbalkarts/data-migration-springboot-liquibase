--liquibase formatted sql

--changeset tejraj:004-seed-dev-data context:dev
INSERT INTO roles (id, name)
SELECT 3, 'ROLE_DEV'
WHERE NOT EXISTS (SELECT 1 FROM roles WHERE id = 3);

--rollback
DELETE FROM roles WHERE id = 3;