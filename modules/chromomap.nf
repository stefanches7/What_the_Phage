process chromomap {
      publishDir "${params.output}/${name}/chromomap", mode: 'copy', pattern: "sample_overview.html"
      label 'chromomap'
      errorStrategy 'retry'
      maxRetries 4
    input:
      tuple val(name), path(chromosome), path(annotation)
    output:
      tuple val(name), path("sample_overview.html")
    script:
      if (task.attempt.toString() == '1')
      """
      #!/usr/bin/env Rscript
      library(chromoMap)
      library(ggplot2)
      library(plotly)
      input <- read.delim("${chromosome}", sep = '\t', header = FALSE)
      sizeh <- ( nrow(input) * 80 )
      p <-  chromoMap("${chromosome}","${annotation}",
            data_based_color_map = T,
            data_type = "categorical",
            segment_annotation = T,
            data_colors = list(c("red", "lightblue", "orange", "green")),
            labels=T,
            left_margin = 340, canvas_width = 1500, canvas_height = sizeh, chr_length = 12, ch_gap = 6)
      htmlwidgets::saveWidget(as_widget(p), "sample_overview.html")
      """

    else if (task.attempt.toString() == '2')
      """
      #!/usr/bin/env Rscript
      library(chromoMap)
      library(ggplot2)
      library(plotly)
      input <- read.delim("${chromosome}", sep = '\t', header = FALSE)
      sizeh <- ( nrow(input) * 80 )
      p <-  chromoMap("${chromosome}","${annotation}",
            data_based_color_map = T,
            data_type = "categorical",
            segment_annotation = T,
            data_colors = list(c("lightblue", "orange", "red")),
            labels=T,
            left_margin = 340, canvas_width = 1500, canvas_height = sizeh, chr_length = 12, ch_gap = 6)
      htmlwidgets::saveWidget(as_widget(p), "sample_overview.html")
      """
    else if (task.attempt.toString() == '3')
      """
      #!/usr/bin/env Rscript
      library(chromoMap)
      library(ggplot2)
      library(plotly)
      input <- read.delim("${chromosome}", sep = '\t', header = FALSE)
      sizeh <- ( nrow(input) * 80 )
      p <-  chromoMap("${chromosome}","${annotation}",
            data_based_color_map = T,
            data_type = "categorical",
            segment_annotation = T, 
            data_colors = list(c("lightblue", "orange")),
            labels=T,
            left_margin = 340, canvas_width = 1500, canvas_height = sizeh, chr_length = 12, ch_gap = 6)
      htmlwidgets::saveWidget(as_widget(p), "sample_overview.html")
      """
    else if (task.attempt.toString() == '4')
      """
      #!/usr/bin/env Rscript
      library(chromoMap)
      library(ggplot2)
      library(plotly)
      input <- read.delim("${chromosome}", sep = '\t', header = FALSE)
      sizeh <- ( nrow(input) * 80 )
      p <-  chromoMap("${chromosome}","${annotation}",
            data_type = "categorical",
            segment_annotation = T,
            labels=F,
            anno_col = c("lightblue"),
            left_margin = 340, canvas_width = 1400, canvas_height = sizeh, chr_length = 8, ch_gap = 6)
      htmlwidgets::saveWidget(as_widget(p), "sample_overview.html")
      """
    else if (task.attempt.toString() == '5')
      """
      echo "nothing found" > sample_overview.html
      """
}
