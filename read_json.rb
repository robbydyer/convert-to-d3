#!/usr/bin/ruby
require 'rubygems'
require 'convert_to_d3'

print "Content-type: text/html\n\n"

f = File.open('demo.json','r')
orig_json = f.read
f.close
conv_obj = ConvertToD3.new(orig_json)

puts conv_obj.converted
