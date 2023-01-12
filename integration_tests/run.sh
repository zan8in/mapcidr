#!/bin/bash

echo "::group::Build mapcidr"
cd ../cmd/mapcidr
go build
mv mapcidr ../../integration_tests/mapcidr
echo "::endgroup::"
echo "::group::Build mapcidr integration-test"
cd ../integration-test
go build
cp -rf goldenfiles ../../integration_tests/
mv integration-test ../../integration_tests/integration-test
cd ../../integration_tests
echo "::endgroup::"
./integration-test
if [ $? -eq 0 ]
then
  rm integration-test mapcidr 2>/dev/null
  exit 0
else
  rm integration-test mapcidr 2>/dev/null
  exit 1
fi
