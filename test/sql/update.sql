BEGIN;
DROP EXTENSION lidan;
CREATE EXTENSION lidan VERSION '0.0.1';
ALTER EXTENSION lidan UPDATE TO '0.0.2';
SELECT 'abcdefg'::biglidan;
