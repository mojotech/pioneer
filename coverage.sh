#!/bin/bash
./node_modules/.bin/istanbul cover ./node_modules/.bin/_mocha test/unit/**.coffee --dir coverage/unit &&
./node_modules/.bin/istanbul cover ./bin/pioneer --dir coverage/integration

./mergelcov.sh ./coverage | ./node_modules/.bin/coveralls
