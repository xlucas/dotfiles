#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

capacity = File.read("/sys/class/power_supply/#{ARGV[0]}/capacity").chomp().to_i
charging = File.read("/sys/class/power_supply/AC/online").chomp().to_i

base_icon = "\xef\x89"

if capacity > 75 then
  offset, color = "\x80", I3BlockHandler::COLOR_GREEN
elsif capacity > 50 then
  offset, color = "\x81", I3BlockHandler::COLOR_YELLOW
elsif capacity > 25 then
  offset, color = "\x82", I3BlockHandler::COLOR_ORANGE
else
  offset, color = "\x83", I3BlockHandler::COLOR_RED
end

icon = (charging == 0 ? "#{base_icon}#{offset}" : "\xef\x87\xa6")

I3BlockHandler.print_json("#{icon} #{capacity}%", 'SSVVVP', color)
