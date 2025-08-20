# oracledb-docker-example

This is an example of how to set up a Dockerfile with `oracledb` in thick mode.

1. Set up the oracle database container:

```shell
docker pull container-registry.oracle.com/database/free:latest

docker network create -d bridge network-magic

# It can take a while before the container is fully running, upwards of 20 min.
docker run --network=network-magic --name oracle -e ORACLE_PWD=welcome123 -p 1521:1521 container-registry.oracle.com/database/free:latest

docker port oracle

docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' oracle
```

Make sure to update `HOST` and `PORT` in `main.py` with output from `docker inspect` and `docker port`.

2. Build and run app container:

```shell
docker build --no-cache -t oracle-app .
docker run --network=network-magic -it oracle-app
```
