#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

state = File.read("/sys/class/net/#{ARGV[0]}/operstate").chomp()

if state == "dormant"
  color = I3BlockHandler::COLOR_ORANGE
elsif state == "up"
  details = `iwconfig #{ARGV[0]}`
  ip_details = `ip a s dev #{ARGV[0]}`
  /ESSID:"(?<ssid>[^\"]+)"/ =~ details
  /Link Quality=(?<quality_val>\d+)\/(?<quality_max>\d+)/ =~ details
  /inet (?<ipv4>\d+\.\d+\.\d+\.\d+)/ =~ ip_details
  quality = (100 * quality_val.to_i/quality_max.to_i)

  if quality > 66 then
    color = I3BlockHandler::COLOR_GREEN
  elsif quality > 33 then
    color = I3BlockHandler::COLOR_MID_GREEN
  else
    color = I3BlockHandler::COLOR_DARK_GREEN
  end
else
  color = I3BlockHandler::COLOR_RED
end


info = (state == "up" ? "#{ipv4} (#{ssid}) [#{quality}%]" : state)

I3BlockHandler.print_json("#{info}", 'XXX', color)
