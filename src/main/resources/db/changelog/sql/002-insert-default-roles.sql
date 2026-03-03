--liquibase formatted sql

--changeset tejraj:002-insert-default-roles
INSERT INTO roles (id, name)
SELECT 1, 'ROLE_USER'
WHERE NOT EXISTS (SELECT 1 FROM roles WHERE id = 1);

INSERT INTO roles (id, name)
SELECT 2, 'ROLE_ADMIN'
WHERE NOT EXISTS (SELECT 1 FROM roles WHERE id = 2);

--rollback
DELETE FROM roles WHERE id IN (1,2);