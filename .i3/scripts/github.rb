#!/usr/bin/env ruby

require 'octokit'
require_relative 'lib/i3block_handler'

github_token = ARGV[0]
ctx = I3BlockHandler.refresh_context(__FILE__)
client = Octokit::Client.new(:access_token => github_token)

client.notifications({since: ctx[:old].iso8601()}).each do |notification|
  I3BlockHandler.notify(
    __FILE__,
    notification.repository.full_name,
    "#{notification.subject.title}\ntarget: #{notification.subject.type}\naction: #{notification.reason}",
    event_date: notification.updated_at.to_datetime ,
    context: ctx,
  )
end

unread = `curl -s "https://api.github.com/notifications?access_token=#{ARGV[0]}" | grep -c unread`.to_i

color = (unread > 0 ? I3BlockHandler::COLOR_LIGHT_GREEN : nil)

I3BlockHandler.print_json("#{unread}", 'VVV', color)
