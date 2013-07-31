# JM
@base = "http://inzerujreality.cz/"

@debug = true
@list_only = false
@urls = [ 
	['http://inzerujreality.cz/index.php', {
	'Kraj' => 'Jihomoravský',
	'kat' => '',
	'druh' => '',
	'kategorie' => ''
}]
	#'http://inzerujreality.cz/index.php'
]

@detail_url_path = 'table a.detail'

@description = "//table[@width='570' and @cellpadding='3']//tr[4]"
@phone_paths = ['table[width=570][cellpadding=3]']
