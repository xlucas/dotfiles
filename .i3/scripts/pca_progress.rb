#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

json = `curl -s https://mon.pca.ovh.net/migration-#{ARGV[0]}-global-mon.json | sed 's/},/}\\n/g' | grep Total`.chomp()

/"value":(?<progress>\d+\.\d+)/ =~ json

progress = progress.to_f()

if progress > 75
  color = I3BlockHandler::COLOR_GREEN
elsif progress > 50
  color = I3BlockHandler::COLOR_YELLOW
elsif progress > 25
  color = I3BlockHandler::COLOR_ORANGE
else
  color = I3BlockHandler::COLOR_RED
end

I3BlockHandler.print_json("#{progress}%", "VVVP", color)
