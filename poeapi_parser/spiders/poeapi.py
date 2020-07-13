# -*- coding: utf-8 -*-
import scrapy
import os
import json
import re
from poeapi_parser.items import Horticraft

currency_names = {
    'chaos': ['c', 'chaos', 'cha'],
    'ex': ['ex', 'exa', 'exalted'],
    'mir': ['m', 'mir', 'mirror']
}


class PoeApiSpider(scrapy.Spider):
    # start_at = '758976063-772689973-737176497-834446350-795850388'
    base_url = 'https://www.pathofexile.com/api/public-stash-tabs?id='
    name = 'poeapi'
    ilvl_re = re.compile(r'.*?\(([\d]{1,3})\)$')
    price_re = re.compile(r'([\d.]+)([A-z]+)')

    def parse_currency(self, line):
        for key in currency_names:
            if line in currency_names[key]:
                return key
        return None

    def start_requests(self):
        if getattr(self, 'start_at', None) is not None:
            return [scrapy.Request(self.base_url + self.start_at, callback=self.parse_poeapi)]
        else:
            return [scrapy.Request('https://poe.ninja/api/Data/GetStats', callback=self.grab_latest_change_id)]

    def grab_latest_change_id(self, response):
        data = json.loads(response.body)
        return scrapy.Request(self.base_url + data['next_change_id'], callback=self.parse_poeapi)

    def parse_poeapi(self, response):
        data = json.loads(response.body)
        for stash in data['stashes']:
            acc_name = stash['accountName']
            last_name = stash['lastCharacterName']
            stash_name = stash['stash']
            league = stash['league']
            out = Horticraft(
                acc=acc_name,
                league=league,
                lastname=last_name,
                stashname=stash_name,
                items=[]
            )
            for item in stash['items']:
                if item['typeLine'] != 'Horticrafting Station':
                    continue
                if 'craftedMods' not in item:
                    continue
                if 'note' not in item:
                    continue
                mods = item['craftedMods']
                note = item['note']
                ver = item['verified']
                if not note.startswith('#'):
                    continue
                x = item['x']
                y = item['y']
                itemdata = {
                    'verified': ver,
                    'x': x,
                    'y': y,
                    'crafts': []
                }
                parts = note[1:].split('/')
                for mod, price in zip(mods, parts):
                    m1 = self.ilvl_re.match(mod)
                    m2 = self.price_re.match(price)
                    if m1 and m2:
                        ilvl = m1.group(1)
                        price_value = float(m2.group(1))
                        price_currency = self.parse_currency(m2.group(2))
                        if price_currency is None:
                            continue
                        mod = mod.replace(f'({ilvl})', '').strip()
                        itemdata['crafts'].append({
                            'craftname': mod,
                            'ilvl': ilvl,
                            'price': price_value,
                            'currname': price_currency
                        })
                        # print(f'{last_name} -> {mod} for {price_value} {price_currency} (ilvl {ilvl})')
                out['items'].append(itemdata)
            if len(out['items']) > 0:
                yield out

        yield scrapy.Request(self.base_url + data['next_change_id'], callback=self.parse_poeapi)
