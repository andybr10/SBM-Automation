from bexiopy.api import Client as BexiopyClient
from bexiopy.api import logger
import os
import shelve
import uuid
import time
from splinter import Browser
from urllib import parse as urlparse
from .settings import (
    CLIENT_ID, CLIENT_SECRET, REDIRECT_URI, SCOPE, DRIVER_NAME, TEXT_TO_FIND, USER_NAME, USER_PASS, RESOURCES,
    _BEXIO_AUTH_URL,
    _BEXIO_TOKEN_URL,
    _BEXIO_TOKEN_REFRESH_URL,
    _BEXIO_API_URL,
    _BEXIO_CREDENTIALS_FILENAME
)


class Client(BexiopyClient):
    """
    Own implementation of Client from bexio-api-python-client module
    """

    RES_ORDER = 'kb_order'
    RES_INVOICE = 'kb_invoice'
    RES_DELIVERY = 'kb_delivery'

    POS_TYPE_ALL = 'ALL'
    POS_TYPE_CUSTOM = 'KbPositionCustom'
    POS_TYPE_ARTICLE = 'KbPositionArticle'
    POS_TYPE_DISCOUNT = 'KbPositionDiscount'

    # overloaded
    def __init__(self, *args, **kwargs):
        # construct auth data
        self.API_URL = _BEXIO_API_URL
        self.OAUTH2_AUTH_URL = _BEXIO_AUTH_URL
        self.OAUTH2_TOKEN_URI = _BEXIO_TOKEN_URL
        self.OAUTH2_REFRESH_TOKEN_URI = _BEXIO_TOKEN_REFRESH_URL

        # construct client data
        self.access_token = None
        self.auth = None
        self.config = {
            'client_id': CLIENT_ID,
            'client_secret': CLIENT_SECRET,
            'redirect_uri': REDIRECT_URI,
            'scope': SCOPE,
            'state': uuid.uuid4()
        }
        # get access_token data from file, if exists
        self.load_access_token_from_file()

    # overloaded
    def load_access_token_from_file(self):
        """
        Open and return the dictionary of the shelve file.

        Returns:
            dict: :code:`access_token` loaded from file
        """
        check_file = _BEXIO_CREDENTIALS_FILENAME
        if os.name == 'nt':
            check_file = check_file + '.dat'
        if os.path.exists(check_file):
            with shelve.open(_BEXIO_CREDENTIALS_FILENAME) as access_token:
                token = dict(access_token)
            access_token.close()
            self.access_token = token
        else:
            # let user know, he needs to authentiate with bexio
            logger.info('Attempting to authorize automatically')
            self.access_token = self.auto_authorize()
        return self.access_token

    def auto_authorize(self):
        logger.debug(self.config)
        auth_url = self.get_oauth2_auth_url()
        with Browser(DRIVER_NAME, headless=True) as browser:
            browser.visit(auth_url)
            # fill the username and password fields in browser and hit submit, wait 2 seconds
            browser.find_by_id('j_username').first.fill(USER_NAME)
            browser.find_by_id('j_password').first.fill(USER_PASS)
            browser.find_by_xpath("//button[@type='submit' and @class='button']").click()
            time.sleep(2)
            if browser.is_text_present(TEXT_TO_FIND):
                # login was successful
                logger.debug("Yes, login was successful and API permissions page was found!")
                logger.debug('URL: ' + browser.url)
                # hit submit to accept the authorization, wait 1 second
                browser.find_by_xpath("//button[@type='submit' and @name='authorize' and @value=1]").click()
                time.sleep(1)
                # extract the authorization code and get the access token
                logger.debug('URL: ' + browser.url)
                code = urlparse.parse_qs(urlparse.urlparse(browser.url).query)['code']
                logger.debug('Code: ' + str(code))
                self.fetch_access_token_with_auth_code(code)
                return self.get_access_token()
            else:
                logger.debug("Nope, failed...")
                if browser.is_text_present('Invalid scope'):
                    logger.error(f'Invalid scope: {SCOPE}')
                return {}

    def list(self, resource: str) -> list:
        if resource not in RESOURCES:
            logger.warning('Attempt to list not supported resource')
            return []
        else:
            rss_list = self.call('GET', resource)
            logger.debug(rss_list)
            return rss_list  # self.call() can return list or dict, but should return list only when used with resources

    def show(self, resource: str, record_id: int) -> dict:
        record = self.call('GET', f'{resource}/{record_id}')
        logger.debug(record)
        return record

    def list_position(self, resource: str, record_id: int, pos_type: str) -> list:
        if resource not in [self.RES_DELIVERY, self.RES_INVOICE, self.RES_ORDER]:
            return []
        else:
            record = self.show(resource, record_id)
            all_positions = record['positions']
            if pos_type == self.POS_TYPE_ALL:
                positions = all_positions
            elif pos_type in [self.POS_TYPE_ARTICLE, self.POS_TYPE_CUSTOM]:
                positions = [pos for pos in all_positions if pos['type'] == pos_type]
            else:
                logger.warning('Unsupported POS_TYPE')
                positions = []
            logger.debug(positions)
            return positions
