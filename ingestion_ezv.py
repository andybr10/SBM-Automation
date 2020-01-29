import click
import datetime
import requests
import xmltodict
from database_tools import SBMSALESDB
import logging
from helpers import pretty

logger = logging.getLogger('EZV FX Ingestion')
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

now = datetime.datetime.now()


@click.command()
@click.option('--year', default=now.year, help='Year of exchange rate')
@click.option('--month', default=now.month, help='Month of exchange rate')
def ingest_monthly_rates(year: int, month: int):
    period = f'{year}-{month}'
    logger.debug(f'Ingesting FX rates for the period: {period}')
    r = requests.get(f'http://www.pwebapps.ezv.admin.ch/apps/rates/estv/getavgxml?lang=1&j={year}&m={month}')
    monthly_rates = xmltodict.parse(r.content)['monatsmittelkurs']
    # print(pretty(monthly_rates))
    try:
        cursor.execute("DELETE FROM [ezv].[fxrates_chf] WHERE [monat] = ?;", monthly_rates['monat'])
    except KeyError:
        logger.error(f'Seems like there are no data for the period {period}.')
        logger.error(f'XML:\n{pretty(monthly_rates)}')
        return None
    else:
        sbmsdb_conn.commit()
    values = [[monthly_rates['monat'], d['@code'], d['land_de'], d['land_fr'], d['land_it'], d['waehrung'], d['kurs']]
              for d in monthly_rates['devise']]
    # print(pretty(values))
    cursor.executemany("INSERT INTO [ezv].[fxrates_chf] VALUES (?, ?, ?, ?, ?, ?, ?)", values)
    sbmsdb_conn.commit()
    logger.info(f'FX rates ingest successful for the period: {period}')


if __name__ == '__main__':
    ingest_monthly_rates()
