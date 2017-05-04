#!/usr/bin/env ruby

# encoding: utf-8

require 'date'
require_relative 'lib/i3block_handler'

ctx = I3BlockHandler.refresh_context(__FILE__)

filter = ctx[:old].strftime("%Y-%m-%d %H")

keywords = [
  "bad",
  "badminton",
  "bonjour",
  "hello",
  "manger",
  "ping",
  "plop",
  "pong",
  "salut",
  "scuzi",
  "sport",
  "wearesports",
]

data = `egrep -Rh "#{keywords.join('|')}" /home/xlucas/.purple/logs/jabber/xavier.lucas@jabber.ovh.net/ | fgrep "#{filter}"`
data.each_line do |message|
  /.*>\((?<date>[^)]+)\)<\/font>.*/ =~ message
  /.*<b>(?<sender>[^:]+):<\/b>.*/ =~ message
  /:<\/b><\/font> (?<raw_body>.*)$/ =~ message
  body = raw_body.gsub!(/<\/?[^>]*>/, "")
  I3BlockHandler.notify(
    __FILE__,
    "from #{sender}",
    body,
    urgency: 'critical',
    event_date: DateTime.parse(date) - (1.0/24),
    context: ctx
  )
end
