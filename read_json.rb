#!/usr/bin/ruby
require 'rubygems'
require 'convert_to_d3'

print "Content-type: text/html\n\n"

f = File.open('demo.json','r')
orig_json = f.read
f.close

puts ConvertToD3.convert(orig_json)
