_BEXIO_AUTH_URL = 'https://office.bexio.com/oauth/authorize'
_BEXIO_TOKEN_URL = 'https://office.bexio.com/oauth/access_token'
_BEXIO_TOKEN_REFRESH_URL = 'https://office.bexio.com/oauth/refresh_token'
_BEXIO_API_URL = 'https://office.bexio.com/api2.php'
_BEXIO_CREDENTIALS_FILENAME = '.bxcred'

CLIENT_ID = '<client_id>'
CLIENT_SECRET = '<client_secret>'
REDIRECT_URI = 'acc_tkn'
# scopes must be _edit to allow position listing!
SCOPE = ' '.join([
    'general',
    'kb_invoice_edit',
    'kb_order_edit',
    'kb_delivery_edit',
    'article_edit',
    'contact_edit'
])
RESOURCES = [
    'article',
    'article_type',
    'contact',
    'contact_branch',
    'contact_group',
    'contact_relation',
    'contact_type',
    'country',
    'currency',
    'payment_type',
    'salutation',
    'title',
    'unit',
    'user',
    'kb_delivery',
    'kb_invoice',
    'kb_order'
]
TEXT_TO_FIND = '<some cool guy>'
DRIVER_NAME = 'chrome'
USER_NAME = '<my_user_name>'
USER_PASS = '<my_password>'
