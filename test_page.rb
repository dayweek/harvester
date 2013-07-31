$proc1 = Proc.new {
	@agent.get('http://www.bezrealitky.cz/vyhledat/result?offertype=1&lat=49.17996351485773&lng=16.654184570312506&accuracy=0.8677308707726145&area_unlimited=true&price_unlimited=true&estatetype_id=1&disposition_id=0&furnished_id=&area_min=0&area_max=neom.&price_min=0&price_max=neom.')
	page = @agent.get "http://www.bezrealitky.cz/utils/synchro-json/?lat=49.1875717784758&lng=16.65418457031251&accuracy=0.88500824344219&accuracy_lng=1.73583984375&menu=1&limit=200"
	js = ActiveSupport::JSON.decode page.body
	urls = []
	js['points'].each { |j| urls << j['url'] }
	urls
	}

class A
	def initialize 
		@agent = Mechanize.new
	end
	def get_urls
		instance_eval &$proc1
	end
end


