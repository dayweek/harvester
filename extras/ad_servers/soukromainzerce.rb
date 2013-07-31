# jihomoravsky kraj
@base = "http://www.soukromainzerce.cz/"

#@debug = true
@list_only = false
@urls = [
	'http://www.soukromainzerce.cz/reality/byty/?kind=5&page=1&region=76',
	'http://www.soukromainzerce.cz/reality/chaty-chalupy-rekreacni-objekty/?kind=5&page=1&region=76',
	'http://www.soukromainzerce.cz/reality/pozemky/?kind=5&page=1&region=76', #nic tam neni
	'http://www.soukromainzerce.cz/reality/nebytove-prostory/?kind=5&page=1&region=76',
	'http://www.soukromainzerce.cz/reality/rodinne-domy-vily/?kind=5&page=1&region=76',
	'http://www.soukromainzerce.cz/reality/garaze-parkovani/?kind=5&page=1&region=76',
	'http://www.soukromainzerce.cz/reality/najemni-domy/?kind=5&page=1&region=76'
]

@detail_url_path = 'table td.item-subject a'

@description = "td.item-note"
@phone_paths = ['td.item-feature']
