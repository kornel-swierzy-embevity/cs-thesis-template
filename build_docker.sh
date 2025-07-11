type "docker-compose" >/dev/null 2>/dev/null
if [ $? -eq 0 ]; then
    docker-compose build cs-thesis-template
else
    docker compose build cs-thesis-template
fi

