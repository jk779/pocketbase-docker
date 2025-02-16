# pocketbase-docker

This image contains both arm64 and x86_64 executables for [Pocketbase](https://pocketbase.io/). The entrypoint decides which one is selected.

## Running with `docker`

```shell
docker run -it --rm -p 8080:8080 -v pb_data:/pb/pb_data ghcr.io/jk779/pocketbase-docker:latest
```

## Running with `docker compose`

Create a compose.yml with the follwoing content and then `docker compose up [-d]`.

```yml
# compose.yml

services:
  pocketbase-docker:
    image: ghcr.io/jk779/pocketbase-docker:latest
    ports:
      - "8080:8080"
    volumes:
      - pb_data:/pb/pb_data
      # ./pb_migrations /pb/pb_migrations # if you want to add migrations
      # ./pb_hooks /pb/pb_hooks # if you want to add hooks
    restart: unless-stopped

volumes:
  pb_data:
```

## Building the image yourself

Please make sure to provide the version of Pocketbase to be included via `--build_arg`:

```shell
docker build --build-arg PB_VERSION=0.25.4 .
```