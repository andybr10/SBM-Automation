from bexio_tools import Client
from database_tools import SBMSALESDB
from pyodbc import DataError, ProgrammingError
import logging

sbmsdb_conn = SBMSALESDB.connect()
cursor = sbmsdb_conn.cursor()

tables = {
    'article': [],
    'article_type': [],
    'contact': [],
    'contact_branch': [],
    'contact_group': [],
    'contact_relation': [],
    'contact_type': [],
    'country': [],
    'currency': [],
    'payment_type': [],
    'salutation': [],
    'title': [],
    'unit': [],
    'user': [],
    'kb_delivery': [],
    'kb_invoice': [],
    'kb_order': [],
    'position_article': [],
    'position_custom': [],
    'position_discount': [],
    'position_article_relation': [],
    'position_custom_relation': [],
    'position_discount_relation': []
}

logger = logging.getLogger('Bexiopy')
logger.setLevel(logging.DEBUG)
logger.handlers = []

formatter = logging.Formatter(
    '%(asctime)s - %(levelname)s - %(name)s - %(message)s'
)
fh = logging.FileHandler('one.log')
fh.setFormatter(formatter)
fh.setLevel(logging.INFO)
logger.addHandler(fh)

sh = logging.StreamHandler()
sh.setFormatter(formatter)
sh.setLevel(logging.WARNING)
logger.addHandler(sh)

client = Client()

positions_dict = {
    'position_article': {},
    'position_custom': {},
    'position_discount': {}
}

for table_name in tables:
    if 'position_' not in table_name:
        tables[table_name] = client.list(table_name)
    if 'kb_' in table_name:
        logger.info(f'Getting position data for {table_name}')
        for record in tables[table_name]:
            rec_show = client.show(table_name, int(record["id"]))
            positions = []
            try:
                positions = rec_show['positions']
            except KeyError:
                pass
            if positions:
                for position in positions:
                    if position['type'] == Client.POS_TYPE_ARTICLE:
                        pos_table = positions_dict['position_article']
                    elif position['type'] == Client.POS_TYPE_CUSTOM:
                        pos_table = positions_dict['position_custom']
                    elif position['type'] == Client.POS_TYPE_DISCOUNT:
                        pos_table = positions_dict['position_discount']
                    else:
                        pos_table = None
                    if pos_table is not None:
                        if position['id'] not in pos_table.keys():
                            pos_table[position['id']] = {
                                'kb_order_id': None,
                                'kb_invoice_id': None,
                                'kb_delivery_id': None,
                                'data': position
                            }
                        pos_table[position['id']][f'{table_name}_id'] = record['id']

for position_type, positions in positions_dict.items():
    for position_id, position in positions.items():
        tables[f'{position_type}'].append(position.pop('data'))
        position[f'{position_type}_id'] = position_id
        tables[f'{position_type}_relation'].append(position)

for table_name, data in tables.items():
    logger.info(f'Loading table {table_name}')
    cursor.execute(f"TRUNCATE TABLE [bexio].[{table_name}]")
    sbmsdb_conn.commit()
    info_schema_columns = cursor.execute(
        f"SELECT * FROM [SbMSalesDB].INFORMATION_SCHEMA.COLUMNS " +
        f"WHERE TABLE_NAME = N'{table_name}' " +
        f"AND TABLE_SCHEMA = N'bexio';"
    ).fetchall()
    column_names = [c[3] for c in info_schema_columns]
    columns = ', '.join(column_names)
    placeholders = ', '.join(['?' for v in column_names])
    for row in data:
        values_list = []
        for column_name in column_names:
            if column_name in row.keys():
                val = str(row[column_name])
                if val == 'None':
                    val = None
                values_list.append(val)
            else:
                values_list.append(None)
        try:
            cursor.execute(f"INSERT INTO [bexio].[{table_name}] ({columns}) VALUES ({placeholders})", values_list)
        except DataError as ex:
            print(ex)
            print(table_name)
            print(columns)
            for i, value in enumerate(values_list):
                print(column_names[i], '|', value)
            exit()
        except ProgrammingError as ex:
            print(ex)
            print(table_name)
            print(columns)
            for i, value in enumerate(values_list):
                print(column_names[i], '|', value)
            exit()
    sbmsdb_conn.commit()

logger.info('Finished')
