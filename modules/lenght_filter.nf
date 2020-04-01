process seqkit {
      label 'seqkit'
    input:
      tuple val(name), file(fasta)
    output:
      tuple val(name), file("${name}.fa") optional true
    script:
    """
    seqkit seq -m ${params.filter} ${fasta} > ${name}.fa
    if [ ! -s ${name}.fa  ] ; then 
      rm ${name}.fa
      fi
    """
}