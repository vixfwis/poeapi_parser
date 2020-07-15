# -*- coding: utf-8 -*-
from poeapi_parser.items import HorticraftTab
import pymysql
import logging


class LoggingCursor(pymysql.cursors.Cursor):
    def __init__(self, connection):
        super().__init__(connection)
        self.logger = logging.getLogger(f'cursor')

    def execute(self, query, args=None):
        while self.nextset():
            pass
        query = self.mogrify(query, args)
        val = query
        if isinstance(val, bytearray):
            val = val.decode()
        parts = [e.strip() for e in val.split(' ') if e != '']
        val = ' '.join([e.strip() for e in parts if e != ''])
        self.logger.info(val)
        result = self._query(query)
        self._executed = query
        return result


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
        if isinstance(item, HorticraftTab):
            c = self.conn.cursor(cursor=LoggingCursor)
            c.execute('begin')
            c.execute('insert into accounts (name) values (%s) on duplicate key update id=last_insert_id(id)', item['acc'])
            acc_id = c.lastrowid
            c.execute('insert into leagues (name) values (%s) on duplicate key update id=last_insert_id(id)', item['league'])
            league_id = c.lastrowid
            c.execute('insert into chars (name, account_id) values (%s,%s) on \
                    duplicate key update \
                    id=last_insert_id(id), account_id=%s', (item['lastname'], acc_id, acc_id))
            stash_hash = item['stashhash']

            c.execute('select id from stashes where stash_hash = %s', stash_hash)
            stashid = c.fetchone()
            if stashid is None:
                c.execute('insert into stashes (stash_hash, account_id, league_id, name) values (%s,%s,%s,%s)\
                                              ', (stash_hash, acc_id, league_id, item['stashname']))
                stashid = c.lastrowid

            c.execute('select items.id, items.item_hash, items.stash_id from items\
                       inner join stashes on stashes.id = items.stash_id\
                       where stashes.stash_hash = %s', stash_hash)

            t = c.fetchall()
            existing_items = {}
            for id, itemhash, s in t:
                existing_items[itemhash] = {'id': id, 'sid': s}

            for i in item['items']:
                itemhash = i['itemhash']
                if itemhash in existing_items:
                    c.execute('update items set verified=%s, x=%s, y=%s, last_updated=current_timestamp()\
                               where id=%s', (i['verified'], i['x'], i['y'], existing_items[itemhash]['id']))
                    cvalues = []
                    for craft in i['crafts']:
                        c.execute('delete from hcrafts where item_id = %s', existing_items[itemhash]['id'])
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
                            existing_items[itemhash]['id'], craft_id, craft['price'], curr_id, craft['price']
                        ))
                    c.executemany('insert into hcrafts (item_id, craft_id, price, currency_id, ilvl) values\
                                                   (%s,%s,%s,%s,%s)', cvalues)
                    del existing_items[itemhash]
                else:
                    c.execute('insert into items (stash_id, item_hash, verified, x, y)\
                                               values (%s,%s,%s,%s,%s)',
                              (stashid, i['itemhash'], i['verified'], i['x'], i['y']))
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
            if len(existing_items.keys()) > 0:
                leftovers = []
                for k in existing_items:
                    leftovers.append(existing_items[k]['id'])
                print(",".join(leftovers))
                c.execute(f'delete from items where id in ({",".join(leftovers)})')

            c.execute('commit')
        return item
