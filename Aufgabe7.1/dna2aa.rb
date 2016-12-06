#!/usr/bin/env ruby

require './codon2aa.rb'

#lst{dnatopeptide}
def dna2peptide(seq)
  peptide = String.new()
  seq.scan(/([ACGT]{3})/i) do |m|
    peptide += codon2aa(m[0])
  end
  return peptide
end
#lstend#

if __FILE__ == $0
require_relative 'fasta_next'
  if ARGV.length != 1
    STDERR.puts "Usage: #{$0} <dnasequence>"
    exit 1
  end

  filename = ARGV[0]
  
  fasta_next(filename) do |header,seq|
    peptide = dna2peptide(seq)
    puts ">translation of #{header}"
    print_sequence(peptide,70)
  end
end
