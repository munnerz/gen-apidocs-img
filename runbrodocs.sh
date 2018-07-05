#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

INCLUDES_DIR="${INCLUDES_DIR:-/source}"
OUTPUT_DIR="${OUTPUT_DIR:-/build}"
MANIFEST_PATH="${MANIFEST_PATH:-/manifest/manifest.json}"

cd "${BRODOCS}"
cp "${MANIFEST_PATH}" ./manifest.json
cp "${INCLUDES_DIR}"/* ./documents/
node "${BRODOCS}/brodoc.js"
cp -r ./* "${OUTPUT_DIR}/"
