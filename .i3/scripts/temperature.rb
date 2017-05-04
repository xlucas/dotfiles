#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

temperature = File.read("/sys/class/thermal/#{ARGV[0]}/temp").chomp().to_i()
temperature = (temperature.to_f()/1000.0).to_i()

if temperature > 70 then
  color = I3BlockHandler::COLOR_RED
elsif temperature > 60 then
  color = I3BlockHandler::COLOR_ORANGE
elsif temperature > 50 then
  color = I3BlockHandler::COLOR_GREEN
elsif temperature > 40 then
  color = I3BlockHandler::COLOR_BLUE
else
  color = I3BlockHandler::COLOR_LIGHT_BLUE
end

I3BlockHandler.print_json("#{temperature} C", 'XXXPP', color)
