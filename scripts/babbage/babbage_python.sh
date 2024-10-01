#!/bin/bash

#SBATCH --job-name=conda-batch-job
#SBATCH --nodes=1
#SBATCH --time=00:01:00
#SBATCH --partition=research-dual-gpu
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.out
#SBATCH --gres=gpu:2

module load miniconda
source activate tf-2.0

python3 check_gpu.py
hostname