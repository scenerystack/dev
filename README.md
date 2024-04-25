
# PhET Simulations Development Environment

   This repository contains Docker configurations for setting up a development environment for PhET Interactive Simulations.

## Prerequisites

- Docker installed on your machine. [Get Docker](https://docs.docker.com/get-docker/)
- Docker Compose installed (usually included with Docker Desktop). [Docker Compose](https://docs.docker.com/compose/install/)

## Setup Instructions

   1. Clone this repository:

      ```
      git clone [URL to this repository]
      cd [repository name]
      ```

   2. Build the Docker environment:

      ```
      docker-compose build
      ```

   3. Start the development environment:

      ```
      docker-compose up
      ```

## Using the Development Environment

- The simulations will be available on `http://localhost:8080/` in your browser.
- Any changes you make to the source files will automatically refresh the simulations.

## Additional Commands

- To stop the Docker environment, press `CTRL+C` in your terminal.
- To remove the Docker containers:

     ```
     docker-compose down
     ```

## Troubleshooting

- Ensure Docker is running on your system before starting the services.
- Check Docker and Docker Compose are properly installed by running `docker -v` and `docker-compose -v`.
