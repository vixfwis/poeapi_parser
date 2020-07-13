# -*- coding: utf-8 -*-
from poeapi_parser.items import Horticraft
import pymysql


class PoeapiParserPipeline(object):
    def open_spider(self, spider):
        self.conn = pymysql.connect(
            host='localhost',
            user='poeapi',
            password='',
            db='poeapi',
            charset='utf8mb4',
        )
        c = self.conn.cursor()

        c.execute('select id,name from currency')
        curr = c.fetchall()
        self.curr = {}
        for id, name in curr:
            self.curr[name] = id

        c.execute('select id,name from hcraft_names')
        cnames = c.fetchall()
        self.cnames = {}
        for id, name in cnames:
            self.cnames[name] = id

    def close_spider(self, spider):
        self.conn.close()

    def process_item(self, item, spider):
        if isinstance(item, Horticraft):
            c = self.conn.cursor()
            c.execute('begin')
            c.execute('insert into accounts (name) values (%s) on duplicate key update id=last_insert_id(id)', item['acc'])
            acc_id = c.lastrowid
            c.execute('insert into leagues (name) values (%s) on duplicate key update id=last_insert_id(id)', item['league'])
            league_id = c.lastrowid
            c.execute('insert into chars (name, account_id) values (%s,%s) on \
                    duplicate key update \
                    id=last_insert_id(id), account_id=%s', (item['lastname'], acc_id, acc_id))

            c.execute('delete from items where account_id=%s and league_id=%s', (acc_id, league_id))
            for i in item['items']:
                # c.execute('insert into items (account_id, league_id, verified, stash_name, stash_hash, x, y, item_hash)\
                #            values (%s,%s,%s,%s,%s,%s,%s) on duplicate key\
                #            update \
                #            account_id=%s, league_id=%s, verified=%s, stash_name=%s, x=%s, y=%s, last_updated=current_timestamp()',
                #           (acc_id, league_id, i['verified'], item['stashname'], i['x'], i['y'], i['hash'],
                #            acc_id, league_id, i['verified'], item['stashname'], i['x'], i['y'])
                # )
                c.execute('insert into items (account_id, league_id, verified, stash_name, x, y)\
                           values (%s,%s,%s,%s,%s,%s)',
                          (acc_id, league_id, i['verified'], item['stashname'], i['x'], i['y']))
                item_id = c.lastrowid
                cvalues = []
                for craft in i['crafts']:
                    craftname = craft['craftname']
                    if craftname in self.cnames:
                        craft_id = self.cnames[craftname]
                    else:
                        c.execute(
                            'insert into hcraft_names (name) values (%s) on duplicate key update id=last_insert_id(id)',
                            craftname)
                        craft_id = c.lastrowid
                        self.cnames[craftname] = craft_id

                    currname = craft['currname']
                    if currname in self.curr:
                        curr_id = self.curr[currname]
                    else:
                        c.execute(
                            'insert into currency (name) values (%s) on duplicate key update id=last_insert_id(id)',
                            currname)
                        curr_id = c.lastrowid
                        self.curr[currname] = curr_id

                    cvalues.append((
                        item_id, craft_id, craft['price'], curr_id, craft['price']
                    ))

                c.executemany('insert into hcrafts (item_id, craft_id, price, currency_id, ilvl) values\
                               (%s,%s,%s,%s,%s)', cvalues)

            c.execute('commit')
        return item
