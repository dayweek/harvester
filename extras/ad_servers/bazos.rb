# vse, 53km od brno mesto
@base = "http://reality.bazos.cz/"
#@debug = true

@list_only = false
@urls = [
	'http://reality.bazos.cz/prodam/?hledat=&rubriky=reality&hlokalita=60200&humkreis=53&cenaod=&cenado=&Submit=Hledat&kitx=ano'
]
@detail_url_path = '.inzeraty .nadpis a'

@description = "//td[contains(@colspan,'3')]"
#@phone = "//td[contains(@class,'listal')]//td[2]/child::text()[1]"
@phone_paths = ["//td[contains(@class,'listal') and contains(@valign,'top')]"]
