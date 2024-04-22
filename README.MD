
- build image
    ```bash
    docker buildx build -f Dockerfile . --platform linux/amd64,linux/arm64 -t yowko/redisgroupmemoryusage --push 
    ```

- docker compose up

    ```
    ip=$(ipconfig getifaddr en0) docker-compose up -d
    ```

- analysis

    ```
    docker run --rm -e endpoint="192.168.80.3:7002" yowko/redisgroupmemoryusage
    ```