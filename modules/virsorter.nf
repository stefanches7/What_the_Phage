process virsorter {
      publishDir "${params.output}/${name}", mode: 'copy', pattern: "virsorter"
      label 'virsorter'
    input:
      tuple val(name), file(fasta) 
      file(database) 
    output:
      tuple val(name), file("virsorter_*.list"), file("virsorter")
    script:
      """
      rnd=${Math.random()}
      wrapper_phage_contigs_sorter_iPlant.pl -f ${fasta} -db 1 --wdir virsorter --ncpu 8 --data-dir ${database}
      
      # original WtP filtering
      #cat virsorter/Predicted_viral_sequences/VIRSorter_cat-[1,2].fasta | grep ">" | sed -e s/\\>VIRSorter_//g | sed -e s/-cat_1//g |  sed -e s/-cat_2//g | sed -e s/-circular//g > virsorter_\${rnd//0.}.list

      # filtering for Virify comparison by addying prophages
      cat virsorter/Predicted_viral_sequences/VIRSorter_cat-[1,2].fasta virsorter/Predicted_viral_sequences/VIRSorter_prophages_cat-[4,5].fasta | grep ">" | sed -e s/\\>VIRSorter_//g | sed -e s/-cat_1//g |  sed -e s/-cat_2//g | sed -e s/-circular//g > virsorter_\${rnd//0.}.list
      """
}

/*
virsorter categories 1 and 2; 
VirFinder reported p < 0.05 and 0.7<=score<0.9, and that VirSorter reported as category 3
Putative prophages are prophages reported by Virsorter in categories 4 and 5

low confidence viral contigs are those for which VirFinder reported p < 0.05 and score >= 0.9, or those for which VirFinder reported p < 0.05 and 0.7<=score<0.9, and that VirSorter reported as category 3. 

*/