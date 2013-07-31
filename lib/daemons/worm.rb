#!/usr/bin/env ruby

# You might want to change this
ENV["RAILS_ENV"] ||= "development"

$SLEEP_SECONDS = 30

require File.dirname(__FILE__) + "/../../config/application"
Rails.application.require_environment!

$running = true
Signal.trap("TERM") do
	Rails.logger.info "TERM caught"
  $running = false
end
count  = 0
im = Jabber::Simple.new("USERNAME", "PASSWORD")
Rails.logger.info "Worm started"
while($running) do

Harvest::AdFetcher.update_ads
count = Ad.where(:review => false, :autorejected => false).count
if count > 0
	#system("notify-send", "#{count} pendings")
	# jabber message
	im.deliver 'david.hrachovy@gmail.com', "#{count} pendings"
end

  # Replace this with your code
  Rails.logger.info "Worm finished fetching at #{Time.now}. Going to sleep for #{$SLEEP_SECONDS} sec.\n"
	sleep $SLEEP_SECONDS
end

