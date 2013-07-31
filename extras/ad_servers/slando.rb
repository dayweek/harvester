# jihomoravsky
@base = "http://nemovitosti.brno.slando.cz/"

#@debug = true
@list_only = false
@urls = [
	'http://nemovitosti.brno.slando.cz/brno/prodej_byty_garsoniery_nabidka_5204_1.html',
	'http://nemovitosti.brno.slando.cz/brno/prodej_rodinne_domy_nabidka_5207_1.html',
	'http://nemovitosti.brno.slando.cz/brno/prodej_nebyt_prostory_nabidka_5210_1.html',
	'http://nemovitosti.brno.slando.cz/brno/prodej_pozemky_chaty_nabidka_5216_1.html'
]

@detail_url_path = '.blockofads a.desc'

@description = "#desc p.copy"
@phone_paths = ['p.contacts']
