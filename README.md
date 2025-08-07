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

5. Test the oracle connection in python, uncomment line 5 or 7 in `main.py`, then run:

```shell
python main.py
```

If the connection was successful, you should see the current date and time.

6. Test the oracle connection with docker, comment out line 5 and uncomment line 7 in `main.py`, then run:

```shell
docker build --no-cache -t oracle-thick-python .
```

```shell
docker run --rm oracle-thick-python
```

Error when running the container:

```shell
Traceback (most recent call last):
  File "/opt/oracle/main.py", line 8, in <module>
    oracledb.init_oracle_client()
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~^^
  File "src/oracledb/impl/thick/utils.pyx", line 527, in oracledb.thick_impl.init_oracle_client
  File "src/oracledb/impl/thick/utils.pyx", line 562, in oracledb.thick_impl.init_oracle_client
  File "src/oracledb/impl/thick/utils.pyx", line 474, in oracledb.thick_impl._raise_from_info
oracledb.exceptions.DatabaseError: DPI-1047: Cannot locate a 64-bit Oracle Client library: "/opt/oracle/instantclient/lib/libclntsh.so: cannot open shared object file: No such file or directory". See https://python-oracledb.readthedocs.io/en/latest/user_guide/initialization.html for help
Help: https://python-oracledb.readthedocs.io/en/latest/user_guide/troubleshooting.html#dpi-1047
```

To confirm the files exist, comment out the `CMD` line that runs the python script, rebuild the container, run the container, then run:

```shell
docker run -dit --name oracle-debug oracle-thick-python /bin/bash
docker exec -it oracle-debug /bin/bash
```

I checked these, and they all seem to be set up properly:

```shell
# Check environment variables
echo $LD_LIBRARY_PATH
echo $ORACLE_HOME

# Check files
ls /opt/oracle
ls /opt/oracle/instantclient
ls /opt/oracle/instantclient/lib

# Check that shared libraries exist
ls /opt/oracle/instantclient/lib/*.so*
```

But when I try to `ldd /opt/oracle/instantclient/lib/libclntsh.so`, it doesn't produce any dependencies and I think that it is supposed to.
