#!/bin/bash

MASTER_ROUTE=$1
analysis=$2


Rscripts_path=$(echo "/home/manuel.tardaguila/Scripts/R/")
module load R/4.1.0


bashrc_file=$(echo "/home/manuel.tardaguila/.bashrc")

source $bashrc_file
eval "$(conda shell.bash hook)"


output_dir=$(echo "$MASTER_ROUTE""$analysis""/")

#rm -rf $output_dir
#mkdir -p $output_dir
 
Log_files=$(echo "$output_dir""/""Log_files/")

rm -rf $Log_files
mkdir -p $Log_files

#### Data_wrangling_ORA ###################################


type=$(echo "Data_wrangling_ORA""_""$analysis")
outfile_Data_wrangling_ORA=$(echo "$Log_files""outfile_1_""$type"".log")
touch $outfile_Data_wrangling_ORA
echo -n "" > $outfile_Data_wrangling_ORA
name_Data_wrangling_ORA=$(echo "$type""_job")
seff_name=$(echo "seff""_""$type")

Rscript_Data_wrangling_ORA=$(echo "$Rscripts_path""236_Data_wrangling_ORA.R")


ALL_by_ALL_INTERVAL=$(echo "/group/soranzo/manuel.tardaguila/Paper_bits/ALL_BY_ALL_DE_LM_FPKM_results_Main_VARS.tsv")
Table_S6=$(echo "/group/soranzo/manuel.tardaguila/Paper_bits/FIX_TABLES/Provisional_Tables/Table_S6_Provisional.rds")
TF_annotation=$(echo 'chr1_92925654_G_C,chr2_74920648_G_A,chr3_71355240_G_C,chr3_128317978_C_T,chr7_101499930_G_A,chr15_65174494_A_G,chr18_60920854_C_T')

myjobid_Data_wrangling_ORA=$(sbatch --job-name=$name_Data_wrangling_ORA --output=$outfile_Data_wrangling_ORA --partition=cpuq --time=24:00:00 --nodes=1 --ntasks-per-node=2 --mem-per-cpu=1024M --parsable --wrap="Rscript $Rscript_Data_wrangling_ORA --ALL_by_ALL_INTERVAL $ALL_by_ALL_INTERVAL --Table_S6 $Table_S6 --TF_annotation $TF_annotation --type $type --out $output_dir")
myjobid_seff_Data_wrangling_ORA=$(sbatch --dependency=afterany:$myjobid_Data_wrangling_ORA --open-mode=append --output=$outfile_Data_wrangling_ORA --job-name=$seff_name --partition=cpuq --time=24:00:00 --nodes=1 --ntasks-per-node=1 --mem-per-cpu=128M --parsable --wrap="seff $myjobid_Data_wrangling_ORA >> $outfile_Data_wrangling_ORA")



############################ MySigDB_ORA


VAR_array=$(echo 'chr1_198680015_G_A,chr1_202129205_G_A,chr1_29217311_G_A,chr15_65174494_A_G,chr17_38764524_T_A,chr18_60920854_C_T,chr19_11210157_C_T,chr19_15653669_T_C,chr1_92925654_G_C,chr2_144162105_A_G,chr2_219020958_C_T,chr22_28761148_C_T,chr2_74920648_G_A,chr3_128317978_C_T,chr3_128322617_G_A,chr3_17098399_A_G,chr3_46354444_C_T,chr3_71355240_G_C,chr5_1093511_G_A,chr5_35476470_G_T,chr7_101499930_G_A,chr8_41589736_T_G')

a=($(echo "$VAR_array" | tr "," '\n'))

 declare -a arr

 for i  in "${a[@]}"
 do

     VAR_array_sel=$i
     echo "$VAR_array_sel"


     analysis_route=$(echo "$output_dir""$VAR_array_sel""/")

     rm -rf $analysis_route
     mkdir -p $analysis_route



     type=$(echo "$VAR_array_sel""_""MySigDB_ORA")
     outfile_MySigDB_ORA=$(echo "$Log_files""outfile_2_""$type""_""$analysis"".log")
     touch $outfile_MySigDB_ORA
     echo -n "" > $outfile_MySigDB_ORA
     name_MySigDB_ORA=$(echo "$type""_job")
     seff_name=$(echo "seff""_""$type")


     Rscript_MySigDB_ORA=$(echo "$Rscripts_path""237_ORA_GW_INTERVAL.R")

     

     ALL_by_ALL_INTERVAL_subset_data_wrangled=$(echo "/group/soranzo/manuel.tardaguila/Paper_bits/ORA_exploration/ALL_by_ALL_INTERVAL_subset_data_wrangled.rds")
     path_to_GMT=$(echo "/home/manuel.tardaguila/GMT_files/msigdb_v2023.1.Hs_files_to_download_locally_ENTREZ/")


#     search_terms=$(echo "PLATELET,ERYTHRO,MEGAKARYOCYTE,MONOCYTE,NEUTROPHIL,LIMPHOCYTE,T_HELPER,TH1,TH2,BLOOD,BLOOD_COAGULATION,IMMUNE,HUMORAL_IMMUNE_RESPONSE,IMMUNOGLOBULIN,APOPTOSIS,HEMATOPOIETIC,HIPPO_SIGNALING,YAP,YAP_TAZ,GFI1,FOXP3_TARGETS,GATA2,CUX1_TARGET_GENES,CELLULAR_RESPONSE_TO_ORGANIC_CYCLIC_COMPOUND,CELLULAR_RESPONSE_TO_IONIZING_RADIATION,BCL2_TARGETS,HEPATOCYTE,NEURON")   # ADD HSC TERMS
    
     search_terms=$(echo "PLATELET,ERYTHRO,MEGAKARYOCYTE,MONOCYTE,NEUTROPHIL,EOSINOPHIL,BASOPHIL,LIMPHOCYTE,T_HELPER,TH_17,TH17,TH1,TH2,BLOOD,BLOOD_COAGULATION,IMMUNE,HUMORAL_IMMUNE_RESPONSE,IMMUNOGLOBULIN,HEMATOPOIETIC,HEPATOCYTE,NEURON")   # ADD HSC TERMS
     background_genes=$(echo "/home/manuel.tardaguila/GMT_files/msigdb_v2023.1.Hs_files_to_download_locally_ENTREZ/c5.hpo.v2023.2.Hs.entrez.gmt")
     maxGS_size=$(echo "500")
     minGS_size=$(echo "10")

#    pval_threshold=$(echo "0.05")   
     pval_threshold=$(echo "0.01")
#     pval_threshold=$(echo "0.00227")

     # --dependency=afterany:$myjobid_Data_wrangling_ORA

     myjobid_MySigDB_ORA=$(sbatch --job-name=$name_MySigDB_ORA --output=$outfile_MySigDB_ORA --partition=cpuq --time=24:00:00 --nodes=1 --ntasks-per-node=2 --mem-per-cpu=1024 --parsable --wrap="Rscript $Rscript_MySigDB_ORA --ALL_by_ALL_INTERVAL_subset_data_wrangled $ALL_by_ALL_INTERVAL_subset_data_wrangled --path_to_GMT $path_to_GMT --search_terms $search_terms --background_genes $background_genes --maxGS_size $maxGS_size --minGS_size $minGS_size --VAR_array_sel $VAR_array_sel --pval_threshold $pval_threshold --type $type --out $analysis_route")
     myjobid_seff_MySigDB_ORA=$(sbatch --dependency=afterany:$myjobid_MySigDB_ORA --open-mode=append --output=$outfile_MySigDB_ORA --job-name=$seff_name --partition=cpuq --time=24:00:00 --nodes=1 --ntasks-per-node=1 --mem-per-cpu=128M --parsable --wrap="seff $myjobid_MySigDB_ORA >> $outfile_MySigDB_ORA")

     echo "->>>$myjobid_MySigDB_ORA"
     arr[${#arr[@]}]="$myjobid_MySigDB_ORA"

 done



 done_string=$(echo "--dependency=afterany:"""""${arr[@]}"""")
 echo "$done_string"

 dependency_string=$(echo $done_string|sed -r 's/ /:/g')

 echo "$dependency_string"

##### collect_ORA

module load R/4.1.0

Rscript_collect_ORA=$(echo "$Rscripts_path""240_collect_ORA.R")

type=$(echo "collect_ORA")


outfile_collect_ORA=$(echo "$Log_files""outfile_3_""$type""_""$analysis"".log")
touch $outfile_collect_ORA
echo -n "" > $outfile_collect_ORA
name_collect_ORA=$(echo "$type""_job")
seff_name=$(echo "seff""_""$type")

VAR_array=$(echo 'chr1_198680015_G_A,chr1_202129205_G_A,chr1_29217311_G_A,chr15_65174494_A_G,chr17_38764524_T_A,chr18_60920854_C_T,chr19_11210157_C_T,chr19_15653669_T_C,chr1_92925654_G_C,chr2_144162105_A_G,chr2_219020958_C_T,chr22_28761148_C_T,chr2_74920648_G_A,chr3_128317978_C_T,chr3_128322617_G_A,chr3_17098399_A_G,chr3_46354444_C_T,chr3_71355240_G_C,chr5_1093511_G_A,chr5_35476470_G_T,chr7_101499930_G_A,chr8_41589736_T_G')
maxGS_size=$(echo "500")
minGS_size=$(echo "10")
#Keep_terms=$(echo "BLOOD,BLOOD_COAGULATION,HUMORAL_IMMUNE_RESPONSE,IMMUNOGLOBULIN,APOPTOSIS,HEMATOPOIETIC,HIPPO_SIGNALING,YAP,YAP_TAZ,GFI1,FOXP3_TARGETS,GATA2,CUX1_TARGET_GENES,CELLULAR_RESPONSE_TO_ORGANIC_CYCLIC_COMPOUND,CELLULAR_RESPONSE_TO_IONIZING_RADIATION,BCL2_TARGETS")
REMOVE_terms=$(echo "HEPATOCYTE,NEURON,NONIMMUNE,NEUROEPITHELIUM")

#$dependency_string

myjobid_collect_ORA=$(sbatch $dependency_string --job-name=$name_collect_ORA --output=$outfile_collect_ORA --partition=cpuq --time=24:00:00 --nodes=1 --ntasks-per-node=2 --mem-per-cpu=1024M --parsable --wrap="Rscript $Rscript_collect_ORA --VAR_array $VAR_array --REMOVE_terms $REMOVE_terms --minGS_size $minGS_size --maxGS_size $maxGS_size --type $type --out $output_dir")
myjobid_seff_collect_ORA=$(sbatch --dependency=afterany:$myjobid_collect_ORA --open-mode=append --output=$outfile_collect_ORA --job-name=$seff_name --partition=cpuq --time=24:00:00 --nodes=1 --ntasks-per-node=1 --mem-per-cpu=128M --parsable --wrap="seff $myjobid_collect_ORA >> $outfile_collect_ORA")


#### chisq_ORA ###################################


type=$(echo "chisq_ORA""_""$analysis")
outfile_chisq_ORA=$(echo "$Log_files""outfile_4_""$type"".log")
touch $outfile_chisq_ORA
echo -n "" > $outfile_chisq_ORA
name_chisq_ORA=$(echo "$type""_job")
seff_name=$(echo "seff""_""$type")

Rscript_chisq_ORA=$(echo "$Rscripts_path""238_chisq_ORA.R")


ORA_ActivePathways_results=$(echo "$output_dir""ORA_ActivePathways_results.tsv")
Table_S6=$(echo "/group/soranzo/manuel.tardaguila/Paper_bits/FIX_TABLES/Provisional_Tables/Table_S6_Provisional.rds")
TF_annotation=$(echo 'chr1_92925654_G_C,chr2_74920648_G_A,chr3_71355240_G_C,chr3_128317978_C_T,chr7_101499930_G_A,chr15_65174494_A_G,chr18_60920854_C_T')

# --dependency=afterany:$myjobid_collect_ORA

myjobid_chisq_ORA=$(sbatch --dependency=afterany:$myjobid_collect_ORA --job-name=$name_chisq_ORA --output=$outfile_chisq_ORA --partition=cpuq --time=24:00:00 --nodes=1 --ntasks-per-node=2 --mem-per-cpu=1024M --parsable --wrap="Rscript $Rscript_chisq_ORA --ORA_ActivePathways_results $ORA_ActivePathways_results --Table_S6 $Table_S6 --TF_annotation $TF_annotation --type $type --out $output_dir")
myjobid_seff_chisq_ORA=$(sbatch --dependency=afterany:$myjobid_chisq_ORA --open-mode=append --output=$outfile_chisq_ORA --job-name=$seff_name --partition=cpuq --time=24:00:00 --nodes=1 --ntasks-per-node=1 --mem-per-cpu=128M --parsable --wrap="seff $myjobid_chisq_ORA >> $outfile_chisq_ORA")
