type "docker-compose" >/dev/null 2>/dev/null
if [ $? -eq 0 ]; then
    CMD="docker-compose"
else
    CMD="docker compose"
fi

${CMD} run -e LOCAL_USER_ID=$(id -u) cs-thesis-template bash

