#!/bin/bash
set -euo pipefail
# ---- Credentials (use env vars in real projects) ----
XRAY_CLIENT_ID="your_client_id_here"
XRAY_CLIENT_SECRET="your_client_secret_here"
# ---- Config ----
XML_PATH="results/output.xml"
TEST_EXEC_KEY="QA-15"
TEST_ENVIRONMENTS="Local"

# ---- Authenticate ----
echo "➡️ Authenticating with Xray Cloud..."

AUTH_RESPONSE=$(curl -sS -X POST \
  -H "Content-Type: application/json" \
  -d "{
        \"client_id\": \"${XRAY_CLIENT_ID}\",
        \"client_secret\": \"${XRAY_CLIENT_SECRET}\"
      }" \
  https://xray.cloud.getxray.app/api/v2/authenticate)

TOKEN=$(echo "$AUTH_RESPONSE" | tr -d '"')
echo "✅ Authenticated"

# ---- Import into existing Test Execution ----
IMPORT_URL="https://xray.cloud.getxray.app/api/v2/import/execution/robot?testExecKey=${TEST_EXEC_KEY}&testEnvironments=${TEST_ENVIRONMENTS}"

echo "➡️ Importing results into Test Execution ${TEST_EXEC_KEY}..."

RESPONSE=$(curl -sS -X POST \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: text/xml" \
  --data-binary "@${XML_PATH}" \
  "$IMPORT_URL")

echo "✅ Import finished"
echo "➡️ Xray response:"
echo "$RESPONSE"
