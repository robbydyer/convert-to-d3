convert-to-d3
=============

Convert standard JSON into format that D3 library's (http://d3js.org) Collapsible Tree Layout (https://github.com/mbostock/d3/wiki/Gallery) can use. 

This class converts from standard json into the format to use for the d3 library.
D3 library is included, with an example index.html to call it.

Usage:
```
require 'convert_to_d3'

puts ConvertToD3(my_json).convert  # => Returns D3 formatted JSON

## You can alternatively just pass a ruby hash
puts ConvertToD3(my_hash).convert  # => Returns D3 formatted JSON
```

NOTES:
- Your base json must have one root starting point. Check out demo.json for an example.

    e.g.
```
        {
            "root_start":{


            }
        }
```


TODO:
- Make it sort! Right now the ordering is kind of random
