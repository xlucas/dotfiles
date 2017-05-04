#!/usr/bin/env ruby

require 'date'
require 'gmail'
require 'mail'
require_relative 'lib/i3block_handler'

ctx = I3BlockHandler.refresh_context(__FILE__)

email, client_id, client_secret, refresh_token = ARGV

unread = 0
access_token=`oauth2 --user=#{email} --client_id="#{client_id}" --client_secret="#{client_secret}" --refresh_token="#{refresh_token}" | grep -m1 -i access | awk '{print $NF}'`

Gmail.connect(:xoauth2, "#{email}", access_token) do |gmail|
  if gmail.logged_in? then
    unread = gmail.inbox.count(:unread) || 0
  end
  if unread > 0
    emails = gmail.inbox.emails(:unread)
    emails.each do |message|
      message_date = DateTime.parse(message.date)
      from = message.from[0].name || message.from[0].mailbox
      I3BlockHandler.notify(
        __FILE__,
        Mail::Encodings.value_decode(from),
        Mail::Encodings.value_decode(message.subject),
        event_date: message_date,
        context: ctx
      )
    end
  end
end

color = (unread > 0 ? I3BlockHandler::COLOR_LIGHT_GREEN : nil)

I3BlockHandler.print_json("#{unread}", 'VVV', color)
