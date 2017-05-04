#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'


size = `curl -s -m 5 https://mon.pca.ovh.net/migration-overall-mon.json | egrep -o "(N\/A|[0-9\.]+ TB)"`.chomp()

/(?<terabytes>[0-9\.]+) TB/ =~ size

terabytes = terabytes.to_f()

if terabytes > 300
  color = I3BlockHandler::COLOR_GREEN
elsif terabytes > 200
  color = I3BlockHandler::COLOR_YELLOW
elsif terabytes > 100
  color = I3BlockHandler::COLOR_ORANGE
else
  color = I3BlockHandler::COLOR_RED
end

color = I3BlockHandler::COLOR_RED if size == '"N/A"'

I3BlockHandler.print_json("#{size}", "VVVDDDSTB", color)
