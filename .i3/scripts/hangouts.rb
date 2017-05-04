#!/usr/bin/env ruby

require 'gmail'
require_relative 'lib/i3block_handler'

unread = 0

Gmail.connect(ARGV[0], ARGV[1]) do |gmail|
  if gmail.logged_in? then
    unread = gmail.inbox.count(gm: 'in:chats') || 0
  end
end

color = (unread > 0 ? I3BlockHandler::COLOR_LIGHT_GREEN : nil)

I3BlockHandler.print_json("#{unread}", 'VVV', color)
