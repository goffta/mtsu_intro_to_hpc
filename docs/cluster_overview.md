# Cluster Overview: MTSU HPC Resources

## Introduction
The Computational and Data Science (CDS) PhD Program at Middle Tennessee State University (MTSU) provides access to two high-performance computing (HPC) clusters: **Babbage** and **Hamilton**. These clusters are designed to support computational and research-intensive tasks for CDS faculty and students. This document provides an overview of their computational resources, configurations, and usage capabilities.

---

## Summary of Computational Resources

### **Babbage Cluster**
Babbage is a 21-node cluster optimized for general-purpose computation, high-memory applications, and GPU-accelerated workloads. It is optimized for general-purpose computation, high-memory applications, and GPU-accelerated workloads.

| **Category**           | **Details**                                                                 |
|------------------------|-----------------------------------------------------------------------------|
| **Total Nodes**        | 21                                                                          |
| **CPUs**               | 692 threads (various Intel architectures)                                  |
| **RAM**                | 2,752 GB                                                                   |
| **GPUs**               | 13 GPUs (2080Ti and A5000 models)                                          |
| **Centralized Storage**| ~80 TB                                                                     |

#### **Node Types**
| **Node Name(s)**  | **CPU**                                 | **RAM**    | **GPU**         | **VRAM**    | **Special Features**                        |
|-------------------|-----------------------------------------|------------|-----------------|------------|---------------------------------------------|
| `c1-10`          | 32 threads, Intel Broadwell             | 64 GB      | None            | None       | General Purpose                             |
| `c11-14`         | 32 threads, Intel Sandy Bridge EP       | 64 GB      | 2x NVIDIA 2080Ti| 11 GB each| GPU Nodes                                    |
| `c15-16`         | 72 threads, Intel Cascade Lake          | 768 GB     | None            | None       | High Memory Nodes                           |
| `c17-21`         | 20 threads, Intel Cascade Lake          | 64 GB      | 1x NVIDIA A5000 | 24 GB      | GPU Nodes (soon upgraded to 2x A5000 with NVLink for 48 GB linked VRAM) |

**Scratch Space**: Each node has 1 TB of local scratch space for temporary job storage.

### **Hamilton Cluster**
Hamilton is a 9-node cluster tailored for research tasks requiring GPUs and specialized computational resources. It is tailored for research tasks requiring GPUs and specialized computational resources.

| **Category**           | **Details**                                                                 |
|------------------------|-----------------------------------------------------------------------------|
| **Total Nodes**        | 9                                                                           |
| **CPUs**               | 180 threads (Intel and AMD architectures)                                  |
| **RAM**                | 640 GB                                                                     |
| **GPUs**               | 9 GPUs (2080Ti and A100 models)                                            |
| **Centralized Storage**| ~40 TB                                                                     |

#### **Node Types**
| **Node Name(s)**  | **CPU**                     | **RAM**    | **GPU**         | **VRAM**    | **Special Features**       |
|-------------------|-----------------------------|------------|-----------------|------------|---------------------------|
| `c1-8`           | 20 threads, Intel Cascade Lake | 64 GB      | 1x NVIDIA 2080Ti| 11 GB      | General Purpose            |
| `c9`             | 20 threads, AMD EPYC        | 128 GB     | 1x NVIDIA A100  | 80 GB      | High-Performance GPU       |

**Scratch Space**: Each node has 1 TB of local NVMe SSD scratch space for temporary job storage.

---

## Key Software and Tools

### **Operating System**
Both clusters operate on **Rocky Linux 8** with **OpenHPC 2.0**.

### **Scheduler**
- **SLURM** is the job scheduler for both clusters. It handles resource allocation and job execution.
- High-speed 10G fiber interconnects ensure efficient data transfer between nodes.

### **Available Modules**
Modules include popular software for scientific computing, such as:
- Python
- R
- Conda
- TensorFlow/PyTorch (GPU-optimized)
- MPI libraries

---

## Open OnDemand Access

Both clusters are equipped with Open OnDemand for web-based access:
- **Babbage**: [babbage-od.cs.mtsu.edu](https://babbage-od.cs.mtsu.edu)
- **Hamilton**: [hamilton-od.cs.mtsu.edu](https://hamilton-od.cs.mtsu.edu)

### Features
- **Interactive Desktops**: Access a full Linux desktop environment in your browser.
- **Jupyter Notebooks**: Create and manage Jupyter sessions with customizable resources (e.g., CPU/GPU, memory).
- **File Browser**: Manage files and data stored on the cluster.
- **Job Management**: Submit, monitor, and cancel SLURM jobs.

---

## Storage Resources

### **File Systems**
| **Directory** | **Purpose**                  | **Storage Type** | **Notes**                  |
|---------------|------------------------------|------------------|----------------------------|
| `/home`       | User home directories        | Centralized NFS  | Limited quota; persistent  |
| `/projects`   | Shared project directories   | Centralized NFS  | Long-term storage          |
| `/scratch`    | Temporary storage for jobs   | Local to nodes   | Purged periodically        |

---

## Partitions and Job Queues

### **Babbage Partitions**
| **Partition Name**       | **Nodes**        | **Max Time** | **Special Features**         |
|--------------------------|------------------|--------------|------------------------------|
| `interactive-cpu`        | `c1-10`          | 2 hours      | Short interactive jobs       |
| `research-cpu`           | `c1-10`          | 72 hours     | General purpose              |
| `research-dual-gpu`      | `c11-14`         | 48 hours     | Dual GPU nodes               |
| `research-gpu`           | `c11-14`, `c17-21` | 96 hours     | Mixed GPU nodes              |
| `research-bigmem`        | `c15-16`         | 168 hours    | High memory nodes            |

### **Hamilton Partitions**
| **Partition Name**       | **Nodes**        | **Max Time** | **Special Features**         |
|--------------------------|------------------|--------------|------------------------------|
| `interactive`            | `c1-8`           | 2 hours      | Short interactive jobs       |
| `research`               | `c1-8`           | 48 hours     | General purpose              |
| `a100`                   | `c9`             | 150 hours    | High-performance A100 GPU    |

---

## Getting Help

For assistance with HPC resources:
- **Email**: tgoff@mtsu.edu
- **Documentation**: Additional documentation is available at [help.mtsu.edu/kb](https://help.mtsu.edu/kb) under the Computational Science Systems KB.
