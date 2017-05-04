#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

usage_details = `free -m`.chomp()

/^Mem:\s+(?<max>\d+)/ =~ usage_details
/\-\/\+[^:]+:\s+(?<usage>\d+)/ =~ usage_details

ratio = (100 * usage.to_f()/max.to_f()).to_i()

if ratio > 75
  color = I3BlockHandler::COLOR_RED
elsif ratio > 50
  color = I3BlockHandler::COLOR_ORANGE
elsif ratio > 25
  color = I3BlockHandler::COLOR_YELLOW
else
  color = I3BlockHandler::COLOR_GREEN
end

I3BlockHandler.print_json("#{ratio}%", "SVVVVP", color)
