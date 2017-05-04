#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

usage = `df -Th #{ARGV[0]} | awk '{print $6}'`.chomp()

/(?<ratio>\d+)%/ =~ usage

ratio = ratio.to_i()

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
