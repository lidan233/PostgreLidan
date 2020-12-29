-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION lidan" to load this file. \quit

CREATE FUNCTION lidan_in(cstring)
    RETURNS lidan
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/lidan', 'lidan_in';


CREATE FUNCTION lidan_out(lidan)
RETURNS cstring
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/lidan', 'lidan_out';


CREATE TYPE biglidan (
  INPUT          = biglidan_in,
  OUTPUT         = biglidan_out,
  LIKE           = bigint
);

CREATE FUNCTION biglidan_eq(biglidan, biglidan)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'int8eq';

CREATE FUNCTION biglidan_ne(biglidan, biglidan)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'int8ne';

CREATE FUNCTION biglidan_lt(biglidan, biglidan)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'int8lt';

CREATE FUNCTION biglidan_le(biglidan, biglidan)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'int8le';

CREATE FUNCTION biglidan_gt(biglidan, biglidan)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'int8gt';

CREATE FUNCTION biglidan_ge(biglidan, biglidan)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'int8ge';

CREATE FUNCTION biglidan_cmp(biglidan, biglidan)
RETURNS integer LANGUAGE internal IMMUTABLE AS 'btint8cmp';

CREATE FUNCTION hash_biglidan(biglidan)
RETURNS integer LANGUAGE internal IMMUTABLE AS 'hashint8';

CREATE OPERATOR = (
  LEFTARG = biglidan,
  RIGHTARG = biglidan,
  PROCEDURE = biglidan_eq,
  COMMUTATOR = '=',
  NEGATOR = '<>',
  RESTRICT = eqsel,
  JOIN = eqjoinsel,
  HASHES, MERGES
);

CREATE OPERATOR <> (
  LEFTARG = biglidan,
  RIGHTARG = biglidan,
  PROCEDURE = biglidan_ne,
  COMMUTATOR = '<>',
  NEGATOR = '=',
  RESTRICT = neqsel,
  JOIN = neqjoinsel
);

CREATE OPERATOR < (
  LEFTARG = biglidan,
  RIGHTARG = biglidan,
  PROCEDURE = biglidan_lt,
  COMMUTATOR = > ,
  NEGATOR = >= ,
  RESTRICT = scalarltsel,
  JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
  LEFTARG = biglidan,
  RIGHTARG = biglidan,
  PROCEDURE = biglidan_le,
  COMMUTATOR = >= ,
  NEGATOR = > ,
  RESTRICT = scalarltsel,
  JOIN = scalarltjoinsel
);

CREATE OPERATOR > (
  LEFTARG = biglidan,
  RIGHTARG = biglidan,
  PROCEDURE = biglidan_gt,
  COMMUTATOR = < ,
  NEGATOR = <= ,
  RESTRICT = scalargtsel,
  JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
  LEFTARG = biglidan,
  RIGHTARG = biglidan,
  PROCEDURE = biglidan_ge,
  COMMUTATOR = '<=' ,
  NEGATOR = '<' ,
  RESTRICT = scalargtsel,
  JOIN = scalargtjoinsel
);

CREATE OPERATOR CLASS btree_biglidan_ops
DEFAULT FOR TYPE biglidan USING btree
AS
        OPERATOR        1       <  ,
        OPERATOR        2       <= ,
        OPERATOR        3       =  ,
        OPERATOR        4       >= ,
        OPERATOR        5       >  ,
        FUNCTION        1       biglidan_cmp(biglidan, biglidan);

CREATE OPERATOR CLASS hash_biglidan_ops
DEFAULT FOR TYPE biglidan USING hash AS
        OPERATOR        1       = ,
        FUNCTION        1       hash_biglidan(biglidan);

CREATE CAST (bigint as biglidan) WITHOUT FUNCTION AS ASSIGNMENT;
CREATE CAST (biglidan as bigint) WITHOUT FUNCTION AS ASSIGNMENT;
