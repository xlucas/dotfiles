#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

current = `euro2016 schedule status IN_PLAY | grep -m1 IN_PLAY | awk '{print $4" "$6" - "$8" "$10}'`.chomp()

color = I3BlockHandler::COLOR_GREEN

I3BlockHandler.print_json("#{current}", 'V', color)
