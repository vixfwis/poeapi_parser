# -*- coding: utf-8 -*-

import scrapy


class Horticraft(scrapy.Item):
    acc = scrapy.Field()
    league = scrapy.Field()
    lastname = scrapy.Field()
    stashname = scrapy.Field()
    stashhash = scrapy.Field()
    items = scrapy.Field()
