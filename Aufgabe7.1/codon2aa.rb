#
# codon2aa
#
# A function to translate a DNA 3-character codon to an amino acid
#   Version 3, using hash lookup

def codon2aa(codon,transnum = 1)
  codon = codon.upcase
  if transnum == 1
    return codon2aa_1(codon)
  elsif transnum == 11
    return codon2aa_11(codon)
  else
    STDERR.puts "codon2aa: no translation table for transnum #{transnum}"
    exit 1
  end
end

def codon2aa_1(codon)
    genetic_code = {
    'TCA' => 'S',    # Serine
    'TCC' => 'S',    # Serine
    'TCG' => 'S',    # Serine
    'TCT' => 'S',    # Serine
    'TTC' => 'F',    # Phenylalanine
    'TTT' => 'F',    # Phenylalanine
    'TTA' => 'L',    # Leucine
    'TTG' => 'L',    # Leucine
    'TAC' => 'Y',    # Tyrosine
    'TAT' => 'Y',    # Tyrosine
    'TAA' => '*',    # Stop
    'TAG' => '*',    # Stop
    'TGC' => 'C',    # Cysteine
    'TGT' => 'C',    # Cysteine
    'TGA' => '*',    # Stop
    'TGG' => 'W',    # Tryptophan
    'CTA' => 'L',    # Leucine
    'CTC' => 'L',    # Leucine
    'CTG' => 'L',    # Leucine
    'CTT' => 'L',    # Leucine
    'CCA' => 'P',    # Proline
    'CCC' => 'P',    # Proline
    'CCG' => 'P',    # Proline
    'CCT' => 'P',    # Proline
    'CAC' => 'H',    # Histidine
    'CAT' => 'H',    # Histidine
    'CAA' => 'Q',    # Glutamine
    'CAG' => 'Q',    # Glutamine
    'CGA' => 'R',    # Arginine
    'CGC' => 'R',    # Arginine
    'CGG' => 'R',    # Arginine
    'CGT' => 'R',    # Arginine
    'ATA' => 'I',    # Isoleucine
    'ATC' => 'I',    # Isoleucine
    'ATT' => 'I',    # Isoleucine
    'ATG' => 'M',    # Methionine
    'ACA' => 'T',    # Threonine
    'ACC' => 'T',    # Threonine
    'ACG' => 'T',    # Threonine
    'ACT' => 'T',    # Threonine
    'AAC' => 'N',    # Asparagine
    'AAT' => 'N',    # Asparagine
    'AAA' => 'K',    # Lysine
    'AAG' => 'K',    # Lysine
    'AGC' => 'S',    # Serine
    'AGT' => 'S',    # Serine
    'AGA' => 'R',    # Arginine
    'AGG' => 'R',    # Arginine
    'GTA' => 'V',    # Valine
    'GTC' => 'V',    # Valine
    'GTG' => 'V',    # Valine
    'GTT' => 'V',    # Valine
    'GCA' => 'A',    # Alanine
    'GCC' => 'A',    # Alanine
    'GCG' => 'A',    # Alanine
    'GCT' => 'A',    # Alanine
    'GAC' => 'D',    # Aspartic Acid
    'GAT' => 'D',    # Aspartic Acid
    'GAA' => 'E',    # Glutamic Acid
    'GAG' => 'E',    # Glutamic Acid
    'GGA' => 'G',    # Glycine
    'GGC' => 'G',    # Glycine
    'GGG' => 'G',    # Glycine
    'GGT' => 'G',    # Glycine
    }

    if genetic_code.has_key?(codon) then
        return genetic_code[codon]
    else
        STDERR.print "Bad codon \"#{codon}\"!!\n"
        exit 1
    end
end

def codon2aa_11(codon)
    genetic_code = {
    'TTT' => 'F',
    'TTC' => 'F',
    'TTA' => 'L',
    'TTG' => 'L',
    'TCT' => 'S',
    'TCC' => 'S',
    'TCA' => 'S',
    'TCG' => 'S',
    'TAT' => 'Y',
    'TAC' => 'Y',
    'TAA' => '*',
    'TAG' => '*',
    'TGT' => 'C',
    'TGC' => 'C',
    'TGA' => '*',
    'TGG' => 'W',
    'CTT' => 'L',
    'CTC' => 'L',
    'CTA' => 'L',
    'CTG' => 'L',
    'CCT' => 'P',
    'CCC' => 'P',
    'CCA' => 'P',
    'CCG' => 'P',
    'CAT' => 'H',
    'CAC' => 'H',
    'CAA' => 'Q',
    'CAG' => 'Q',
    'CGT' => 'R',
    'CGC' => 'R',
    'CGA' => 'R',
    'CGG' => 'R',
    'ATT' => 'I',
    'ATC' => 'I',
    'ATA' => 'I',
    'ATG' => 'M',
    'ACT' => 'T',
    'ACC' => 'T',
    'ACA' => 'T',
    'ACG' => 'T',
    'AAT' => 'N',
    'AAC' => 'N',
    'AAA' => 'K',
    'AAG' => 'K',
    'AGT' => 'S',
    'AGC' => 'S',
    'AGA' => 'R',
    'AGG' => 'R',
    'GTT' => 'V',
    'GTC' => 'V',
    'GTA' => 'V',
    'GTG' => 'V',
    'GCT' => 'A',
    'GCC' => 'A',
    'GCA' => 'A',
    'GCG' => 'A',
    'GAT' => 'D',
    'GAC' => 'D',
    'GAA' => 'E',
    'GAG' => 'E',
    'GGT' => 'G',
    'GGC' => 'G',
    'GGA' => 'G',
    'GGG' => 'G',
    }
    if genetic_code.has_key?(codon)
        return genetic_code[codon]
    else
        raise "Bad codon \"#{codon}\"!!\n"
    end
end
