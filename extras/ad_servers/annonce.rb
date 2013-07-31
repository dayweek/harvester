# JM mimo vyskov

@base = "http://www.annonce.cz/"
@reality_phrases = ['provize RK', 'Číslo zakázky', 'Bližší informace Vám sdělí', 'ID nabídky', 'hypotečního úvěru']
#@debug = true

@list_only = false
@urls = [
	"http://www.annonce.cz/byty-na-prodej$334-filter.html?type=&disposal=&price_from=od&price_to=do&q=&location_country=1493&location_zip=54&location_zip=55&location_zip=56&location_zip=57&location_zip=58&location_zip=59&location_zip=60&location_zip=61&location_zip=62&location_zip=63&location_zip=64&location_zip=65&location_zip=66&location_zip=67&location_zip=68&location_zip=69&location_zip=70&location_zip=71&location_zip=72&location_zip=74&location_zip=75&location_zip=76&location_zip=9070&location_zip=9071&property_type=&maxAge=&form_id=1316526260875&action.x=34&action.y=28&action=filter", #byty
	'http://www.annonce.cz/domy-na-prodej$334-filter.html?business_type=&price_from=od&price_to=do&q=&location_country=1493&location_zip=54&location_zip=55&location_zip=56&location_zip=57&location_zip=58&location_zip=59&location_zip=60&location_zip=61&location_zip=62&location_zip=63&location_zip=64&location_zip=65&location_zip=66&location_zip=67&location_zip=68&location_zip=69&location_zip=70&location_zip=71&location_zip=72&location_zip=74&location_zip=75&location_zip=76&location_zip=9070&location_zip=9071&maxAge=&form_id=1316526355712&action.x=83&action.y=6&action=filter', #domy
	'http://www.annonce.cz/komercni-prostory$334-filter.html?business_type=&price_from=od&price_to=do&q=&location_country=1493&location_zip=54&location_zip=55&location_zip=56&location_zip=57&location_zip=58&location_zip=59&location_zip=60&location_zip=61&location_zip=62&location_zip=63&location_zip=64&location_zip=65&location_zip=66&location_zip=67&location_zip=68&location_zip=69&location_zip=70&location_zip=71&location_zip=72&location_zip=74&location_zip=75&location_zip=76&location_zip=9070&location_zip=9071&maxAge=&form_id=1316526408709&action.x=115&action.y=10&action=filter', #komercni
	'http://www.annonce.cz/pozemky$334-filter.html?business_type=&land_type=&price_from=od&price_to=do&q=&location_country=1493&location_zip=54&location_zip=55&location_zip=56&location_zip=57&location_zip=58&location_zip=59&location_zip=60&location_zip=61&location_zip=62&location_zip=63&location_zip=64&location_zip=65&location_zip=66&location_zip=67&location_zip=68&location_zip=69&location_zip=70&location_zip=71&location_zip=72&location_zip=74&location_zip=75&location_zip=76&location_zip=9070&location_zip=9071&maxAge=&form_id=1316526494916&action.x=114&action.y=22&action=filter' #pozemky
]
@detail_url_path = 'div.ad-short h2 a'

@phone_paths = ['div.ad-detail-contact']
#@price = "//tr[th[@class='price']]/td/a/text()"
#@description_table = "table.commodity-elements"
@description = "//div[contains(@class,'text')]"
