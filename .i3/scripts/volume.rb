#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

mixer_details= `amixer -c #{ARGV[0]} sget "#{ARGV[1]}"`

/(?<volume>\d+)%/ =~ mixer_details
/\[(?<mute>(on|off))\]/ =~ mixer_details

base_icon = "\xef\x80"

volume = volume.to_i()
mute = (mute == "on")

if mute && volume > 0 then
  if volume > 50 then
    icon_offset, color = "\xa8", I3BlockHandler::COLOR_PURPLE
  else
    icon_offset, color = "\xa7", I3BlockHandler::COLOR_PINK
  end
else
  icon_offset, color = "\xa6", I3BlockHandler::COLOR_RED
end

volume = (mute == true ? "#{volume}%" : "MUTE")


I3BlockHandler.print_json("#{base_icon}#{icon_offset}  #{volume}", 'XXSVVVP', color)
