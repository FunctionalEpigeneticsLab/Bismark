
echo -e "#!/bin/bash

#SBATCH -J Nextflow_submitter
#SBATCH --no-requeue
#SBATCH -t 32:00:00
#SBATCH -c 10
#SBATCH --mem 10G
#SBATCH --nodes 1
#SBATCH --cluster wice --account lcfdna_labepi

cd $(pwd)
/lustre1/scratch/343/vsc34344/micromamba/bin/nextflow run main.nf -resume -params-file params_file.yml" > nextflow_submitter.slurm
