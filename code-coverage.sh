#!/bin/bash
# Since this is configured as a bash script, you run this file as such
# bash code-coverage.sh
set -e

echo "Run tests and get coverage"
flutter test --coverage --no-pub

# echo "Remove coverage from untestable areas"
flutter pub run remove_from_coverage -f coverage/lcov.info -r '((\/app\/infrastructure\/.*_api)|(.*_providers|.*_remote_data_provider|.g|.i18n|.gen|.p).dart$)'

if hash lcov-summary 2>/dev/null;
then
    echo "Build coverage report for VS Code"
    lcov-summary coverage/lcov.info 
else
    echo -e "!!ERROR!!\nYou need to have lcov-summary installed\n\nrun this command: npm i -g lcov-summary\n\n"
    exit 1
fi

# coverage report can be viewed in chrome /free_beta/coverage/html/index-sort-l.html
genhtml coverage/lcov.info -o coverage/html -q