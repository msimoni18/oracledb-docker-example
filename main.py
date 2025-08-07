from pathlib import Path
import oracledb

# Uncomment to used downloaded instantclient folder (windows/mac)
# oracledb.init_oracle_client(lib_dir=str(Path('lib/instantclient_23_3').resolve()))

# Uncomment for linux (lib_dir not needed according to oracledb docs)
oracledb.init_oracle_client()

pool = oracledb.create_pool(
    user='system', password='welcome123', dsn='0.0.0.0:1521', min=1, max=5, increment=1
)

try:
    with pool.acquire() as conn:
        with conn.cursor() as cursor:
            sql = """select sysdate from dual"""
            for r in cursor.execute(sql):
                print(r)
except Exception as err:
    print(err)