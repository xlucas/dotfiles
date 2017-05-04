#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

current = File.read("/sys/class/backlight/#{ARGV[0]}/actual_brightness").chomp().to_i
max = File.read("/sys/class/backlight/#{ARGV[0]}/max_brightness").chomp().to_i

ratio = (100 * current.to_f/max.to_f).to_i

I3BlockHandler.print_json("#{ratio}%", 'VVVP')
