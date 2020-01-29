from database_tools import SBMSALESDB
import logging
from helpers.data_formatting import pretty

logger = logging.getLogger('Landing To Core')
logger.setLevel(logging.INFO)
formatter = logging.Formatter(
    '%(asctime)s - %(levelname)s - %(name)s - %(message)s'
)
# sh = logging.StreamHandler()
# sh.setFormatter(formatter)
# sh.setLevel(logging.INFO)
# logger.addHandler(sh)
fh = logging.FileHandler('one.log')
fh.setFormatter(formatter)
fh.setLevel(logging.INFO)
logger.addHandler(fh)

sbmsdb_conn = SBMSALESDB.connect()
cursor = sbmsdb_conn.cursor()

logger.info('Executing stored procedure sbmsr.LandingToCore...')
try:
    cursor.execute("EXECUTE sbmsr.LandingToCore;")
except Exception as ex:
    logger.error(ex)
else:
    sbmsdb_conn.commit()
    logger.info("Stored procedure executed successfully.")

# Now we will try to extract product codes from the [text] field
# in [position_article] and [position_custom] tables
# and update the field [product_code_from_text] with the result
logger.info('Updating [product_code_from_text] '
            'fields in tables [position_article] '
            'and [position_custom]...')
cursor.execute('SELECT [intern_code] FROM [sbmsr].[article];')
product_codes = []
for row in cursor.fetchall():
    product_codes.append(row[0])
sbmsdb_conn.commit()
product_codes = sorted(list(set(product_codes)), reverse=True)


for table in ['[sbmsr].[position_article]', '[sbmsr].[position_custom]']:
    updates = []
    cursor.execute(f'SELECT [id], [text] FROM {table};')
    positions = cursor.fetchall()
    sbmsdb_conn.commit()
    for position in positions:
        extracted_codes = []
        pos_id = position[0]
        pos_text = position[1]
        for prod_code in product_codes:
            if prod_code in pos_text:
                extracted_codes.append(prod_code)
                pos_text = pos_text.replace(prod_code, '')
        # print(pos_id, len(extracted_codes), extracted_codes)
        if len(extracted_codes) == 1:
            updates.append((extracted_codes[0], pos_id))
    # print(pretty(updates))
    cursor.executemany(f'UPDATE {table} SET [product_code_from_text] = ? WHERE [id] = ?;',
                       updates)
    sbmsdb_conn.commit()

logger.info('Update finished')
