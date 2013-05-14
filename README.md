convert-to-d3
=============

Convert standard JSON into format that D3 library can use

This class converts from standard json into the format to use for the d3 library.
D3 library is included, with an example index.html to call it.

Usage:
convert_obj = ConvertToD3.new(data)  # data can either be ruby hash or raw json data
convert_obj.converted   => Returns formatted json

