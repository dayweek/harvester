# jihomoravsky kraj
@base = "http://spechato.cz/"
@insert = true
@debug = true
@reality_phrases = ['Se svolením investora', 'wikireality.cz', 'bezrealitky.cz']
@list_only = false
@urls = [
	'http://spechato.cz/reality/domy-prodej-pronajem-vymena/jihomoravsky-kraj/?search%5Bfilter_enum_2%5D=Sale&search%5Bprivate_business%5D=private',
	'http://spechato.cz/reality/byty_prodej_pronajem_vymena/jihomoravsky-kraj/?search%5Bfilter_enum_3%5D=Sale&search%5Bprivate_business%5D=private',
	'http://spechato.cz/reality/chaty-rekreacni-objekty/jihomoravsky-kraj/?search%5Bfilter_enum_1%5D=Sell&search%5Bprivate_business%5D=private',
	'http://spechato.cz/reality/pozemky-prodej-pronajem-vymena/jihomoravsky-kraj/?search%5Bfilter_enum_2%5D=owner&search%5Bfilter_enum_3%5D=Sell&search%5Bprivate_business%5D=private',
	'http://spechato.cz/reality/parkovani-garaze/jihomoravsky-kraj/?search%5Bprivate_business%5D=private'
]

@detail_url_path = 'td h4.normal a.link'

@description = "//div[contains(@class,'adcontent')]/p"
#@phone = '//*/text()[contains(.,\'Telefon\')]'
# zakodovany kontakt
