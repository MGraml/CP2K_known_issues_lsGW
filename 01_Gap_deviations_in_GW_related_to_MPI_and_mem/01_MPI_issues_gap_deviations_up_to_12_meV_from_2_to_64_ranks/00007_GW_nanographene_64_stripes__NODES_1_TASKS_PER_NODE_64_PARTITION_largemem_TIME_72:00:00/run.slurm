#!/bin/bash -l
# Job Name and Files (also --job-name)
#SBATCH -J OUT_Nanograph_BSE_RKS_GTH_GW_nanographene_64_

#Output and error (also --output, --error):
#SBATCH -o ./%x.%j.out
#SBATCH -e ./%x.%j.err

#Mailing
#SBATCH --mail-user=maximilian.graml@ur.de
#SBATCH --mail-type=END,FAIL

#Initial working directory (also --chdir):
#SBATCH -D .

# Change here the job size and time limit:
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=64
#SBATCH --cpus-per-task=3
#SBATCH -p largemem
#SBATCH --exclusive
#SBATCH --mem=0
#SBATCH --account=hpc-prf-metdyn

#SBATCH --exclude="cn[0101-0115,0117-0133,0631,0633,1537-1540]"
#SBATCH --switches=1

#Setup of execution environment
#SBATCH --export=NONE
unset SLURM_EXPORT_ENV

module reset
####module load chem/Libint/2.6.0-GCC-12.2.0-lmax-7-cp2k
module load chem/CP2K/2025.2-foss-2025a-gcc-openmpi-aocl

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_PLACES=cores
export OMP_PROC_BIND=true
ulimit -S -c 0
#ulimit -s unlimited
#export OMP_STACKSIZE=4g

export exec="$cp2kdir/exe/local_otus_dev/cp2k.psmp"

srun --mpi=pmix_v3 cp2k.psmp *inp
