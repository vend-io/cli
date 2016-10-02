#!/usr/bin/env ruby
require 'singleton'

class REPL
    include Singleton
    def initialize
        @verbs=[:add, :remove, :change, :new]
        @impl={}
        @usage={:add => "add <item>", :new => "new <id> <name> <price>", :remove => "remove <id>"}
    end
    def implement(verb, meth)
        if not meth.is_a? Method
            return nil
        end
        #require adding to verbs first
        if not @verbs.include? verb
            return nil
        end
        @impl[verb] = meth
    end
    def add_verb(verb)
        if verb.is_a? String
            @verbs.push verb.to_sym
        elsif verb.is_a? Symbol
            @verbs.push verb
        else
            return nil
        end
    end
    def add_usage(verb, str)
        usage[verb] = str
    end
    def evaluate(args)
        #args is an array of strings
        command = args[0].to_sym
        args = args[1..args.length]
        if not @verbs.include? command
            puts "Supported commands:"
            puts @verbs
            return nil
        elsif not args.nil? and not args[0].nil?
            if @verbs.include? args[0].to_sym
                tmp = evaluate(args)
                return if tmp.nil?
                @impl[command].call tmp
            else
                @impl[command].call *args
            end
        else
            @impl[command].call
        end
    end
    def run
        while true
            print "> "
            input = gets.split
            puts evaluate(input)
        end
    end
end


