
suppressMessages(library("plyr", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("data.table", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("crayon", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("withr", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("ggplot2", lib.loc = "/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("farver", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("labeling", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("optparse", lib.loc = "/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("dplyr", lib.loc = "/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("withr", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("backports", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("broom", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("rstudioapi", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("cli", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("tzdb", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("tidyverse", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1//"))
suppressMessages(library("svglite", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("ggeasy", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("sandwich", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
suppressMessages(library("digest", lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/"))
# library("cowplot",lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/")
# library("RColorBrewer",lib.loc="/home/manuel.tardaguila/R/x86_64-pc-linux-gnu-library/4.1/")



opt = NULL

options(warn = 1)

Data_wrangling = function(option_list)
{
  cat("------FUNCTION------------------------------------------------------------------------------------------------------------------------------------------>Data_wrangling\n")
  
  
  
  opt_in = option_list
  opt <<- option_list
  
  cat("All options:\n")
  printList(opt)
  
  
  #### READ and transform type ----
  
  type = opt$type
  
  cat("TYPE_\n")
  cat(sprintf(as.character(type)))
  cat("\n")
  
  #### READ and transform out ----
  
  out = opt$out
  
  cat("OUT_\n")
  cat(sprintf(as.character(out)))
  cat("\n")
  
  #### READ and transform TF_annotation ----
  
  TF_annotation = unlist(strsplit(opt$TF_annotation, split=","))
  
  cat("TF_annotation_\n")
  cat(sprintf(as.character(TF_annotation)))
  cat("\n")
  
  
  #### Read ALL_by_ALL_INTERVAL----
  
  ALL_by_ALL_INTERVAL<-as.data.frame(fread(file=opt$ALL_by_ALL_INTERVAL, sep="\t", header=T), stringsAsFactors=F)
  
  cat("ALL_by_ALL_INTERVAL_0\n")
  cat(str(ALL_by_ALL_INTERVAL))
  cat("\n")
  cat(str(unique(ALL_by_ALL_INTERVAL$VAR)))
  cat("\n")
  
  ALL_by_ALL_INTERVAL$Genome_wide_pvalue<-10^(-1*ALL_by_ALL_INTERVAL$Genome_wide_minuslogpvalue)
  
  
  cat("ALL_by_ALL_INTERVAL_1\n")
  cat(str(ALL_by_ALL_INTERVAL))
  cat("\n")
  cat(sprintf(as.character(names(summary(ALL_by_ALL_INTERVAL$Genome_wide_pvalue)))))
  cat("\n")
  cat(sprintf(as.character(summary(ALL_by_ALL_INTERVAL$Genome_wide_pvalue))))
  cat("\n")
  
  #### Table_S6_Manual_curation ----
  
  Table_S6<-readRDS(opt$Table_S6)
  
  Table_S6_subset<-droplevels(Table_S6[which(Table_S6$Manual_curation == 'R in candidate'),])
  
  cat("Table_S6_subset_0\n")
  cat(str(Table_S6_subset))
  cat("\n")
  cat(str(unique(Table_S6_subset$VAR)))
  cat("\n")
  cat(sprintf(as.character(names(summary(Table_S6_subset$MPRA_CLASS)))))
  cat("\n")
  cat(sprintf(as.character(summary(Table_S6_subset$MPRA_CLASS))))
  cat("\n")
  cat(sprintf(as.character(names(summary(Table_S6_subset$genIE_CLASS)))))
  cat("\n")
  cat(sprintf(as.character(summary(Table_S6_subset$genIE_CLASS))))
  cat("\n")
  cat(sprintf(as.character(names(summary(Table_S6_subset$Mechanistic_Class)))))
  cat("\n")
  cat(sprintf(as.character(summary(Table_S6_subset$Mechanistic_Class))))
  cat("\n")
  cat(sprintf(as.character(names(summary(Table_S6_subset$Manual_curation)))))
  cat("\n")
  cat(sprintf(as.character(summary(Table_S6_subset$Manual_curation))))
  cat("\n")
  cat(sprintf(as.character(names(summary(Table_S6_subset$Multi_Lineage)))))
  cat("\n")
  cat(sprintf(as.character(summary(Table_S6_subset$Multi_Lineage))))
  cat("\n")
  
  levels_MPRA_CLASS<-rev(levels(Table_S6_subset$MPRA_CLASS))
  
  cat("levels_MPRA_CLASS\n")
  cat(str(levels_MPRA_CLASS))
  cat("\n")
  
  Table_S6_subset$MPRA_CLASS<-factor(Table_S6_subset$MPRA_CLASS,
                              levels=levels_MPRA_CLASS,
                              ordered=T)
  
  levels_genIE_CLASS<-levels(Table_S6_subset$genIE_CLASS)
  
  cat("levels_genIE_CLASS\n")
  cat(str(levels_genIE_CLASS))
  cat("\n")
  
  levels_Mechanistic_Class<-levels(Table_S6_subset$Mechanistic_Class)
  
  cat("levels_Mechanistic_Class\n")
  cat(str(levels_Mechanistic_Class))
  cat("\n")
  
  levels_Manual_curation<-levels(Table_S6_subset$Manual_curation)
  
  cat("levels_Manual_curation\n")
  cat(str(levels_Manual_curation))
  cat("\n")
  
  levels_Multi_Lineage<-levels(Table_S6_subset$Multi_Lineage)
  
  cat("levels_Multi_Lineage\n")
  cat(str(levels_Multi_Lineage))
  cat("\n")
  
  
  #### Merge ----
 
  ALL_by_ALL_INTERVAL_subset<-ALL_by_ALL_INTERVAL[which(ALL_by_ALL_INTERVAL$VAR%in%Table_S6_subset$VAR),]
  
  
  cat("ALL_by_ALL_INTERVAL_subset_1\n")
  cat(str(ALL_by_ALL_INTERVAL_subset))
  cat("\n")
  cat(str(unique(ALL_by_ALL_INTERVAL_subset$VAR)))
  cat("\n")
  cat(sprintf(as.character(names(summary(ALL_by_ALL_INTERVAL_subset$Genome_wide_pvalue)))))
  cat("\n")
  cat(sprintf(as.character(summary(ALL_by_ALL_INTERVAL_subset$Genome_wide_pvalue))))
  cat("\n")
  
  
  n_independent<-length(unique(ALL_by_ALL_INTERVAL_subset$VAR))

  cat("n_independent_0\n")
  cat(str(n_independent))
  cat("\n")

  Bonferroni_threshold<-0.05/n_independent

  ALL_by_ALL_INTERVAL_subset_SIG<-ALL_by_ALL_INTERVAL_subset[which(ALL_by_ALL_INTERVAL_subset$Genome_wide_pvalue <= Bonferroni_threshold),]

  cat("ALL_by_ALL_INTERVAL_subset_SIG_0\n")
  cat(str(ALL_by_ALL_INTERVAL_subset_SIG))
  cat("\n")
  cat(str(unique(ALL_by_ALL_INTERVAL_subset_SIG$VAR)))
  cat("\n")
  cat(sprintf(as.character(names(summary(ALL_by_ALL_INTERVAL_subset_SIG$Genome_wide_pvalue)))))
  cat("\n")
  cat(sprintf(as.character(summary(ALL_by_ALL_INTERVAL_subset_SIG$Genome_wide_pvalue))))
  cat("\n")

  cat("VARS:\n")
  cat(sprintf(as.character(unique(ALL_by_ALL_INTERVAL_subset_SIG$VAR))))
  cat("\n")

  
  ALL_by_ALL_INTERVAL_subset_SIG_not_block<-ALL_by_ALL_INTERVAL_subset_SIG[is.na(ALL_by_ALL_INTERVAL_subset_SIG$Block_PCHiC_minuslogpvalue),]
  
  
  cat("ALL_by_ALL_INTERVAL_subset_SIG_not_block_0\n")
  cat(str(ALL_by_ALL_INTERVAL_subset_SIG_not_block))
  cat("\n")
  cat(str(unique(ALL_by_ALL_INTERVAL_subset_SIG_not_block$VAR)))
  cat("\n")
  cat(sprintf(as.character(names(summary(ALL_by_ALL_INTERVAL_subset_SIG_not_block$Genome_wide_pvalue)))))
  cat("\n")
  cat(sprintf(as.character(summary(ALL_by_ALL_INTERVAL_subset_SIG_not_block$Genome_wide_pvalue))))
  cat("\n")
  
  
  ##### Prepare the chisq table ------
  
  Table_S6_subset$DE_genes_outside_tested_block<-NA
  
  
  Table_S6_subset$DE_genes_outside_tested_block[which(Table_S6_subset$VAR%in%ALL_by_ALL_INTERVAL_subset_SIG_not_block$VAR)]<-'DE_genes_outside_tested_block'
  Table_S6_subset$DE_genes_outside_tested_block[-which(Table_S6_subset$VAR%in%ALL_by_ALL_INTERVAL_subset_SIG_not_block$VAR)]<-'NO_DE_genes_outside_tested_block'
  
  Table_S6_subset$TF_CLASS<-NA
  
  
  Table_S6_subset$TF_CLASS[which(Table_S6_subset$VAR%in%TF_annotation)]<-'TF'
  Table_S6_subset$TF_CLASS[-which(Table_S6_subset$VAR%in%TF_annotation)]<-'NO_TF'
  
  
  
  cat("Table_S6_subset_0\n")
  cat(str(Table_S6_subset))
  cat("\n")
  cat(str(unique(Table_S6_subset$VAR)))
  cat("\n")
  cat(sprintf(as.character(names(summary(as.factor(Table_S6_subset$DE_genes_outside_tested_block))))))
  cat("\n")
  cat(sprintf(as.character(summary(as.factor(Table_S6_subset$DE_genes_outside_tested_block)))))
  cat("\n")
  cat(sprintf(as.character(names(summary(as.factor(Table_S6_subset$TF_CLASS))))))
  cat("\n")
  cat(sprintf(as.character(summary(as.factor(Table_S6_subset$TF_CLASS)))))
  cat("\n")
  
  
  
  Table_S6_subset$DE_genes_outside_tested_block<-factor(Table_S6_subset$DE_genes_outside_tested_block, levels=c('NO_DE_genes_outside_tested_block','DE_genes_outside_tested_block'))
  Table_S6_subset$TF_CLASS<-factor(Table_S6_subset$TF_CLASS, levels=c('NO_TF','TF'))
  
  
  cat("Table_S6_subset_1\n")
  cat(str(Table_S6_subset))
  cat("\n")
  cat(str(unique(Table_S6_subset$VAR)))
  cat("\n")
  cat(sprintf(as.character(names(summary(Table_S6_subset$DE_genes_outside_tested_block)))))
  cat("\n")
  cat(sprintf(as.character(summary(Table_S6_subset$DE_genes_outside_tested_block))))
  cat("\n")
  cat(sprintf(as.character(names(summary(Table_S6_subset$TF_CLASS)))))
  cat("\n")
  cat(sprintf(as.character(summary(Table_S6_subset$TF_CLASS))))
  cat("\n")
  
  
  Table_S6_subset.dt<-data.table(Table_S6_subset, key=c('DE_genes_outside_tested_block','TF_CLASS'))
  
  cat("Table_S6_subset.dt_1\n")
  cat(str(Table_S6_subset.dt))
  cat("\n")
  
  Summary_table<-as.data.frame(Table_S6_subset.dt[,(.N), by=key(Table_S6_subset.dt)], stringsAsFactors=F)
  
  
  
  cat("Summary_table_0\n")
  cat(str(Summary_table))
  cat("\n")
  
  
  Summary_table_wide<-as.data.frame(pivot_wider(Summary_table,
                                                id_cols="DE_genes_outside_tested_block",
                                                names_from="TF_CLASS",
                                                values_from="V1"), stringsAsFactors=F)
  
  
  Summary_table_wide[is.na(Summary_table_wide)]<-0
  Summary_table_wide[which(Summary_table_wide$DE_genes_outside_tested_block == 'NO_DE_genes_outside_tested_block')]<-0
  
  
  
  cat("Summary_table_wide_0\n")
  cat(str(Summary_table_wide))
  cat("\n")
  
  
  Summary_table_wide_subset<-Summary_table_wide[,-which(colnames(Summary_table_wide) == 'DE_genes_outside_tested_block')]
  
  
  row.names(Summary_table_wide_subset)<-Summary_table_wide$DE_genes_outside_tested_block
  
  
  cat("Summary_table_wide_subset_0\n")
  cat(str(Summary_table_wide_subset))
  cat("\n")
  
  
  tab.chisq.test<-chisq.test(Summary_table_wide_subset,correct = TRUE)
  
  
  cat("tab.chisq.test\n")
  cat(str(tab.chisq.test))
  cat("\n")
  
  
  pval<-as.numeric(tab.chisq.test$p.value)
  log_pval<-as.numeric(round(-1*log10(tab.chisq.test$p.value),2))
  
  
  cat("log_pval\n")
  cat(str(log_pval))
  cat("\n")
  
  
  ##### save file for ORA -----
  
  indx.int<-c(which(colnames(ALL_by_ALL_INTERVAL_subset) == 'VAR'),which(colnames(ALL_by_ALL_INTERVAL_subset) == 'ensembl_gene_id'),which(colnames(ALL_by_ALL_INTERVAL_subset) == 'HGNC'),
              which(colnames(ALL_by_ALL_INTERVAL_subset) == 'Genome_wide_pvalue'))
  
  
  ALL_by_ALL_INTERVAL_subset_data_wrangled<-unique(ALL_by_ALL_INTERVAL_subset[,indx.int])
  
  cat("ALL_by_ALL_INTERVAL_subset_data_wrangled\n")
  cat(str(ALL_by_ALL_INTERVAL_subset_data_wrangled))
  cat("\n")
  
  
  setwd(out)
  
  saveRDS(file='ALL_by_ALL_INTERVAL_subset_data_wrangled.rds',ALL_by_ALL_INTERVAL_subset_data_wrangled)
  
  
  cat("Bonferroni_threshold\n")
  cat(sprintf(as.character(Bonferroni_threshold)))
  cat("\n")
  
  cat("ALL_by_ALL_INTERVAL_subset_data_wrangled_VAR\n")
  cat(sprintf(as.character(unique(ALL_by_ALL_INTERVAL_subset_data_wrangled$VAR))))
  cat("\n")
 
}






printList = function(l, prefix = "    ") {
  list.df = data.frame(val_name = names(l), value = as.character(l))
  list_strs = apply(list.df, MARGIN = 1, FUN = function(x) { paste(x, collapse = " = ")})
  cat(paste(paste(paste0(prefix, list_strs), collapse = "\n"), "\n"))
}


#### main script ----

main = function() {
  cmd_line = commandArgs()
  cat("Command line:\n")
  cat(paste(gsub("--file=", "", cmd_line[4], fixed=T),
            paste(cmd_line[6:length(cmd_line)], collapse = " "),
            "\n\n"))
  option_list <- list(
    make_option(c("--Table_S6"), type="character", default=NULL, 
                metavar="type", 
                help="Path to tab-separated input file listing regions to analyze. Required."),
    make_option(c("--ALL_by_ALL_INTERVAL"), type="character", default=NULL, 
                metavar="type", 
                help="Path to tab-separated input file listing regions to analyze. Required."),
    make_option(c("--TF_annotation"), type="character", default=NULL, 
                metavar="filename", 
                help="Path to tab-separated input file listing regions to analyze. Required."),
       make_option(c("--type"), type="character", default=NULL, 
                metavar="type", 
                help="Path to tab-separated input file listing regions to analyze. Required."),
        make_option(c("--out"), type="character", default=NULL, 
                metavar="filename", 
                help="Path to tab-separated input file listing regions to analyze. Required.")
  )
  parser = OptionParser(usage = "140__Rscript_v106.R
                        --subset type
                        --TranscriptEXP FILE.txt
                        --cadd FILE.txt
                        --ncboost FILE.txt
                        --type type
                        --out filename",
                        option_list = option_list)
  opt <<- parse_args(parser)
  
  Data_wrangling(opt)
  # Stats_MPRA_per_manual_category(opt)

}


###########################################################################

system.time( main() )
