#!/bin/bash
#SBATCH --job-name=bioinformatics_job  # Job name
#SBATCH --partition=research-bigmem    # Partition with high-memory nodes
#SBATCH --nodes=1                      # Request one node
#SBATCH --ntasks=1                     # Single task
#SBATCH --cpus-per-task=64             # Request 64 CPU cores for your task
#SBATCH --mem=700G                     # Request 700GB of memory
#SBATCH --time=72:00:00                # Set a max runtime (72 hours)
#SBATCH --output=bio_job_%j.out        # Output file
#SBATCH --error=bio_job_%j.err         # Error log

# Load the required modules (e.g., Python)
module load miniconda

# Activate virtual environment if needed
source /path/to/your/venv/bin/activate

# Run your Python script
python /path/to/your/bioinformatics_script.py
