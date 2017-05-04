#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

failures = `curl -s https://mon.pca.ovh.net/mon.json | egrep -o '"oco":"(3[0-9]+|4[0-9]+|5[0-9]+)"' | wc -l`.to_i()

if failures > 2
  color = I3BlockHandler::COLOR_RED
elsif failures > 0
  color = I3BlockHandler::COLOR_ORANGE
else
  color = I3BlockHandler::COLOR_GREEN
end

I3BlockHandler.print_json("#{failures}", "VV", color)
