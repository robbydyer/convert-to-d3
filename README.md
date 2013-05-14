convert-to-d3
=============

Convert standard JSON into format that D3 library can use

This class converts from standard json into the format to use for the d3 library.
D3 library is included, with an example index.html to call it.

Usage:
```
convert_obj = ConvertToD3.new(data)  ## data can either be ruby hash or raw json data
convert_obj.converted  ## => Returns formatted json
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

D3 Library: http://d3js.org/


TODO:
- Make it sort! Right now the ordering is kind of random
