process filter_virfinder {
      publishDir "${params.output}/${name}/virfinder", mode: 'copy', pattern: "virfinder_*.txt"
      label 'ubuntu'
    input:
      tuple val(name), file(results) 
    output:
      tuple val(name), file("virfinder_*.txt")
    script:
      """
      rnd=${Math.random()}
      #cat *.list | sed '1d'| sort  -k5,5 | awk '\$4>=0.9' | awk '{ print \$2 }' > virfinder_\${rnd//0.}.txt

      # filter for virify comparison
      cat *.list | sed '1d' | sort -k5,5 | awk '\$4>=0.9' | awk '\$5<0.05' | awk '{ print \$2 }' > virfinder_\${rnd//0.}.txt

      """
}


/*
VirFinder reported p < 0.05 and 0.7<=score<0.9, and that VirSorter reported as category 3

low confidence viral contigs are those for which VirFinder reported p < 0.05 and score >= 0.9, or those for which VirFinder reported p < 0.05 and 0.7<=score<0.9, and that VirSorter reported as category 3. 

*/