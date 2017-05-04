#!/usr/bin/env ruby

require_relative 'lib/i3block_handler'

key_count = `ssh-add -l | grep -v 'no identities' | wc -l`.chomp().to_i()

I3BlockHandler.print_json("#{key_count}", 'VV')
