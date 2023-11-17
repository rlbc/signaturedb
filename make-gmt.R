if (!require("pacman")) install.packages("pacman")
pacman::p_load(readxl, dplyr, tidyr)

table <- readxl::read_xlsx(path = "SignatureDB_annotation_012422.xlsx")

gmt_table <- table %>%
  group_by(Signature, `Signature category`) %>%
  summarise("n_genes" = n(),
            "Genes" = paste0(`Gene symbol`, collapse = "-")) %>%
  separate_wider_delim(Genes, delim = "-",
                       names = as.character(1:max(.$n_genes)),
                       too_few = "align_start",
                       too_many = "merge") %>%
  select(-n_genes)

write.table(x = gmt_table,
            file = "SignatureDB_annotation_012422.gmt",
            quote = FALSE,
            sep = "\t",
            na = "",
            row.names = FALSE,
            col.names = FALSE)
