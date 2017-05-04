#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

pids = `pgrep -x pidgin`.split()
message_count = 0

pids.each() do |pid|
  windows = `wmctrl -l -p | grep #{pid} | awk '{print $1}'`.split()
  windows.each() do |window|
    message_count += `xprop -id #{window} | grep _PIDGIN_UNSEEN_COUNT | awk '{print $NF}'`.chomp().to_i()
  end
end

if message_count > 0 then
  color = I3BlockHandler::COLOR_LIGHT_GREEN
end

I3BlockHandler.print_json("#{message_count}", 'VVV', color)
