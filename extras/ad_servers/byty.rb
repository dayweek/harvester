# jihomoravsky kraj
@base = "http://www.byty.cz/"

#@debug = true
@list_only = false
@urls = [ 
	'http://www.byty.cz/domy-prodej/?regi=5200&np=1&kom=1&search=1', #domy
	'http://www.byty.cz/byty-prodej/?regi=5200&np=1&kom=1&search=1', #byty
	'http://www.byty.cz/komercni-vyrobni-prostory/?regi=5200&np=1&kom=1&search=1', #komercni
	'http://www.byty.cz/pozemky/?regi=5200&np=1&kom=1&search=1' #pozemky
]


@detail_url_path = 'table h2 a'

@description = "div.adText"
@phone_paths = ["//table[contains(@class, 'adFooter')][1]"]
