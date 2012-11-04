#!/usr/bin/env ruby1.9.1

require 'csv'
require 'set'
require 'yaml'

noChoiceNodes = {}
goodNodes = Set.new
badNodes = Set.new

def wrap(s)
    return '' unless s
    r = ''
    count = 0
    s.each_char do |c|
        if c == ' ' and count > 6
            r += "\\n  "
            count = 0
        else
            r += c
        end
        count += 1
    end
    return '  ' + r
end

puts "digraph map {"
puts "node [shape = circle, fixedsize = true, width = 0.7, height = 0.7, style = filled, fillcolor = \"#f6e97f\"];"

File::open($ARGV.first, 'r') do |f|
    f.each_line do |line|
        lineArray = line.parse_csv()
        from = lineArray[0].to_i
        to = lineArray[1].to_i
        if to > 0
            puts "#{from} -> #{to} [label=\"#{wrap(lineArray[2])}\"];"
            noChoiceNodes[from] ||= []
            noChoiceNodes[from] << to
        else
            goodNodes << from if lineArray[1] == 'good'
            badNodes << from if lineArray[1] == 'bad'
        end
    end
end

noChoiceNodes = Set.new(noChoiceNodes.reject { |x, y| y.size > 1 }.keys)

goodNodes.each do |x|
    puts "#{x} [style=filled, fillcolor = \"#b9e88a\"];"
end
badNodes.each do |x|
    puts "#{x} [style=filled, fillcolor = \"#e57f7f\"];"
end
noChoiceNodes.each do |x|
    puts "#{x} [style=filled, fillcolor = \"#f8f8f8\"];"
end

puts "}"
