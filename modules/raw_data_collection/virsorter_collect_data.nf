process virsorter_collect_data {
      publishDir "${params.output}/${name}/raw_data", mode: 'copy', pattern: "virsorter_results_${name}.tar.gz"
      label 'ubuntu'
    input:
      tuple val(name), file(tar_files)
    output:
      tuple val(name), file("virsorter_results_${name}.tar.gz")
    script:
      """
      mkdir -p virsorter
      cp ${tar_files} virsorter
      tar -czf virsorter_results_${name}.tar.gz virsorter
      """
}
