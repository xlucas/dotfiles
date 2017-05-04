#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

ms = `ping -I #{ARGV[0]} -c 1 -W #{ARGV[2]} #{ARGV[1]} | egrep -o 'time=[0-9\.]+ ms' `.chomp()

/(?<ping>[\d\.]+)/ =~ ms

ping = ping.to_f()

if ping > 200 then
  color = I3BlockHandler::COLOR_RED
  I#3BlockHandler.notify(__FILE__, "Very high", "#{ping} ms", display_time: 5, urgency: 'critical')
elsif ping > 100 then
  color = I3BlockHandler::COLOR_ORANGE
  #I3BlockHandler.notify(__FILE__, "High", "#{ping}", display_time: 5, urgency: 'normal')
elsif ping > 50 then
  color = I3BlockHandler::COLOR_YELLOW
else
  color = I3BlockHandler::COLOR_GREEN
end

I3BlockHandler.print_json("#{ping} ms", 'XXXDXSUU', color)
