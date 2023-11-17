if (!require("pacman")) install.packages("pacman")
pacman::p_load(readxl, dplyr, tidyr)

table <- readxl::read_xlsx(path = "SignatureDB_annotation_012422.xlsx")

gmt_table <- table %>%
  group_by(Signature, `Signature category`) %>%
  summarise("Genes" = paste0(`Gene symbol`, collapse = "-"))

my_file <- file("SignatureDB_annotation_012422.gmt", open = "wa")
for (i in 1:nrow(gmt_table)) {
  sig <- as.character(gmt_table[i,1])
  cat <- as.character(gmt_table[i,2])
  genes <- as.character(gmt_table[i,3]) %>% strsplit(split = "-")
  
  line <- paste(sig, cat, paste0(genes[[1]], collapse = "\t"), sep = "\t")
  
  writeLines(line, con = my_file, sep = "\n")
}
close(my_file)