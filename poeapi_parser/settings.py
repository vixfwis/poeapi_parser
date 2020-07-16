# -*- coding: utf-8 -*-
import os


BOT_NAME = 'poeapi_parser'

LOG_LEVEL = 'ERROR'
SPIDER_MODULES = ['poeapi_parser.spiders']
NEWSPIDER_MODULE = 'poeapi_parser.spiders'
USER_AGENT = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0'
ROBOTSTXT_OBEY = False
CONCURRENT_REQUESTS = 1
DOWNLOAD_DELAY = 1
COOKIES_ENABLED = True
TELNETCONSOLE_ENABLED = False
DUPEFILTER_CLASS = 'scrapy.dupefilters.BaseDupeFilter'

ITEM_PIPELINES = {
   'poeapi_parser.pipelines.PoeapiParserPipeline': 300,
}

AUTOTHROTTLE_ENABLED = True
AUTOTHROTTLE_START_DELAY = 1
AUTOTHROTTLE_MAX_DELAY = 30
AUTOTHROTTLE_TARGET_CONCURRENCY = 1
AUTOTHROTTLE_DEBUG = False

DB_HOST = os.getenv('DB_HOST', 'localhost')
DB_NAME = os.getenv('DB_NAME', 'poeapi')
DB_USER = os.getenv('DB_USER', 'poeapi')
DB_PASSWORD = os.getenv('DB_PASSWORD', '')

# HTTPCACHE_ENABLED = True
# HTTPCACHE_EXPIRATION_SECS = 0
# HTTPCACHE_DIR = 'httpcache'
# HTTPCACHE_IGNORE_HTTP_CODES = []
# HTTPCACHE_STORAGE = 'scrapy.extensions.httpcache.FilesystemCacheStorage'

#DEFAULT_REQUEST_HEADERS = {
#   'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
#   'Accept-Language': 'en',
#}

# Enable or disable spider middlewares
# See https://docs.scrapy.org/en/latest/topics/spider-middleware.html
#SPIDER_MIDDLEWARES = {
#    'poeapi_parser.middlewares.PoeapiParserSpiderMiddleware': 543,
#}

# Enable or disable downloader middlewares
# See https://docs.scrapy.org/en/latest/topics/downloader-middleware.html
#DOWNLOADER_MIDDLEWARES = {
#    'poeapi_parser.middlewares.PoeapiParserDownloaderMiddleware': 543,
#}

# Enable or disable extensions
# See https://docs.scrapy.org/en/latest/topics/extensions.html
#EXTENSIONS = {
#    'scrapy.extensions.telnet.TelnetConsole': None,
#}
