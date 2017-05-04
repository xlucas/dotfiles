#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

state = File.read("/sys/class/net/#{ARGV[0]}/operstate").chomp()

if state == "up"
  ip_details = `ip a s dev #{ARGV[0]}`
  /inet (?<ipv4>\d+\.\d+\.\d+\.\d+)/ =~ ip_details
  color = I3BlockHandler::COLOR_GREEN
else
  color = I3BlockHandler::COLOR_RED
end


info = (state == "up" ? "#{ipv4}" : state)

I3BlockHandler.print_json("#{info}", 'XXX', color)
