# jihomoravsky kraj, soukrome
#@base = "http://www.inzerce-realit.com/"
@base = ""

#@debug = true
@list_only = false
@urls = [
	'http://www.inzerce-realit.com/vse/vse/jihomoravsky-kraj/?typ_uctu=soukromy&typ=nabidka-prodej#right'
]

@detail_url_path = 'td.nadpis a'

@description = "td.popis"
# telefon je v novem okne
@phone_paths = [
Proc.new do |detail_url|
	begin
	phone = ''
page = @agent.get detail_url
a = page.search('a.detail-telefon')
unless a.empty?
	page = @agent.get a.first['href']
	phones = Harvest::phones_from_text(page.search('td.mobil').text())
	phone = phones.first
end
	Rails.logger.info("inzerce-realit.com - telefon vybran z noveho okna:" + phone)
	rescue => e
		Rails.logger.error e.message
		Rails.logger.error e.backtrace
		raise e
	end
phone
end
]
