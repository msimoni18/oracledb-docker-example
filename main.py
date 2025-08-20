import oracledb

HOST = "172.18.0.2"
PORT = 1521

oracledb.init_oracle_client()

pool = oracledb.create_pool(
    user="system",
    password="welcome123",
    dsn=f"{HOST}:{PORT}",
    min=1,
    max=5,
    increment=1,
)

try:
    with pool.acquire() as conn:
        with conn.cursor() as cursor:
            sql = """select sysdate from dual"""
            for r in cursor.execute(sql):
                print(r)
except Exception as err:
    print(err)
