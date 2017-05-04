#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

if ARGV[1] == "tx" then
  column = "$6"
elsif ARGV[1] == "rx" then
  column = "$5"
end

kb = `sar -n DEV 1 1 | grep #{ARGV[0]} | tail -1 | awk '{print #{column}}'`.chomp().to_f()

mb = ((kb * 8 * 2**10)/(10**6)).round(2)

if mb > 40 then
  color = I3BlockHandler::COLOR_RED
  I3BlockHandler.notify(__FILE__, "Very high", "#{mb} Mb/s", display_time: 5, urgency: 'critical')
elsif mb > 25 then
  color = I3BlockHandler::COLOR_ORANGE
  I3BlockHandler.notify(__FILE__, "High", "#{mb} Mb/s", display_time: 5, urgency: 'normal')
elsif mb > 15 then
  color = I3BlockHandler::COLOR_YELLOW
else
  color = I3BlockHandler::COLOR_GREEN
end

I3BlockHandler.print_json("#{mb} Mb/s", 'XXDXXSPPPP', color)
