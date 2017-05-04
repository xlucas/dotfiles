#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

ip = `curl -s -m #{ARGV[1]} "http://#{ARGV[0]}"`.chomp()
ip = 'N/A' if ip == ""

color = (ip == 'N/A' ? I3BlockHandler::COLOR_RED : I3BlockHandler::COLOR_CYAN)

I3BlockHandler.print_json("#{ip}", 'NNN', color)
