#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

fan_speed = `grep -m1 speed /proc/acpi/ibm/fan | awk '{print $NF}'`.chomp().to_i()

if fan_speed > 3000 then
  color = I3BlockHandler::COLOR_RED
elsif fan_speed > 2000 then
  color = I3BlockHandler::COLOR_ORANGE
elsif fan_speed > 1000 then
  color = I3BlockHandler::COLOR_YELLOW
else
  color = I3BlockHandler::COLOR_GREEN
end

I3BlockHandler.print_json("#{fan_speed} RPM", 'XXXSUUU', color)
