--liquibase formatted sql

--changeset tejraj:001-create-users
CREATE TABLE IF NOT EXISTS users (
  id BIGSERIAL PRIMARY KEY,
  username VARCHAR(100),
  email VARCHAR(255)
);
--rollback DROP TABLE users;

--changeset tejraj:001-create-roles
CREATE TABLE IF NOT EXISTS roles (
  id BIGINT PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);
--rollback DROP TABLE roles;