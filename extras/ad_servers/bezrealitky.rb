# kruh kolem brno
@base = "http://www.bezrealitky.cz/"

#@debug = true
@list_only = false
@detail_url_procs = [
Proc.new do
urls = [
	['http://www.bezrealitky.cz/vyhledat/result?offertype=1&lat=49.15886306546475&lng=16.623285522460943&accuracy=0.4340451515575527&area_unlimited=true&price_unlimited=true&estatetype_id=1&disposition_id=0&furnished_id=&area_min=0&area_max=neom.&price_min=0&price_max=neom.',
	'http://www.bezrealitky.cz/utils/synchro-json/?lat=49.160765044876854&lng=16.623285522460947&accuracy=0.44273930942254225&accuracy_lng=0.867919921875&menu=1&limit=200'], #byty

	['http://www.bezrealitky.cz/vyhledat/result?offertype=1&lat=49.158786108926876&lng=16.623285522460947&accuracy=0.398465378480288&area_unlimited=true&price_unlimited=true&estatetype_id=2&disposition_id=0&furnished_id=&area_min=0&area_max=neom.&price_min=0&price_max=neom.',
	'http://www.bezrealitky.cz/utils/synchro-json/?lat=49.1603890333842&lng=16.623285522460947&accuracy=0.44274267072108486&accuracy_lng=0.867919921875&menu=1&limit=200'], #dum

	['http://www.bezrealitky.cz/vyhledat/result?offertype=1&lat=49.15841009363609&lng=16.623285522460947&accuracy=0.3984684036489764&area_unlimited=true&price_unlimited=true&estatetype_id=3&disposition_id=0&furnished_id=&area_min=0&area_max=neom.&price_min=0&price_max=neom.',
	'http://www.bezrealitky.cz/utils/synchro-json/?lat=49.16001302116982&lng=16.623285522460947&accuracy=0.44274603200700824&accuracy_lng=0.867919921875&menu=1&limit=200'], #pozemek

	['http://www.bezrealitky.cz/vyhledat/result?offertype=1&lat=49.15803407762394&lng=16.623285522460947&accuracy=0.3984714288063074&area_unlimited=true&price_unlimited=true&estatetype_id=4&disposition_id=0&furnished_id=&area_min=0&area_max=neom.&price_min=0&price_max=neom.',
	'http://www.bezrealitky.cz/utils/synchro-json/?lat=49.15963700823378&lng=16.623285522460947&accuracy=0.4427493932803088&accuracy_lng=0.867919921875&menu=1&limit=200'], #garaz

	['http://www.bezrealitky.cz/vyhledat/result?offertype=1&lat=49.157658060890455&lng=16.623285522460947&accuracy=0.39847445395227793&area_unlimited=true&price_unlimited=true&estatetype_id=5&disposition_id=0&furnished_id=&area_min=0&area_max=neom.&price_min=0&price_max=neom.',
	'http://www.bezrealitky.cz/utils/synchro-json/?lat=49.15926099457616&lng=16.623285522460947&accuracy=0.44275275454099017&accuracy_lng=0.867919921875&menu=1&limit=200'], #kancelar

	['http://www.bezrealitky.cz/vyhledat/result?offertype=1&lat=49.15728204343575&lng=16.623285522460947&accuracy=0.3984774790868912&area_unlimited=true&price_unlimited=true&estatetype_id=6&disposition_id=0&furnished_id=&area_min=0&area_max=neom.&price_min=0&price_max=neom.',
	'http://www.bezrealitky.cz/utils/synchro-json/?lat=49.15888498019704&lng=16.623285522460947&accuracy=0.4427561157890523&accuracy_lng=0.867919921875&menu=1&limit=200'], #nebytovy prostor

	['http://www.bezrealitky.cz/vyhledat/result?offertype=1&lat=49.15690602525982&lng=16.623285522460947&accuracy=0.3984805042101471&area_unlimited=true&price_unlimited=true&estatetype_id=7&disposition_id=0&furnished_id=&area_min=0&area_max=neom.&price_min=0&price_max=neom.',
	'http://www.bezrealitky.cz/utils/synchro-json/?lat=49.158508965096445&lng=16.623285522460947&accuracy=0.4427594770245058&accuracy_lng=0.867919921875&menu=1&limit=200'] #rekreacni obj

]
	detail_urls = []
	urls.each do |url|
		@agent.get(url.first)
		page = @agent.get url.last
		js = ActiveSupport::JSON.decode page.body
		js['points'].each { |j| detail_urls << j['url'] }
	end
	detail_urls
end
]

@description = "#desctextcz p"
@phone_paths = ['div.majitel']
