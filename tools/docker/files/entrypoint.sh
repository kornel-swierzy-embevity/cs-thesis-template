#!/bin/bash
set -e

# --- System ---

# If "-e uid={custom/local user id}" flag is not set for "docker run"
# command, use 9001 as default
DOCKER_UID=${LOCAL_USER_ID:-9001}
DOCKER_USERNAME="docker"

# Notify user about the UID selected
echo "Welcome in Docker! Your user UID: $DOCKER_UID"
# Create user called "docker" with selected UID
if id ${DOCKER_USERNAME} &>/dev/null; then
    echo "Container is already configured"
else
    echo "Configuring container: creating non-root user..."

    useradd --shell /bin/bash -u $DOCKER_UID -o -c "" -m ${DOCKER_USERNAME}
    passwd -d docker

    # Set "HOME" ENV variable for user's home directory
    export HOME=/home/${DOCKER_USERNAME}

    # Mark all git repositories as safe (it includes Zephyr and so on).
    ${RUN_AS_USER} git config --global --add safe.directory "*"

    # --- VS Code remote development ---

    echo "Creating VS Code directories..."
    mkdir -p /home/${DOCKER_USERNAME}/.vscode-server/extensions          \
            /home/${DOCKER_USERNAME}/.vscode-server-insiders/extensions  \
        && chown -R ${DOCKER_USERNAME} /home/${DOCKER_USERNAME}
fi

# Execute process
echo "Docker ready, happy development!"
exec gosu ${DOCKER_USERNAME} "$@"
