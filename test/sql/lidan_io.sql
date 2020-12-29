-- simple input
SELECT '120'::lidan;
SELECT '3c'::lidan;
-- case insensitivity
SELECT '3C'::lidan;
SELECT 'FoO'::lidan;
-- invalid characters
SELECT 'foo bar'::lidan;
SELECT 'abc$%2'::lidan;
-- negative values
SELECT '-10'::lidan;
-- to big values
SELECT 'abcdefghi'::lidan;

-- storage
BEGIN;
CREATE TABLE lidan_test(val lidan);
INSERT INTO lidan_test VALUES ('123'), ('3c'), ('5A'), ('zZz');
SELECT * FROM lidan_test;
UPDATE lidan_test SET val = '567a' where val = '123';
SELECT * FROM lidan_test;
UPDATE lidan_test SET val = '-aa' where val = '3c';
SELECT * FROM lidan_test;
ROLLBACK;
