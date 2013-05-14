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
        key.each do |k|
            new_hash = {}
            if k.is_a?(String)
                new_arr << convert_string(k)
            elsif k.is_a?(Hash)
                ## might be able to get rid of this
                ## I don't think valid JSON allows a    
                ## hash to be contained within an array
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
