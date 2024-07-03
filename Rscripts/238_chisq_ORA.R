
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
  
  
  #### Read ORA_ActivePathways_results----
  
  ORA_ActivePathways_results<-as.data.frame(fread(file=opt$ORA_ActivePathways_results, sep="\t", header=T), stringsAsFactors=F)
  
  cat("ORA_ActivePathways_results_0\n")
  cat(str(ORA_ActivePathways_results))
  cat("\n")
  cat(str(unique(ORA_ActivePathways_results$VAR)))
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
  
  
  
  
  ##### Prepare the chisq table ------
  
  Table_S6_subset$ORA<-NA
  
  
  Table_S6_subset$ORA[which(Table_S6_subset$VAR%in%ORA_ActivePathways_results$VAR)]<-'ORA'
  Table_S6_subset$ORA[-which(Table_S6_subset$VAR%in%ORA_ActivePathways_results$VAR)]<-'NO_ORA'
  
  Table_S6_subset$TF_CLASS<-NA
  
  
  Table_S6_subset$TF_CLASS[which(Table_S6_subset$VAR%in%TF_annotation)]<-'TF'
  Table_S6_subset$TF_CLASS[-which(Table_S6_subset$VAR%in%TF_annotation)]<-'NO_TF'
  
  
  
  cat("Table_S6_subset_0\n")
  cat(str(Table_S6_subset))
  cat("\n")
  cat(str(unique(Table_S6_subset$VAR)))
  cat("\n")
  cat(sprintf(as.character(names(summary(as.factor(Table_S6_subset$ORA))))))
  cat("\n")
  cat(sprintf(as.character(summary(as.factor(Table_S6_subset$ORA)))))
  cat("\n")
  cat(sprintf(as.character(names(summary(as.factor(Table_S6_subset$TF_CLASS))))))
  cat("\n")
  cat(sprintf(as.character(summary(as.factor(Table_S6_subset$TF_CLASS)))))
  cat("\n")
  
  
  
  Table_S6_subset$ORA<-factor(Table_S6_subset$ORA, levels=c('NO_ORA','ORA'))
  Table_S6_subset$TF_CLASS<-factor(Table_S6_subset$TF_CLASS, levels=c('NO_TF','TF'))
  
  
  cat("Table_S6_subset_1\n")
  cat(str(Table_S6_subset))
  cat("\n")
  cat(str(unique(Table_S6_subset$VAR)))
  cat("\n")
  cat(sprintf(as.character(names(summary(Table_S6_subset$ORA)))))
  cat("\n")
  cat(sprintf(as.character(summary(Table_S6_subset$ORA))))
  cat("\n")
  cat(sprintf(as.character(names(summary(Table_S6_subset$TF_CLASS)))))
  cat("\n")
  cat(sprintf(as.character(summary(Table_S6_subset$TF_CLASS))))
  cat("\n")
  
  
  Table_S6_subset.dt<-data.table(Table_S6_subset, key=c('ORA','TF_CLASS'))
  
  cat("Table_S6_subset.dt_1\n")
  cat(str(Table_S6_subset.dt))
  cat("\n")
  
  Summary_table<-as.data.frame(Table_S6_subset.dt[,(.N), by=key(Table_S6_subset.dt)], stringsAsFactors=F)
  
  
  
  cat("Summary_table_0\n")
  cat(str(Summary_table))
  cat("\n")
  
  
  Summary_table_wide<-as.data.frame(pivot_wider(Summary_table,
                                                id_cols="ORA",
                                                names_from="TF_CLASS",
                                                values_from="V1"), stringsAsFactors=F)
  
  
  cat("Summary_table_wide_0\n")
  cat(str(Summary_table_wide))
  cat("\n")
  
  
  Summary_table_wide_subset<-Summary_table_wide[,-which(colnames(Summary_table_wide) == 'ORA')]
  
  
  row.names(Summary_table_wide_subset)<-Summary_table_wide$ORA
  
  
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
  
  colnames(Summary_table_wide)[which(colnames(Summary_table_wide) == 'V1')]<-'n'
  
  Summary_table_wide$pval<-pval
  Summary_table_wide$log_pval<-log_pval
  
  cat("Summary_table_wide_0\n")
  cat(str(Summary_table_wide))
  cat("\n")
  
  ##### SAVE ----
  
  setwd(out)
  
  write.table(Summary_table_wide, file='Chisq_table.tsv',sep="\t",quote=F,row.names = F)
 
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
    make_option(c("--ORA_ActivePathways_results"), type="character", default=NULL, 
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
