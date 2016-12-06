#!/usr/bin/env ruby
#
# Bocher Diedrich Sandmeier

require_relative "./fastaIterator.rb"
require_relative "./codon2aa.rb"
require_relative "./dna2aa.rb"

def get_reverse_complement(seq)
  reverse_complement = ""
  seq.reverse().each_char() {|base|
    reverse_complement += case base
    when "a"
      then "t"
    when "t"
      then "a"
    when "c"
      then "g"
    when "g"
      then "c"
    end
  }
  return reverse_complement
end

def get_max_orf(seq)
  list = []

  # non-greedy match, write that into list, then continue matching
  # from last starting position +3 until the end
  while match = seq.match(/(atg)([atgc]{3}*?)(taa|tag|tga)/)
    list << match[0]
    seq = seq.slice(match.begin(0)+3..-1)
  end
  max = list.max_by() {|ele| ele.length()}
  return max
end

def print_sequence(seq)
  pos = 0
  linelength = 70
  while pos < seq.length() do
    puts seq[pos..pos+linelength-1]
    pos += linelength
  end
end

def orf_printer(argv)
  fi = FastaIterator.new(argv)
  fi.each() {|header,seq1|
    seq2 = get_reverse_complement(seq1)
    max_dna_orf1 = get_max_orf(seq1)
    max_dna_orf2 = get_max_orf(seq2)
    max_dna_orf = (max_dna_orf1.length() > max_dna_orf2.length()) ? max_dna_orf1 : max_dna_orf2
    max_prot_orf = dna2peptide(max_dna_orf)
    puts ">#{header} with orf of length #{max_dna_orf.length()}: translation"
    print_sequence(max_prot_orf)
  }
end

##########

if ARGV.length != 1
  STDERR.puts "Usage : #{$0} <fasta file>"
  exit 0
end

orf_printer(ARGV[0])