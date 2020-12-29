-- comparison
SELECT '120'::lidan > '3c'::lidan;
SELECT '120'::lidan >= '3c'::lidan;
SELECT '120'::lidan < '3c'::lidan;
SELECT '120'::lidan <= '3c'::lidan;
SELECT '120'::lidan <> '3c'::lidan;
SELECT '120'::lidan = '3c'::lidan;

-- comparison equals
SELECT '120'::lidan > '120'::lidan;
SELECT '120'::lidan >= '120'::lidan;
SELECT '120'::lidan < '120'::lidan;
SELECT '120'::lidan <= '120'::lidan;
SELECT '120'::lidan <> '120'::lidan;
SELECT '120'::lidan = '120'::lidan;

-- comparison negation
SELECT NOT '120'::lidan > '120'::lidan;
SELECT NOT '120'::lidan >= '120'::lidan;
SELECT NOT '120'::lidan < '120'::lidan;
SELECT NOT '120'::lidan <= '120'::lidan;
SELECT NOT '120'::lidan <> '120'::lidan;
SELECT NOT '120'::lidan = '120'::lidan;

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