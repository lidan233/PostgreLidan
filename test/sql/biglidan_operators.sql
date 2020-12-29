-- comparison
SELECT '120'::biglidan > '3c'::biglidan;
SELECT '120'::biglidan >= '3c'::biglidan;
SELECT '120'::biglidan < '3c'::biglidan;
SELECT '120'::biglidan <= '3c'::biglidan;
SELECT '120'::biglidan <> '3c'::biglidan;
SELECT '120'::biglidan = '3c'::biglidan;

-- comparison equals
SELECT '120'::biglidan > '120'::biglidan;
SELECT '120'::biglidan >= '120'::biglidan;
SELECT '120'::biglidan < '120'::biglidan;
SELECT '120'::biglidan <= '120'::biglidan;
SELECT '120'::biglidan <> '120'::biglidan;
SELECT '120'::biglidan = '120'::biglidan;

-- comparison negation
SELECT NOT '120'::biglidan > '120'::biglidan;
SELECT NOT '120'::biglidan >= '120'::biglidan;
SELECT NOT '120'::biglidan < '120'::biglidan;
SELECT NOT '120'::biglidan <= '120'::biglidan;
SELECT NOT '120'::biglidan <> '120'::biglidan;
SELECT NOT '120'::biglidan = '120'::biglidan;

--commutator and negator
BEGIN;
CREATE TABLE lidan_test AS
SELECT i::lidan as val FROM generate_series(1,10000) i;
CREATE INDEX ON lidan_test(val);
ANALYZE;
SET enable_seqscan TO off;
EXPLAIN (COSTS OFF) SELECT * FROM lidan_test where NOT val < 'c1';
EXPLAIN (COSTS OFF) SELECT * FROM lidan_test where NOT 'c1' > val;
EXPLAIN (COSTS OFF) SELECT * FROM lidan_test where 'c1' > val;
-- hash aggregate
SET enable_seqscan TO on;
EXPLAIN (COSTS OFF) SELECT val, COUNT(*) FROM lidan_test GROUP BY 1;
ROLLBACK;