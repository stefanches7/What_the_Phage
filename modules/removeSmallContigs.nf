process removeSmallContigs {
    label 'bioruby'
  input:
    tuple val(name), file(contigs) 
  output:
	  tuple val(name), file("${name}_filtered.fasta") 
  script:
    """
    #!/usr/bin/env ruby

    require 'bio'

    out = File.open("${name}_filtered.fasta", 'w')

    Bio::FastaFormat.open("${contigs}").each do |entry|
      seq = entry.seq.chomp
      id = entry.definition.chomp
      out << ">#{id}\\n#{seq}\\n" if seq.length > 500
    end
    out.close
    """
}

