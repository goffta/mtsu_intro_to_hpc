# MTSU Introduction to HPC

Welcome to the Middle Tennessee State University (MTSU) Introduction to High-Performance Computing (HPC) resources. This repository is designed to assist Computational and Data Science (CDS) faculty and students in effectively utilizing the HPC clusters available at MTSU.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Cluster Overview](#cluster-overview)
- [Getting Started](#getting-started)
- [SLURM Job Scripts](#slurm-job-scripts)
- [Example Code](#example-code)
- [Getting Help](#getting-help)
- [HPC Frequently Asked Questions (FAQ)](#additional-documentation)


## Prerequisites

Before using the HPC clusters, ensure you have the following:

1. **MTSU Account**:
   - You must have an active MTSU account and be added to the appropriate user groups to access the clusters.

2. **SSH Client**:
   - Install an SSH client on your local system. Examples:
     - **Linux/macOS**: Use the built-in `ssh` command.
     - **Windows**: Use [PuTTY](https://www.putty.org/) or Windows Terminal.

3. **VPN Access**:
   - If you are off-campus, connect to MTSU's VPN to access the cluster head nodes.

4. **Basic Linux Knowledge**:
   - Familiarity with the Linux command line is essential for effective cluster usage.

## Cluster Overview

For a detailed overview of the HPC clusters, including hardware specifications, available software modules, and storage resources, please refer to the [Cluster Overview](docs/cluster_overview.md) document.

## Getting Started

To begin using the HPC resources:

1. **Accessing the Clusters**:
   - Use SSH to connect to the cluster head nodes.
   - Ensure you have the necessary credentials and VPN access if required.

2. **Loading Modules**:
   - The clusters utilize the Environment Modules system.
   - Load the required modules for your workflow using the `module load` command.
   - For Python environments, it is recommended to use the `miniconda` module to manage dependencies.

3. **Submitting Jobs**:
   - Write SLURM job scripts to define your computational tasks.
   - Submit jobs using the `sbatch` command.

## SLURM Job Scripts

Pre-configured SLURM job scripts are available to assist you in submitting jobs efficiently. These scripts are located in the `/projects/examples/scripts` directory on the cluster. The available scripts include:

- `basic_cpu.slurm`: Template for basic CPU jobs.
- `array_job.slurm`: Template for job arrays.
- `gpu_job.slurm`: Template for GPU-accelerated jobs.
- `high_mem.slurm`: Template for high-memory jobs.

To use these scripts:

1. Copy the desired script to your working directory:
   ```bash
   cp /projects/examples/scripts/basic_cpu.slurm ~/my_jobs/

2. Modify the script parameters as needed.

3. Submit the job:
   ```bash
   sbatch ~/my_jobs/basic_cpu.slurm

## SLURM Job Submission Guide
Detailed examples for submitting SLURM jobs can be found in [SLURM Job Submission Examples](docs/slurm_job_examples.md).


## Example Code

Example code is provided to demonstrate various computational tasks:

- **Python**:
  - CPU-based matrix multiplication.
  - GPU-accelerated TensorFlow model training.

- **R**:
  - Parallel processing using the `foreach` and `doParallel` packages.

These examples are located in the `/projects/examples` directory on the cluster:

- Python scripts: `/projects/examples/python/`
- R scripts: `/projects/examples/r/`

Feel free to copy and modify these scripts to suit your research needs.

## Getting Help

For assistance with HPC resources:

- **Email**: [tgoff@mtsu.edu](mailto:tgoff@mtsu.edu)
- **Documentation**: Additional documentation is available at [help.mtsu.edu/kb](https://help.mtsu.edu/kb) under the Computational Science Systems Knowledge Base.

---

## Additional Documentation

For more details on HPC cluster usage, SLURM job management, and troubleshooting, see the **HPC FAQ**:

- [HPC Frequently Asked Questions (FAQ)](docs/hpc_faq.md)

--

