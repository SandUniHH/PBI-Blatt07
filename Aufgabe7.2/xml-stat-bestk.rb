#!/usr/bin/env ruby
#
# Bocher Diedrich Sandmeier

require 'rexml/document'
require './priority_queue.rb'

class XmlReader
  include REXML
  def initialize()
    @file = nil
    @xmldoc = nil
    @stats = {
      :leaves => 0,
      :int_nodes => 0,
      :nodes_with_max_children => nil
    }
  end

  def open_xml_file(filename)
    if File.exist?(filename)
      begin
        @file = File.new(filename,"r")
      rescue => err
        STDERR.puts "Could not open file #{filename}: #{err}"
        exit 1
      end
    else
      STDERR.puts "File #{filename} does not exist!"
      exit 1
    end
    @xmldoc = Document.new(@file)
  end

  def close_xml_file()
    @file.close()
  end

  def leaves_intnodes_count()
    get_leaves_and_intnodes(@xmldoc)
    puts "number of leaves: #{@stats[:leaves]}\n"+
    "number of internal nodes: #{@stats[:int_nodes]}"
  end

  def get_leaves_and_intnodes(node) #current node, or root if parameter is a file
    node.elements.each() {|node|
      if !node.elements.empty?
        get_leaves_and_intnodes(node)
        @stats[:int_nodes] += 1
      else
        @stats[:leaves] += 1
      end
    }
  end

  # create a priority queue with k
  def max_children_count(k)
    check_val(k)
    @stats[:nodes_with_max_children] = PriorityQueue.new(k)
    get_max_children(@xmldoc,k)
    puts "the text of the #{k} most branching nodes, with its number of children:"
    @stats[:nodes_with_max_children].each() {|count,ele| puts "#{count}\t#{ele}"}
  end

  # why count again, counting possible together with get_leaves_and_intnodes?
  def get_max_children(node,k)
    counter = 0
    node.elements.each() {|node|
      get_max_children(node,k)
      counter +=1
    }
    @stats[:nodes_with_max_children].add(counter,node.text.strip()) {|a,b| a<b }
  end

  def check_val(val)
    if val.to_i() < 1
      STDERR.puts "#{val} has to be >= 1!"
      exit 1
    end
  end

  private :check_val, :get_leaves_and_intnodes, :get_max_children

end

##########

if ARGV.length != 2
  STDERR.puts "Usage : #{$0} filename k"
  exit 0
end

filename = ARGV[0]
k = ARGV[1].to_i()

xs = XmlReader.new()
xs.open_xml_file(filename)

# 7.2.1: recursively count the nodes and leaves
xs.leaves_intnodes_count()

# 7.2.2: recursively count the children of each node, output of the k most branching
xs.max_children_count(k)

xs.close_xml_file()