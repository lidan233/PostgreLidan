#include "lidan.h"

PG_FUNCTION_INFO_V1(biglidan_in);
Datum
biglidan_in(PG_FUNCTION_ARGS)
{
    long result;
    char *bad;
    char *str = PG_GETARG_CSTRING(0);
    result = strtol(str, &bad, 36);

    if (result == LONG_MIN || result == LONG_MAX)
        LIDANOUTOFRANGE_ERROR(str, "biglidan");

    if (bad[0] != '\0' || strlen(str)==0)
        LIDANSYNTAX_ERROR(str,"biglidan");

    PG_RETURN_INT64((int64)result);
}

PG_FUNCTION_INFO_V1(biglidan_out);
Datum
biglidan_out(PG_FUNCTION_ARGS)
{
    int64 arg = PG_GETARG_INT64(0);
    bool  neg = false;
    if (arg <= LONG_MIN || arg >= LONG_MAX)
        ereport(ERROR,
        (
         errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
         errmsg("biglidan out of range")
        ));

    if (arg < 0)
    {
        arg = -arg;
        neg = true;
    }

    /* max 13 char + '\0' + sign */
    char buffer[15];
    unsigned int offset = sizeof(buffer);
    buffer[--offset] = '\0';

    do {
        buffer[--offset] = lidan_digits[arg % 36];
    } while (arg /= 36);

    if (neg)
        buffer[--offset] = '-';

    PG_RETURN_CSTRING(pstrdup(&buffer[offset]));
}