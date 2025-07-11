# Cyber Science Thesis Template

This repository provides a comprehensive LaTeX document structure designed specifically for creating theses in the [Cyber Science postgraduate studies program](https://rekrutacja.polsl.pl/kierunek/spd-cybersc/) at Politechnika Śląska.

## About the Template

This template is tailored to meet the requirements of the Cyber Science postgraduate program, which focuses on cybersecurity management, risk management, incident response, and forensic IT applications. It helps streamline the thesis writing process by providing a modular and organized LaTeX setup.

## Repository Structure

The repository is organized as follows:

- *chapters/* # Contains individual thesis chapter files
- *resources/* # Contains images, diagrams, and other media assets
- *tools/* # Development tools and environment configurations
  - *docker/* # Dockerfile and related files for containerized build environment
  - *vscode/* # Example VSCode workspace and settings configurations
  - *devcontainer/* # Docker-based development container configurations
- *docker-compose.yml* # Docker Compose configuration for automated container setup
- *automate.sh* # Bash script to automate common tasks (build, run, etc.)

## Docker-based Build Environment

To ensure a consistent and reproducible build environment across different systems, this template uses Docker containers. This approach eliminates dependency and environment version conflicts.

- **Dockerfile Location:** `tools/docker/Dockerfile`
- **Purpose:** Contains all necessary software packages and dependencies for building and debugging the thesis document.

### Building the Docker Image

Run the following command to build the Docker image:

```shell
$: ./automate.sh build-docker
```

### Running the Docker Container

To start the container and attach your current shell to it, use:

```shell
$: ./automate.sh run-docker
```

Inside the container, you can build the thesis or perform other development tasks in a controlled environment.

## Building the Thesis PDF

**Important:** For reliable and repeatable builds, it is highly recommended to use the Docker environment.

To compile the thesis into a PDF document, execute:

```shell
$: ./automate.sh build-pdf
```

- **Output:**
  - Intermediate build files will be saved in the `_build` directory.
  - The final PDF file (`main.pdf`) will be placed in the `_deploy` directory.

## Additional Resources

- For detailed information about the [Cyber Science postgraduate program](https://rekrutacja.polsl.pl/kierunek/spd-cybersc/), including curriculum, admission criteria, and contact details, please visit the official site.

## Contributing

See `CONTRIBUTING.md`.

## License

See `LICENSE`.

---

Thank you for using this Cyber Science thesis template! We hope it makes your thesis writing process smooth and efficient.
