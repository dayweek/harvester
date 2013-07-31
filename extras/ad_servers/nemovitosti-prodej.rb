# znojmo, blansko, brna
@base = "http://www.nemovitosti-prodej.eu/"

#@debug = true
@list_only = false
@urls = [
	'http://www.nemovitosti-prodej.eu/search/?typ=prodej&mesto=&cena1=&cena2=&lokalita%5B%5D=10202&lokalita%5B%5D=10203&lokalita%5B%5D=10201&lokalita%5B%5D=10207'
]

@detail_url_path = '.popisBezFoto h2 a'

@description = "//div[contains(@class,'DetailAd')]/following-sibling::*[1]"
@phone_paths = ['//*/text()[contains(.,\'Telefon\')]']
