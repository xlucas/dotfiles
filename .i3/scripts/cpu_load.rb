#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

ratio = 100 - `mpstat 1 1 2>&1 | awk '{print $NF}' | tail -1`.chomp().to_i()

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
