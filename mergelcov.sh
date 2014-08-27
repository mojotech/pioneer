#!/bin/bash
while read FILENAME; do
    LCOV_INPUT_FILES="$LCOV_INPUT_FILES -a \"$FILENAME\""
done < <( find $1 -name lcov.info )

eval lcov "${LCOV_INPUT_FILES}" -q
