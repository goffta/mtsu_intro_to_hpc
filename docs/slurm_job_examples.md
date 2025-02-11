# SLURM Job Submission Examples

This document provides a systematic guide to testing and using SLURM for job submissions. It includes basic and advanced examples to ensure users are familiar with submitting, running, and troubleshooting jobs on the cluster.

** Note: These scripts were written and designed to be used on the babbage cluster (babbage.mtsu.edu). They can be adapted for use on other clusters (hamilton, etc), but partition names and module versions will be different.

## Table of Contents

1. [Simple Job Submission](#1-simple-job-submission)
2. [Interactive Job](#2-interactive-job)
3. [Parallel Job with Multiple Tasks](#3-parallel-job-with-multiple-tasks)
4. [Requesting Specific Resources](#4-requesting-specific-resources)
5. [GPU Job (Optional)](#5-gpu-job-optional)
6. [Job Arrays](#6-job-arrays)
7. [High Memory Job](#7-high-memory-job)
8. [Python Job Example](#8-python-job-example)
9. [C Job Example](#9-c-job-example)
10. [R Job Example](#10-r-job-example)
11. [TensorFlow GPU Job](#11-tensorflow-gpu-job)
12. [PyTorch GPU Job](#12-pytorch-gpu-job)
13. [Troubleshooting and Monitoring](#13-troubleshooting-and-monitoring)



---


## 1. Simple Job Submission

### **Script: `simple_job.slurm`**
```bash
#!/bin/bash
#SBATCH --job-name=test_job
#SBATCH --output=output.txt
#SBATCH --error=error.txt
#SBATCH --time=00:01:00
#SBATCH --partition=interactive-cpu

hostname
```

### **Command to Submit**
```bash
sbatch simple_job.slurm
```

### **Expected Behavior**
- The job runs successfully and outputs the hostname of the compute node to `output.txt`.
- No errors should appear in `error.txt`.

---

## 2. Interactive Job

### **Command to Start an Interactive Job**
```bash
srun --time=00:05:00 --partition=interactive-cpu --ntasks=1 --pty bash
```

### **Expected Behavior**
- A shell is opened on a compute node.
- Commands like `hostname` or `nproc` reflect the environment of the compute node.

---

## 3. Parallel Job with Multiple Tasks

### **Script: `parallel_job.slurm`**
```bash
#!/bin/bash
#SBATCH --job-name=parallel_job
#SBATCH --output=parallel_output.txt
#SBATCH --ntasks=4
#SBATCH --time=00:02:00
#SBATCH --partition=interactive-cpu

srun hostname
```

### **Command to Submit**
```bash
sbatch parallel_job.slurm
```

### **Expected Behavior**
- The output file lists 4 hostnames, one for each task.
- Tasks should run on the allocated nodes.

---

## 4. Requesting Specific Resources

### **Script: `resource_request.slurm`**
```bash
#!/bin/bash
#SBATCH --job-name=resource_test
#SBATCH --output=resource_output.txt
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --time=00:05:00
#SBATCH --partition=interactive-cpu

echo "CPUs allocated: $SLURM_CPUS_PER_TASK"
```

### **Command to Submit**
```bash
sbatch resource_request.slurm
```

### **Expected Behavior**
- The output confirms the requested CPUs were allocated.
- Memory allocation and runtime can be verified using `scontrol show job <jobid>`.

---

## 5. GPU Job (Optional)

### **Script: `gpu_job.slurm`**
```bash
#!/bin/bash
#SBATCH --job-name=gpu_test
#SBATCH --output=gpu_output.txt
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00
#SBATCH --partition=research-gpu

nvidia-smi
```

### **Command to Submit**
```bash
sbatch gpu_job.slurm
```

### **Expected Behavior**
- The output shows the results of the `nvidia-smi` command, confirming GPU allocation.
- Use `scontrol show job <jobid>` to verify GPU details.

---

## 6. Job Arrays

### **Script: `array_job.slurm`**
```bash
#!/bin/bash
#SBATCH --job-name=array_job
#SBATCH --output=array_output_%A_%a.txt
#SBATCH --array=1-5
#SBATCH --time=00:01:00
#SBATCH --partition=interactive-cpu

echo "Running task ID: $SLURM_ARRAY_TASK_ID"
```

### **Command to Submit**
```bash
sbatch array_job.slurm
```

### **Expected Behavior**
- Each task in the array produces a separate output file (e.g., `array_output_12345_1.txt`, etc.).
- The output confirms the correct `SLURM_ARRAY_TASK_ID` for each task.

---

## 7. High Memory Job

### **Script: `high_mem.slurm`**
```bash
#!/bin/bash
#SBATCH --job-name=high_mem_test
#SBATCH --output=high_mem_output.txt
#SBATCH --error=high_mem_error.txt
#SBATCH --mem=128G
#SBATCH --time=00:30:00
#SBATCH --partition=research-bigmem

free -h
```

### **Command to Submit**
```bash
sbatch high_mem.slurm
```

### **Expected Behavior**
- The output displays the memory available on the allocated high-memory node.
- No errors should appear in `high_mem_error.txt`.

---

## 8. Python Job Example

### **Python Script: `example.py`**
```python
# example.py
import os

print("SLURM_JOB_ID:", os.environ.get("SLURM_JOB_ID"))
print("SLURM_NODELIST:", os.environ.get("SLURM_NODELIST"))
print("Hello from Python!")
```

### **SLURM Script: `python_job.slurm`**
```bash
#!/bin/bash
#SBATCH --job-name=python_job
#SBATCH --output=python_output.txt
#SBATCH --error=python_error.txt
#SBATCH --time=00:05:00
#SBATCH --partition=interactive-cpu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

module load miniconda  # Load Miniconda module
source activate base  # Activate base environment

python example.py
```

---

## 9. C Job Example

### **C Program: `example.c`**
```c
// example.c
#include <stdio.h>
#include <stdlib.h>

int main() {
    char *job_id = getenv("SLURM_JOB_ID");
    char *node_list = getenv("SLURM_NODELIST");

    printf("SLURM_JOB_ID: %s\\n", job_id);
    printf("SLURM_NODELIST: %s\\n", node_list);
    printf("Hello from C!\\n");
    return 0;
}
```

### **Compilation Command**
Before submitting the job, compile the C code using:
```bash
gcc -o example example.c
```


### **SLURM Script: `c_job.slurm`**
```bash
#!/bin/bash
#SBATCH --job-name=c_job
#SBATCH --output=c_output.txt
#SBATCH --error=c_error.txt
#SBATCH --time=00:05:00
#SBATCH --partition=interactive-cpu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

./example
```

---

## 10. R Job Example

### **R Script: `example.R`**
```r
# example.R
job_id <- Sys.getenv("SLURM_JOB_ID")
node_list <- Sys.getenv("SLURM_NODELIST")

cat("SLURM_JOB_ID:", job_id, "\\n")
cat("SLURM_NODELIST:", node_list, "\\n")
cat("Hello from R!\\n")
```

### **SLURM Script: `r_job.slurm`**
```bash
#!/bin/bash
#SBATCH --job-name=r_job
#SBATCH --output=r_output.txt
#SBATCH --error=r_error.txt
#SBATCH --time=00:05:00
#SBATCH --partition=interactive-cpu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

module load R  # Load R module
Rscript example.R
```

## 11. TensorFlow GPU Job

### **Script: `tensorflow_job.slurm`**
```bash
#!/bin/bash
#SBATCH --job-name=tensorflow_gpu_test
#SBATCH --output=tensorflow_output.txt
#SBATCH --error=tensorflow_error.txt
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00
#SBATCH --partition=research-gpu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G

module load cuda/12.2
module load miniconda
source activate /opt/ohpc/pub/apps/miniconda/envs/tensorflow-2.15-py3.9-gpu

python tensorflow_test.py
```

### **Script: `tensorflow_test.py`**
```python
import tensorflow as tf

print("TensorFlow Version:", tf.__version__)
print("CUDA Available:", tf.config.list_physical_devices('GPU'))

if tf.config.list_physical_devices('GPU'):
    print("GPU Device Name:", tf.config.list_physical_devices('GPU')[0].name)

    with tf.device('/GPU:0'):
        a = tf.constant([[1.0, 2.0], [3.0, 4.0]])
        b = tf.constant([[5.0, 6.0], [7.0, 8.0]])
        c = tf.matmul(a, b)
        print("Matrix multiplication result on GPU:\n", c.numpy())
else:
    print("No GPU detected. Running on CPU.")
```

---

## 12. PyTorch GPU Job

### **Script: `pytorch_job.slurm`**
```bash
#!/bin/bash
#SBATCH --job-name=pytorch_gpu_test
#SBATCH --output=pytorch_output.txt
#SBATCH --error=pytorch_error.txt
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00
#SBATCH --partition=research-gpu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G

module load cuda/12.2
module load miniconda
source activate /opt/ohpc/pub/apps/miniconda/envs/pytorch-2.1-py3.9-gpu

python pytorch_test.py
```

### **Script: `pytorch_test.py`**
```python
import torch

print("PyTorch Version:", torch.__version__)
print("CUDA Available:", torch.cuda.is_available())

if torch.cuda.is_available():
    print("GPU Device Name:", torch.cuda.get_device_name(0))
    a = torch.tensor([1.0, 2.0, 3.0]).cuda()
    b = torch.tensor([4.0, 5.0, 6.0]).cuda()
    c = a + b
    print("Tensor computation result on GPU:", c)
else:
    print("No GPU detected. Running on CPU.")
```


---

## Troubleshooting and Monitoring

### **Checking Job Status**
- Use `squeue` to view running and queued jobs:
  ```bash
  squeue -u $USER
  ```
- View detailed information about a job:
  ```bash
  scontrol show job <jobid>
  ```

### **Checking Job Output**
- Review `output.txt` and `error.txt` for logs from submitted jobs.

### **Common Issues**
1. **Partition Not Available:** Ensure you’re using a valid partition (check with `sinfo`).
2. **Resource Request Too High:** Lower CPU, memory, or time requests and retry.
3. **Job Not Starting:** Use `squeue` or `scontrol` to check if your job is pending due to resource constraints.

---

