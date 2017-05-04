#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

time = `date "+%d-%m-%Y %H:%M:%S"`.chomp()

I3BlockHandler.print_json(time, '00-00-1970 00:00:00')
