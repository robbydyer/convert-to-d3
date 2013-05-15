#!/usr/bin/ruby

## This class converts from standard json into the format to use for the d3 library.
## Usage:
## convert_obj = ConvertToD3.new(data)  # data can either be ruby hash or raw json data
## convert_obj.converted   => Returns formatted json

require 'rubygems'
require 'json'

class ConvertToD3

    def initialize(d)
        d = JSON.parse(d) if d.is_a?(String)
        raise TypeError, "Your input to ConvertToD3.new(input) should be of type Hash" if !d.is_a?(Hash)
        @dat = d
        @new_dat = {}
        @new_dat[:name] = "START"
        @new_dat[:children] = []

        convert
    end

    def converted
        JSON.pretty_generate(@new_dat)
    end

    def convert_hash(name,this_hash)
        big_hash = {} 
        big_hash[:name] = name
        big_hash[:children] = []

        this_hash.keys.each do |this_key|
            if this_hash[this_key].is_a?(Hash)
                big_hash[:children] << convert_hash(this_key.to_s,this_hash[this_key])
            else ##Array or String type
                new_hash = {}
                new_hash[:name] = this_key.to_s
                new_hash[:children] = []
                new_hash[:children] = convert_array(this_hash[this_key]) if this_hash[this_key].is_a?(Array)
                new_hash[:children] << convert_string(this_hash[this_key]) if this_hash[this_key].is_a?(String)
                big_hash[:children] << new_hash
            end
        end
        big_hash
    end

    def convert_string(str)
        new_hash = {}
        new_hash[:name] = str
        new_hash
    end

    def convert_array(key)
        new_arr = []
        name_count = 0
        key.each do |k|
            new_hash = {}
            if k.is_a?(String)
                new_arr << convert_string(k)

            ## The only valid hash that can be contained within 
            ## a JSON array is a nameless one. We have to make one up.
            elsif k.is_a?(Hash)
                name = "NONAME#{name_count}"
                new_arr << convert_hash(name,k)
                name_count += 1

            ## Here we have an embedded array within array
            ## This is tricky. We need to create a dummy hash
            ## with each value of the array
            elsif k.is_a?(Array)
                count = 0
                hash_array = {}
                k.each do |this_k|
                    if this_k.is_a?(String)
                        hash_array[this_k] = nil # This is so it does not create a child of this string
                    else
                        ## Since arrays or hashes that are the direct child of an
                        ## array cannot have a name, we have to give it one. 
                        name = "NONAME#{count}"
                        hash_array[name] = this_k
                        count += 1
                    end
                end
                name = "NONAME#{name_count}"
                new_arr << convert_hash(name,hash_array)
                name_count += 1
            end

        end
        new_arr
    end

    def convert
       # top level is hash
        @dat.keys.each do |key|
            new_hash = {}
            new_hash[:name] = key.to_s
            if @dat[key].is_a?(Array)
                new_hash[:children] = []
                new_hash[:children] = convert_array(@dat[key])
                @new_dat[:children] << new_hash
            elsif @dat[key].is_a?(Hash)
                @new_dat = convert_hash(key.to_s,@dat[key])
            end
        
        end 
    end


end #end class
