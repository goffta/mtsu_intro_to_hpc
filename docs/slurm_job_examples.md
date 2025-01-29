# SLURM Job Submission Examples

This document provides a systematic guide to testing and using SLURM for job submissions. It includes basic and advanced examples to ensure users are familiar with submitting, running, and troubleshooting jobs on the cluster.

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

