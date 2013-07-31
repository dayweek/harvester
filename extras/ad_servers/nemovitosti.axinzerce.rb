# jihomoravsky kraj
@base = "http://www.nemovitosti.axinzerce.cz/"

#@debug = true
@list_only = false
@urls = [ 
	'http://www.nemovitosti.axinzerce.cz/region/jihomoravsky_kraj/60-inzerce.htm'
]

@detail_url_path = "//a[b[contains(@class, 'nadpis')]]"

@description = "//i[contains(.,'Nabídka:')]/following-sibling::node()"
@phone_paths = ["//td[contains(@width, '603')]//table[contains(@bgcolor, '#CCDBF7')]"]
