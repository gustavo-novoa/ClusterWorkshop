#!/bin/bash
#SBATCH --job-name=WSexample      # create a short name for your job
#SBATCH --nodes=1               # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=32      # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem=160G         # memory per cpu-core (4G per cpu-core is default)
#SBATCH --time=1:00:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=all          # send email on start, end and fault
#SBATCH --mail-user=gnovoa@princeton.edu
module purge
module load R  
Rscript redistrictingExample.R
