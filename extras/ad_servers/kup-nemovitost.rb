# jihomoravsky kraj
@base = "http://kup-nemovitost.cz/reality/"

#@debug = true
@list_only = false
@urls = [
	'http://kup-nemovitost.cz/reality/kraj_116_Jihomoravsky'
]

@detail_url_path = 'table td.c_realtyCaption a'

@description = "//caption[contains(., 'popis')]/following-sibling::node()"
@phone_paths = ['.realtyViewBoxColumn']
