# coding: utf-8

$DEBUG = false

module Harvest
	def Harvest.find_phrases phrases, text
		text = text.downcase
		phrases.each do |phrase|
			if text.index phrase.downcase
				return true
			end
		end
		false
	end

	def Harvest.phones_from_text text
		text = text + '.'
		text.scan /s*[67]{1}\s*\d\s*\d\s*\d\s*\d\s*\d\s*\d\s*\d\s*\d\s*/
	end

	def Harvest.make_absolute( href, root )
		begin
			uri = URI.parse(href)
			uri = URI.parse(root).merge(uri) if uri.relative?
		rescue => e
			Rails.logger.info e.message
			Rails.logger.info e.backtrace
			return root + href
		end
		uri.to_s
	end

	def getPage(url)
		begin
			url = URI.parse(url)
			found = false
			until found
				host, port = url.host, url.port if url.host && url.port
				req = Net::HTTP::Get.new(url.path)
				res = Net::HTTP.start(url.host, url.port) {|http|  http.request(req) }
				res.header['location'] ? url = URI.parse(res.header['location']) : found = true
			end
		rescue Exception
			puts "Error: #{$!}"
			return ""
		end
		res.body
	end

	def Harvest.je_realitka?(phone)
		agent = Mechanize.new
		page = agent.get "http://www.cislanarealitky.cz/"
		form = page.forms.first
		form['PhoneNumber'] = phone
		page = form.submit
		if not page.body.index('Realitka')
			return false
		else
			return true
		end

	end

	def Harvest.google term
		agent = Mechanize.new
		agent.user_agent_alias = 'Linux Firefox'
		page = agent.get "http://www.google.cz/"
		form = page.forms.first
		form.q = term
		page = form.submit
		results = []
		page.search("li.g").take(3).each do |li|
			ap li
			result = {}
			result[:title] = li.xpath("./h3").text
			result[:content] = li.xpath("./div[@class='s']").text
			results << result
		end
		ap results

	end


	class Stormm

		@@base = "https://www.stormm.cz/"
		@@agent = Mechanize.new
		@@agent.user_agent_alias = 'Linux Firefox'
		@@max_logins = 5
		@@login_attemps = 0
		def self.login
			if not @@login_attemps > @@max_logins
				agent = @@agent
				page = agent.get "https://www.stormm.cz/phone/"
				if form = page.form_with(:id => 'login_form')
					puts 'not logged'
					form.username = 'USERNAME'
					form.password = 'PASSWORD'
					@@login_attemps = @@login_attemps + 1
					form.submit
					login
				else
					puts 'logged'
					@@login_attemps = 0
				end
			else
				raise "large number of logins"
			end
		end
		def self.logout
			agent = @@agent
			page = agent.get "https://www.stormm.cz/auth/logout"
			if form = page.form_with(:id => 'login_form')
				puts "logged out"
			else
				raise 'logging out failed'
			end
		end
		def self.by_phone phone
			login
			agent = @@agent
			page = agent.get "https://www.stormm.cz/phone/"
			form = page.form_with(:id => 'offer3')
			form.f_phone = phone
			page = form.submit
			ads = []
			page.search("//tbody/tr/*/a[contains(@class, 'thickbox')]").each do |node|
				ad = {}
				page = agent.get(Harvest::make_absolute(node['href'], @@base))
				texts = page.search("//div[contains(@class,'history-scroll')]/label[contains(@class, 'history-text')]/strong/text()")
				dates = page.search("//div[contains(@class,'history-scroll')]/label[contains(@class, 'history-date')]/text()")
				adsss = texts.zip dates
				begin
					ad[:status] = page.form.field_with('ph_status').options.select {|o| o.selected?}.first.text
				rescue
					ad[:status] = "neznamy status"
				end
				ad[:history] = adsss.map {|a| {:text => a.first, :date => a.last} }
				ads << ad
			end
			ads

		end

		# prozatim jen cislo
		def self.insert(ad)
			login
			agent = @@agent
			#defaults
			ph_sa_id = ''
			ph_oc_id = 0
			ph_staff_note = ''
			ph_et_id = ''
			ph_status = ''
			phs_o_id = ''
			ph_type = 0 #soukrome cislo
			ph_name = ''
			ph_street = ''
			ph_zip = ''
			ph_city = ''
			ph_notice = ''
			ph_ad_text = ''
			ph_tels1 = ''
			ph_tels2 = ''
			ph_tels3 = ''
			ph_id = 0
			ph_emails1 = ''
			ph_emails2 = ''

			#if (document.getElementById('ph_type1').checked) ph_type = 1;

			ph_oc_id = 10 # 11 je pronajem

			#if (document.getElementById('ph_id')) {
			#ph_id = document.getElementById('ph_id').value;
			#}

			ph_sa_id = '8909' # moje id
			#ph_staff_note = encodeURIComponent(document.getElementById('ph_staff_note').value);
			#ph_et_id = document.getElementById('ph_et_id1').options[document.getElementById('ph_et_id1').selectedIndex].value; typ nemovitosti
			ph_status = '1' # vyrizuje se
			#phs_o_id = encodeURIComponent(document.getElementById('phs_o_id1').value);  cislo nabidky, nezobrazuje se
			#ph_name = encodeURIComponent(document.getElementById('ph_name').value);
			#ph_street = encodeURIComponent(document.getElementById('ph_street').value);
			#ph_zip = document.getElementById('ph_zip').value;
			#ph_city = encodeURIComponent(document.getElementById('ph_city').value);
			#ph_notice = encodeURIComponent(document.getElementById('ph_notice').value);
			#ph_ad_text = encodeURIComponent(document.getElementById('ph_ad_text').value);
			ph_tels1 = ad[:phone].to_s
			#ph_tels2 = encodeURIComponent(document.getElementById('ph_tels2').value);
			#ph_tels3 = encodeURIComponent(document.getElementById('ph_tels3').value);
			#ph_emails1 = encodeURIComponent(document.getElementById('ph_emails1').value);
			#ph_emails2 = encodeURIComponent(document.getElementById('ph_emails2').value);
			response = agent.get("/phone/add/?ph_sa_id=#{ph_sa_id}&ph_et_id=#{ph_et_id}&ph_name=#{ph_name}&ph_type=#{ph_type}&ph_street=#{ph_street}&ph_city=#{ph_city}&ph_zip=#{ph_zip}&ph_tels1=#{ph_tels1}&ph_tels2=#{ph_tels2}&ph_tels3=#{ph_tels3}&ph_emails1=#{ph_emails1}&ph_emails2=#{ph_emails2}&ph_ad_text=#{ph_ad_text}&ph_status=#{ph_status}&ph_notice=#{ph_notice}&ph_id=#{ph_id}&phs_o_id=#{phs_o_id}&ph_oc_id=#{ph_oc_id}&ph_staff_note=#{ph_staff_note}")
			#errors = response.search '.error'
			#if errors.empty?
			return true
			#else
			#return false
			#end


			#page = agent.get "https://www.stormm.cz/phone/"
			#form = page.form_with(:id => 'offer3')
			#form.field_with('f_staff').options.find{|opt| opt.text =~  /\[6147\]/}.select
			#page = form.submit

			#node = page.search("//tbody/tr/*/a[contains(@class, 'thickbox')]").first
			#page = agent.get(make_absolute(node.attributes['href'], @@base))
			#form = page.forms.first
			#form.field_with('ph_status').options.find{|opt| opt.text =~ /\[5434\]/}.select #Frank *T Viktor [5434]
			#form.submit

		end
	end

	def sample_ad
		ad = {}
		ad[:type] = 'Byty 2+kk'
		ad[:phone] = '111111111'
		ad[:text] = 'text'
		ad
	end


	def je_na_googlu?(phone)
		#search = Google::Search::Web.new do |search|
		#search.query = phone
		#search.size  = :small # 4
		#search.each_response { print '.'; $stdout.flush }
		#search.language = :cs
		#end
		#ap search
		#ap search.all

	end


	class AdServer
		attr_reader :list_only, :agent, :urls, :detail_url_path, :base, :description, :debug, :detail_url_procs, :reality_phrases, :phone_paths, :insert
		def initialize
			@list_only = true
			@agent = Mechanize.new
			@agent.user_agent_alias = 'Linux Firefox'
			@debug = false
			@detail_url_procs = []
			@urls = []
			@description = nil
			@reality_phrases = []
			@phone_paths = []
			@insert = false
		end
		def list_only?
			@list_only
		end
		def self.load serverfilename
			a = new
			a.instance_eval(File.read(serverfilename))
			a
		end
		def ad_list
			page = @agent.get @list_url
			if @list_only

			else
				return page.search(@detail_url_path).map{|a| a.attributes['href']}
			end

		end
	end

	class AdFetcher
		def self.update_ads
			logger = Rails.logger
			#logger = Logger.new("#{Rails.root}/log/harvester.log", 2, 10048576)
			Dir.glob(File.join(Rails.root,"extras", "ad_servers", "*.rb")).sort.each do |filename|
				ad_server = AdServer.load(filename)
				debug = ad_server.debug
				agent = ad_server.agent
				unless ad_server.list_only?
					# relative urls
					Rails.logger.info ad_server.base
					relative_urls = []
					#begin
					ad_server.urls.each do |url|

						Rails.logger.info url
						conns = 0
						begin
							if url.class == String
								conns = conns + 1
								page = agent.get url
							else
								conns = conns + 1
								page = agent.post url[0], url[1]
							end
						rescue  Net::HTTPInternalServerError

							Rails.logger.info "retry"
							sleep 5
							retry if conns < 5
						rescue Net::HTTP::Persistent::Error

							Rails.logger.info "retry"
							sleep 5
							retry if conns < 5
						rescue Errno::EWOULDBLOCK
							Rails.logger.info "retry"
							sleep 5
							retry if conns < 5
						rescue Errno::AGAIN
							Rails.logger.info "retry"
							sleep 5
							retry if conns < 5
						rescue IO::WaitWritable
							Rails.logger.info "retry"
							sleep 5
							retry if conns < 5
						rescue Errno::ETIMEDOUT
							Rails.logger.info "retry"
							sleep 5
							retry if conns < 5
						end
						#Rails.logger.info url
						page.search(ad_server.detail_url_path).each do |detail_url|
							relative_urls << detail_url['href']
						end
					end
					#rescue => e
					#logger.info "GENERAL EXCEPTION"
					#logger.info ad.url
					#logger.info e.message
					#logger.info e.backtrace

				end
				ad_server.detail_url_procs.each do |pr|
					relative_urls = relative_urls + ad_server.instance_eval(&pr)
				end
				# convert to absolute urls
				detail_urls = relative_urls.map do |url|
					Harvest::make_absolute(url, ad_server.base)
				end

				detail_urls.each do |detail_url|

					unless Ad.where(:url => detail_url).exists?
						#begin

						ad = Ad.new
						ad.url = detail_url
						Rails.logger.info detail_url
						ad.server = File.basename(filename, File.extname(filename))
						ad.review = false
						dpage = agent.get(ad.url)
						# check phone number
						je_realitka = false
						phone_found = false
						phone = false
						ad_server.phone_paths.each do |path|
							if path.class == String # node selector
								begin
									phones = Harvest::phones_from_text(dpage.search(path).text().strip)
								rescue => e
									logger.info ("URL" + detail_url)
									logger.info ("SEARCH" + path)
									logger.info e.message
									logger.info e.backtrace
								end
								if phones
									if not phones.empty?
										phone = phones.first
									end
								else
									logger.info "blok s telefonem nenalezen"
									logger.info ("URL" + detail_url)
									logger.info ("SEARCH" + path)
									logger.info e.message
									logger.info e.backtrace
								end
							elsif path.class == Proc
								phone = ad_server.instance_eval(&path)
							end
							if phone
								phone_found = true
								if Harvest::je_realitka?(phone)
									je_realitka = true
								end
							end


						end
						ad.text = nil
						if(ad_server.description)
							begin
								ad.text = dpage.search(ad_server.description).text().strip
								unless ad.text
									logger.info ("URL" + detail_url)
									logger.info ("SEARCH" + path)
									logger.info "cannot find text"
								end
							rescue => e
								logger.info ("URL" + detail_url)
								logger.info ("SEARCH" + ad_server.description)
								logger.info e.message
								logger.info e.backtrace
							end
							if ad.text.class == String
								phones = Harvest::phones_from_text(ad.text)
								if phones and not phones.empty?
									phone = phones.first
									phone_found = true
								end
							end
						end
						unless ad.text
							ad.text = "no text"
						end
						if Harvest::find_phrases(ad_server.reality_phrases, ad.text)
							ad.autorejected = true
							ad.reason = "reality phrases"
						end
						unless phone_found
							ad.autorejected = true
							ad.reason = "no phone"
						end
						if je_realitka
							ad.autorejected = true
							ad.reason = "cislo je na realitku"
						end

						if phone_found
							ad.text = ad.text + " PHONE: " + phone
						end
						if debug
							logger.info "URL: #{ad.url}"
							logger.info "Text: #{ad.text}"
							logger.info "Phone: #{phone}"
						else
							ad.save
						end
						if ad_server.insert
							ad.autorejected = false
							ad.save
						end

						#rescue Exception => e
						#logger.info "GENERAL EXCEPTION"
						#logger.info ad.url
						#logger.info e.message
						#logger.info e.backtrace
						#end
					end
				end
			end
		end

	end

	class Harvester
		def initialize
		end
		def getAdverts
			#body = getPage("http://www.annonce.cz/byty-na-prodej.html")
			#doc = Nokogiri::HTML.parse(body)
			#link = doc.css('div.ad-short h2 a').first
			#body = getPage(make_absolute(link.attributes['href'],"http://www.annonce.cz/"))
			body = getPage(make_absolute("detail/k-prodeji-krasny-slunny-15778634-wwkfsm.html","http://www.annonce.cz/"))
			#puts body
			doc = Nokogiri::HTML.parse(body)
			price =  doc.xpath("//tr[th[@class='price']]/td/a/text()").to_s.gsub(/\D/,"")
			phone =  doc.xpath("//div[@class='ad-detail-contact']/p[1]/strong/text()").to_s.gsub(/\D/,"")
			description =  doc.xpath("//div[@class='text ad-free-private']/text()").to_s.strip
			rows = doc.css(".comodity-elements tr")
			details = rows.map do |row|
				excluded_rows = ["Kraj", "Země", "Cena", "Okres", "Vlastnictví", "Typ"]
				excluded_rows.map! { |r| r.gsub(/\W+/,"").downcase.strip }
				detail = {}
				#puts "KK" + row.at_xpath('th/text()').to_s.gsub(/\W+/,"").strip
				if not excluded_rows.include?(row.at_xpath('th/text()').to_s.gsub(/\W+/,"").downcase.strip)
					detail[row.at_xpath('th/text()').to_s.strip] =  row.at_xpath('td/descendant-or-self::node()').text().gsub(/[\n|\r]/,'').strip
				end
				detail
			end
			details.reject! { |d| d == {} }

		end

		def queueLocalLinks(html)
			html.scan(/a uri = URI.parse("#{w}")/)
			if !@visited.has_key?(uri.path) and
				(uri.relative? or uri.host == @site_uri.host)
				addPath(uri.path)
			end
		end
		def crawlSite()
			while (!@queue.empty?)
				uri = @queue.shift
				page = getPage(uri)
				yield uri, page
				queueLocalLinks(page)
				@visited[uri] = true
			end
		end
	end

end
