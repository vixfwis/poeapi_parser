import scrapy
import os
import sys
dir_path, _ = os.path.split(os.path.dirname(os.path.realpath(__file__)))
sys.path.append(dir_path)
from scrapy.crawler import CrawlerProcess
from poeapi_parser.spiders.poeapi import PoeApiSpider
from scrapy.utils.project import get_project_settings


def main():
    process = CrawlerProcess(get_project_settings())
    process.crawl(PoeApiSpider)
    process.start()


if __name__ == '__main__':
    main()
