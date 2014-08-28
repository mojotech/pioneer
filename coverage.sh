#!/bin/bash
./mergelcov.sh ./coverage | ./node_modules/.bin/coveralls
