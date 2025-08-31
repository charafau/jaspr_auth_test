BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "todo" (
    "id" bigserial PRIMARY KEY,
    "text" text NOT NULL,
    "done" boolean NOT NULL DEFAULT true,
    "userId" bigint
);


--
-- MIGRATION VERSION FOR jaspr_auth_test
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('jaspr_auth_test', '20250830155806585', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250830155806585', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240520102713718', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240520102713718', "timestamp" = now();


COMMIT;
