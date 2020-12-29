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

CREATE TYPE lidan (
  INPUT          = lidan_in,
  OUTPUT         = lidan_out,
  LIKE           = integer
);

CREATE FUNCTION lidan_eq(lidan, lidan)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'int4eq';

CREATE FUNCTION lidan_ne(lidan, lidan)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'int4ne';

CREATE FUNCTION lidan_lt(lidan, lidan)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'int4lt';

CREATE FUNCTION lidan_le(lidan, lidan)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'int4le';

CREATE FUNCTION lidan_gt(lidan, lidan)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'int4gt';

CREATE FUNCTION lidan_ge(lidan, lidan)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'int4ge';

CREATE FUNCTION lidan_cmp(lidan, lidan)
RETURNS integer LANGUAGE internal IMMUTABLE AS 'btint4cmp';

CREATE FUNCTION hash_lidan(lidan)
RETURNS integer LANGUAGE internal IMMUTABLE AS 'hashint4';

CREATE OPERATOR = (
  LEFTARG = lidan,
  RIGHTARG = lidan,
  PROCEDURE = lidan_eq,
  COMMUTATOR = '=',
  NEGATOR = '<>',
  RESTRICT = eqsel,
  JOIN = eqjoinsel,
  HASHES, MERGES
);

CREATE OPERATOR <> (
  LEFTARG = lidan,
  RIGHTARG = lidan,
  PROCEDURE = lidan_ne,
  COMMUTATOR = '<>',
  NEGATOR = '=',
  RESTRICT = neqsel,
  JOIN = neqjoinsel
);

CREATE OPERATOR < (
  LEFTARG = lidan,
  RIGHTARG = lidan,
  PROCEDURE = lidan_lt,
  COMMUTATOR = > ,
  NEGATOR = >= ,
  RESTRICT = scalarltsel,
  JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
  LEFTARG = lidan,
  RIGHTARG = lidan,
  PROCEDURE = lidan_le,
  COMMUTATOR = >= ,
  NEGATOR = > ,
  RESTRICT = scalarltsel,
  JOIN = scalarltjoinsel
);

CREATE OPERATOR > (
  LEFTARG = lidan,
  RIGHTARG = lidan,
  PROCEDURE = lidan_gt,
  COMMUTATOR = < ,
  NEGATOR = <= ,
  RESTRICT = scalargtsel,
  JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
  LEFTARG = lidan,
  RIGHTARG = lidan,
  PROCEDURE = lidan_ge,
  COMMUTATOR = <= ,
  NEGATOR = < ,
  RESTRICT = scalargtsel,
  JOIN = scalargtjoinsel
);

CREATE OPERATOR CLASS btree_lidan_ops
DEFAULT FOR TYPE lidan USING btree
AS
        OPERATOR        1       <  ,
        OPERATOR        2       <= ,
        OPERATOR        3       =  ,
        OPERATOR        4       >= ,
        OPERATOR        5       >  ,
        FUNCTION        1       lidan_cmp(lidan, lidan);

CREATE OPERATOR CLASS hash_lidan_ops
    DEFAULT FOR TYPE lidan USING hash AS
        OPERATOR        1       = ,
        FUNCTION        1       hash_lidan(lidan);

CREATE CAST (integer as lidan) WITHOUT FUNCTION AS ASSIGNMENT;
CREATE CAST (lidan as integer) WITHOUT FUNCTION AS ASSIGNMENT;

-- biglidan

CREATE FUNCTION biglidan_in(cstring)
RETURNS biglidan
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION biglidan_out(biglidan)
RETURNS cstring
AS 'MODULE_PATHNAME'
LANGUAGE C IMMUTABLE STRICT;

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
