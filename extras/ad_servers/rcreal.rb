# jihomoravsky kraj
@base = "http://www.rcreal.cz/"

#@debug = true
@list_only = false
@urls = [
	'http://www.rcreal.cz/nemovitost_zobrazeni_seznam.asp?tridit=id&smer=desc&np=n&nove=&kategorie=1&typ=&lokalita=2&cena=&mena=1&okres=&stari=&Popis=&Firma='
]

@detail_url_path = 'table table tr td a.text'

@description = "//b[contains(text(), 'Popis')]/parent::node()/following-sibling::node()"
@phone_paths = ["table[width=615]"]
