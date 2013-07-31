# jihomoravsky kraj
@base = "http://www.realites.cz/"
@reality_phrases = ['Makléř'] #prohledavat i u telefonu

#@debug = true
@list_only = false
@urls = [
	'http://www.realites.cz/reality?s=0&nem_typ=1&okresy=4',
	'http://www.realites.cz/reality?s=0&nem_typ=1&okresy=5',
	'http://www.realites.cz/reality?s=0&nem_typ=1&okresy=3',
	'http://www.realites.cz/reality?s=0&nem_typ=1&okresy=75',
	#'http://www.realites.cz/reality?s=0&nem_typ=1&okresy=73', #vyskov
	'http://www.realites.cz/reality?s=0&nem_typ=1&okresy=18', #hodonin
	'http://www.realites.cz/reality?s=0&nem_typ=1&okresy=7' #breclav
]

@detail_url_path = 'table.tableVypis a.r1'

@description = "td.TDdetailReal span.seznam"
@phone_paths = ['table.TABbezna2']
