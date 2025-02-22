#!/bin/bash
#SBATCH --job-name=mlflow
#SBATCH --partition=standard
#SBATCH --time=04:00:00
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G

#conda activate conda/nlp-qual-um
echo "Running on $(hostname)"
srun -n 1 mlflow server \
            -h 0.0.0.0 \
            --backend-store-uri sqlite:///$PROJDIR/mlruns.db \
            --default-artifact-root $PROJDIR/mlartifacts


