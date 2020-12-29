-- simple input
SELECT '120'::biglidan;
SELECT '3c'::biglidan;
-- case insensitivity
SELECT '3C'::biglidan;
SELECT 'FoO'::biglidan;
-- invalid characters
SELECT 'foo bar'::biglidan;
SELECT 'abc$%2'::biglidan;
-- negative values
SELECT '-10'::biglidan;
-- to big values
SELECT 'abcdefghijklmn'::biglidan;

-- storage
BEGIN;
CREATE TABLE lidan_test(val biglidan);
INSERT INTO lidan_test VALUES ('123'), ('3c'), ('5A'), ('zZz');
SELECT * FROM lidan_test;
UPDATE lidan_test SET val = '567a' where val = '123';
SELECT * FROM lidan_test;
UPDATE lidan_test SET val = '-aa' where val = '3c';
SELECT * FROM lidan_test;
ROLLBACK;
