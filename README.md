# SonarQube Docker Compose Setup

## Overview
This repository contains a Docker Compose configuration to run SonarQube, a popular code quality and security analysis tool. The setup scans the code stored in the `code` directory, which includes SQL files and other source code, to provide insights into code quality, vulnerabilities, and maintainability.

## Features
- Easy setup with Docker Compose
- Scans SQL code and other source files
- Integrates with CI/CD pipelines for continuous code quality checks
- Supports multiple database backends (default configuration)

## Directory Structure
- `docker-compose.yml`: Defines the services, including SonarQube and database
- `Dockerfile`: Customizations for the SonarQube container (if any)
- `code`: Directory containing SQL files and source code to be scanned
- `README.md`: This documentation file

## Setup Instructions
1. Clone this repository or copy the files to your environment.
2. Ensure Docker and Docker Compose are installed on your machine.

## Usage
1. Delete existing files in the `code` directory.
2. Add your code files, including SQL files, to the `code` directory.
3. Run the Docker Compose setup as shown above.
4. Run the following command to start SonarQube:
```bash
docker-compose up -d
```
5. Access the SonarQube dashboard at `http://localhost:9000` and log in using:
```
user: admin
password: admin
```
6. When prompted, make a new password.
7. Browse to `http://localhost:9000/account/security`
8. Enter a new token name in the `Name` box.
9. Select `Glboal Analysis Token` in the `Type` dropdown.
10. Adjust the `Expire in` dropdown as desired.
11. Click `Generate` button.
12. <b>Important</b> Copy the generated token -- this is the last time you will be able to see this in SonarQube!
12. Browse to `http://localhost:9000/projects/create?mode=manual` and create a new project and project key.
13. Save or keep track of the key for use in step 15, or paste it into your .token-file 
14. Then click `Next` in the lower right.
15. Run your first scan in a separate terminal as follows:
```
docker run --rm \
  -e SONAR_HOST_URL="http://host.docker.internal:9000" \
  -e SONAR_TOKEN="<your-sonarqube-token>" \
  -v ./code:/usr/src \
  sonarsource/sonar-scanner-cli \
  -Dsonar.projectKey=<your-project-key> \
  -Dsonar.sources=/usr/src \
  -Dsonar.host.url=http://host.docker.internal:9000 \
  -Dsonar.token=your-sonarqube-token
```
16. View your projects summary results in the SonarQube dashboard by clicking on your project at `http://localhost:9000/projects`.

## Local Token Convenience Management
While it is not generally advised to share tokens in a repo, .token-file support is provided as a convenience.
To use it:
1. Copy `.token-file.example` to `.token-file` as follows:
```
cp .token-file.example .token-file
```
2. Edit `.token-file` to replace your TOKEN and your PROJECT_KEY, making sure to use your project's key field from when you created it.
You can find your project key by browsing to `http://localhost:9000/projects`, clicking on your project, and then clicking on `Project Information`.
3. Then run your scan as follows:
```
source .token-file
docker run --rm \
  -e SONAR_HOST_URL="http://host.docker.internal:9000" \
  -e SONAR_TOKEN="$SONAR_TOKEN" \
  -v ./code:/usr/src \
  sonarsource/sonar-scanner-cli \
  -Dsonar.projectKey=$PROJECT_KEY \
  -Dsonar.sources=/usr/src \
  -Dsonar.host.url=http://host.docker.internal:9000 \
  -Dsonar.login=$SONAR_TOKEN
```

## Better Yet...

1. Copy `.token-file.example` to `.token-file` as follows:
```
cp .token-file.example .token-file
```
2. Edit `.token-file` to replace your TOKEN and your PROJECT_KEY, making sure to use your project's key field from when you created it.
You can find your project key by browsing to `http://localhost:9000/projects`, clicking on your project, and then clicking on `Project Information`.
3. The use `scan-code.sh` as follows:
```
./scan-code.sh
```

## Pointing to other Code directories than ./code
The default scanning directory is `./code` which contains example source code.
You can point to any other directory on your local machine, though, by setting  the `CODE_PATH` environment variable.
Here's one example:
```
CODE_PATH=~/new_project/src ./scan-code.sh
```

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Contact
For questions or contributions, please contact [your email].
