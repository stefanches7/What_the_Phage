process fastqTofasta {
      label 'seqit'
    input:
      tuple val(name), file(fastq)
    output:
      tuple val(name), file("${name}.fa")
    script:
    """
    
    seqkit seq -m 700 ${fasta} > ${name}.fa

    """