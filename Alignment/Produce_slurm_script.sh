
echo -e "#!/bin/bash

#SBATCH -J Nextflow_submitter
#SBATCH --no-requeue
#SBATCH -t 32:00:00
#SBATCH -c 10
#SBATCH --mem 10G
#SBATCH --nodes 1
#SBATCH --cluster wice --account lcfdna_labepi

cd $(pwd)
/staging/leuven/stg_00064/Kobe_2/miniconda3/bin/nextflow run main.nf -resume -params-file params_file.yml" > nextflow_submitter.slurm
