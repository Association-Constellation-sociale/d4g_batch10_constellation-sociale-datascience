# Data4Good collaboration repository


## Setup (for unix environments)
This setup will help you setup a database with constellation-sociale most recent dataset in a postgresql database.

### Prerequisite
- You must have docker and docker-compose installed.
- Login to the github docker regsitry, you must create a personal access token, the process is detailed [here](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-with-a-personal-access-token-classic). You can then login with: `docker login ghcr.io -u USERNAME --password-stdin` and provide the access token.

## Setup the postgresql database

- Launch the postgresql container and seed the database:
```sh
cd docker-env
make launch-pg
```

- You can now launch psql client with this command (psql must be installed):
```sh
make psql
```
- The database is accessible with any client at the following uri: `postgres://postgres:postgres@localhost:5432/constellation-sociale`

Enjoy !

## Setup (windows)
### Prerequisite
- DockerDesktop must be installed.
- Login to the github docker regsitry, you must create a personal access token, the process is detailed [here](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-with-a-personal-access-token-classic). You can then login with: `docker login ghcr.io -u USERNAME --password-stdin` and provide the access token.

## Setup the postgresql database
- Run `docker-compose up -d` in the `docker-env` folder.
- The database is accessible at the following url: `postgres://postgres:postgres@localhost:5432/constellation-sociale`


## Other setup options
- The dataset is also available as an sql dump and csv files (this may not be up to date) in the `dataset` folder.


## Collaboration guidelines

- The `main` branch is protected, in order to merge please create a Pull Request.
- We use a kanban project board to track issues. Please reference the related issue in your Pull Request.
- It is better if we can follow the [conventional commit style](https://www.conventionalcommits.org/en/v1.0.0/#summary).
