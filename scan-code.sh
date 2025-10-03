#!/bin/sh
source .token-file
docker run --rm \
  -e SONAR_HOST_URL="http://host.docker.internal:9000" \
  -e SONAR_TOKEN="$TOKEN" \
  -v ./code:/usr/src \
  sonarsource/sonar-scanner-cli \
  -Dsonar.projectKey=$PROJECT_KEY \
  -Dsonar.sources=/usr/src \
  -Dsonar.host.url=http://host.docker.internal:9000 \
  -Dsonar.login=$TOKEN