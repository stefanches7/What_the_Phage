process vog_DB {
  label 'noDocker'    
  if (params.cloudProcess) { 
    publishDir "${params.cloudDatabase}/", mode: 'copy', pattern: "vogdb" 
  }
  else { 
    storeDir "nextflow-autodownload-databases/vog" 
  }  

  output:
  path("vogdb", type: 'dir')
  
  script:
    """
    wget -nH ftp://ftp.ebi.ac.uk/pub/databases/metagenomics/viral-pipeline/hmmer_databases/vogdb.tar.gz && tar -zxvf vogdb.tar.gz
    rm vogdb.tar.gz
    """
}
