# -*- coding: utf-8 -*-

import scrapy


class Horticraft(scrapy.Item):
    acc = scrapy.Field()
    league = scrapy.Field()
    lastname = scrapy.Field()
    stashname = scrapy.Field()
    items = scrapy.Field()
    # verified = scrapy.Field()
    # x = scrapy.Field()
    # y = scrapy.Field()
    # hash = scrapy.Field()
    # craftname = scrapy.Field()
    # ilvl = scrapy.Field()
    # price = scrapy.Field()
    # currname = scrapy.Field()
