#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

count = `curl -s https://mon.pca.ovh.net/migration-overall-mon.json | egrep -o '"files":("N/A"|[0-9]+)' | tr -d '"'`.chomp()

/(?<files>(N\/A|[0-9]+))/ =~ count

files = files.to_i()

files = (files.to_f()/1000000.to_f()).to_i()

if files > 400
  color = I3BlockHandler::COLOR_GREEN
elsif files > 200
  color = I3BlockHandler::COLOR_YELLOW
elsif files > 100
  color = I3BlockHandler::COLOR_ORANGE
else
  color = I3BlockHandler::COLOR_RED
end

color = I3BlockHandler::COLOR_RED if files == 'N/A'

I3BlockHandler.print_json("#{files} M", "VVV", color)
