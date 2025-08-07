# oracledb-docker-example

This is an example of how to set up a Dockerfile with `oracledb` in thick mode.

1. Pull the docker container from the oracle container registry:

```shell
docker pull container-registry.oracle.com/database/free:latest
```

2. Create the container:

```shell
docker container create -it --name oracle -p 1521:1521 -e ORACLE_PWD=welcome123 container-registry.oracle.com/database/free:latest
```

3. Start the container:

```shell
docker start oracle
```

4. In order to connect to oracle with python, download the basiclite [instantclient](https://www.oracle.com/database/technologies/instant-client/downloads.html) for your current platform and linux (if different). Follow the installation instructions at the bottom of the instantclient download page, then copy the `instantclient_*` folder from the Downloads folder to `lib`

5. Test the oracle connection in python:

```shell
python main.py
```

If the connection was successful, you should see the current date and time.
