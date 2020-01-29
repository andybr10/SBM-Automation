from setuptools import setup

setup(
    name='<some company reporting>',
    version='0.2',
    author='Andreia Marques',
    packages=['bexio_tools'],
    include_package_data=True,
    install_requires=[
        'bexio-api-python-client<=0.1.5',
        'click',
        'pyodbc',
        'requests',
        'six',
        'splinter',
        'xmltodict'
    ]
)
