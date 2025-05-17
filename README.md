# Genesys Archy for Docker

This repository provides a Docker image for [Archy](https://developer.genesys.cloud/devapps/archy/), a Genesys Cloud CX tool used for managing Architect flows. Archy enables automation and deployment of Architect flows using a command-line interface. 

## Features
- Run Archy without needing to install it on your local machine.
- Use specific Archy versions by tagging them in your Docker run command.
- Simplifies integration with CI/CD pipelines.

## Prerequisites
Ensure you have [Docker](https://docs.docker.com/get-docker/) installed on your system.

## Environment Variables
The following environment variables must be set for authentication and configuration:

- `ARCHY_AUTH_TOKEN`: Used for authentication, required if `ARCHY_CLIENT_ID` and `ARCHY_CLIENT_SECRET` are not provided.
- `ARCHY_CLIENT_ID`: Required when using client-based authentication.
- `ARCHY_CLIENT_SECRET`: Required when using client-based authentication.
- `ARCHY_HOME_DIR` (default: `/opt/archy/archyHome`): The home directory for Archy.
- `ARCHY_REGION` (default: `mypurecloud.com`): The Genesys region where Archy operates.
- `ARCHY_DEBUG` (default: `false`): Enables debug mode if set to `true`.

## Usage

Run Archy using Docker by specifying the command explicitly:
```bash
docker run --rm -e ARCHY_AUTH_TOKEN="your-auth-token" danzigergeist/archy archy --help
```

To use a specific version:
```bash
docker run --rm -e ARCHY_AUTH_TOKEN="your-auth-token" danzigergeist/archy:2.33.1 archy --help
```

> **Note**: This Docker image is built for the Linux platform by default. If you are using an M-based Mac (Apple Silicon), you need to specify the `linux/amd64` platform when running the image. For example:

```bash
docker run --platform linux/amd64 --rm -e ARCHY_AUTH_TOKEN="your-auth-token" danzigergeist/archy:2.33.1 archy --help

## License

This project is licensed under the MIT License.
