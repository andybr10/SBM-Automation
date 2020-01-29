import pyodbc
from .settings import BASE_CONN_STRING, SBMSALESDB_INFO
import logging

db_conn_logger = logging.getLogger('SBMSALESDB Connection')
fh = logging.FileHandler('one.log')
formatter = logging.Formatter(
    '%(asctime)s - %(levelname)s - %(name)s - %(message)s'
)
fh.setFormatter(formatter)
db_conn_logger.addHandler(fh)
db_conn_logger.setLevel(logging.INFO)


class SBMSALESDB:

    _connection = None

    @classmethod
    def connect(cls):
        try:
            conn_string = BASE_CONN_STRING.format(**SBMSALESDB_INFO)
            cls._connection = pyodbc.connect(conn_string)
            db_conn_logger.info(f'Successful connection to: {SBMSALESDB_INFO["server"]}\\{SBMSALESDB_INFO["database"]}')
            return cls._connection
        except Exception as ex:
            db_conn_logger.warning(f'Failed connection to: {SBMSALESDB_INFO["server"]}\\{SBMSALESDB_INFO["database"]}')
            db_conn_logger.error(ex)
            raise ex
