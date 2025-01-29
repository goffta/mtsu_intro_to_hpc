# HPC Frequently Asked Questions (FAQ)

This FAQ provides answers to common questions about using the MTSU HPC cluster, SLURM job submission, resource management, software installation, and troubleshooting.

---

## Table of Contents

1. [General Cluster Usage](#1-general-cluster-usage)
2. [SLURM Job Submission](#2-slurm-job-submission)
3. [GPU-Enabled TensorFlow and PyTorch Environments](#3-gpu-enabled-tensorflow-and-pytorch-environments)
4. [OnDemand Issues and Workarounds](#4-ondemand-issues-and-workarounds)

---

## 1. General Cluster Usage

### **How do I log into the cluster?**
Use SSH to connect to the cluster:
```bash
ssh your_username@<cluster>  # Replace <cluster> with babbage.mtsu.edu or hamilton.cs.mtsu.edu
```
Ensure you are on the MTSU network, use VPN, or connect via the **jumphost** or **Open OnDemand portal**.

### **How do I transfer files to/from the cluster?**

#### **Via Jumphost**
If you are off-campus and need to transfer files, you must go through the **jumphost**.

- **Using `scp` via jumphost (port 2222):**
  ```bash
  scp -o ProxyJump=your_username@jumphost.mtsu.edu -P 2222 localfile.txt your_username@<cluster>:/home/your_username/
  ```

- **Using `rsync` via jumphost (port 2222):**
  ```bash
  rsync -e 'ssh -J your_username@jumphost.mtsu.edu -p 2222' -avz localdir/ your_username@<cluster>:/home/your_username/
  ```

Replace `<cluster>` with `babbage.mtsu.edu` or `hamilton.cs.mtsu.edu` as appropriate.


#### **Direct Transfer (MTSU Network or VPN)**
- Using `scp`:
  ```bash
  scp localfile.txt your_username@<cluster>:/home/your_username/
  ```
- Using `rsync`:
  ```bash
  rsync -avz localdir/ your_username@<cluster>:/home/your_username/
  ```

---

## 2. SLURM Job Submission

### **How do I submit a job?**
```bash
sbatch my_script.slurm
```
Check job status with:
```bash
squeue -u $USER
```

### **How do I run an interactive job?**
```bash
srun --time=01:00:00 --partition=interactive-cpu --ntasks=1 --cpus-per-task=1 --pty bash
```
Alternatively, you can use the `hpcshell` function:
```bash
hpcshell () { 
    salloc --partition=interactive-cpu "$@"
}
```
Run an interactive session:
```bash
hpcshell --time=01:00:00 --ntasks=1 --cpus-per-task=1
```

---

## 3. GPU-Enabled TensorFlow and PyTorch Environments

### **Preconfigured Shared Environments**
*Note:* The base environments for TensorFlow and PyTorch are currently only available on the **Babbage** cluster but will be added to the **Hamilton** cluster soon.

#### **Available Shared Environments**
- **TensorFlow GPU:** `/opt/ohpc/pub/apps/miniconda/envs/tensorflow-2.15-py3.9-gpu`
- **PyTorch GPU:** `/opt/ohpc/pub/apps/miniconda/envs/pytorch-2.1-py3.9-gpu`

### **Using the Shared Environments**
Before activating the environment, ensure the correct CUDA module is loaded:
```bash
module load cuda/12.2
```
Load Miniconda and activate the shared environment:
```bash
module load miniconda
source activate /opt/ohpc/pub/apps/miniconda/envs/tensorflow-2.15-py3.9-gpu  # or pytorch-gpu
```

### **Example SLURM Scripts for TensorFlow and PyTorch**
- [TensorFlow SLURM Job Script](examples/tensorflow/tensorflow_job.slurm)
- [PyTorch SLURM Job Script](examples/pytorch/pytorch_job.slurm)

### **Example Python Scripts**
- [TensorFlow Test Script](examples/tensorflow/tensorflow_test.py)
- [PyTorch Test Script](examples/pytorch/pytorch_test.py)

### **Copying and Customizing an Environment**
To make a personal copy that allows package modifications:
```bash
conda create --name my_tf_env --clone /opt/ohpc/pub/apps/miniconda/envs/tensorflow-2.15-py3.9-gpu
source activate my_tf_env
```
Install additional packages as needed (prefer `conda` first for compatibility, then `pip` if necessary):
```bash
conda install my_package  # Try conda first
pip install my_package  # Use pip only if the package is not available in conda
```

### **Running GPU Jobs with TensorFlow or PyTorch**
Submit a SLURM job that requests a GPU:
```bash
sbatch examples/tensorflow/tensorflow_job.slurm  # or examples/pytorch/pytorch_job.slurm
```
Ensure that your script is correctly set up to utilize CUDA:
```python
import torch
print("CUDA available:", torch.cuda.is_available())
```

---

## 4. OnDemand Issues and Workarounds

### **Extra Spaces or Newlines When Pasting into Web-Terminal**
When copying from Windows-based systems into Open OnDemand’s web-based terminal, extra spaces or newlines may appear. This is due to how Windows handles clipboard formatting.

#### **Fixes:**
- **Use `dos2unix` to clean up files:**
  ```bash
  dos2unix my_script.py
  ```
- **Use `sed` to remove Windows-style carriage returns:**
  ```bash
  sed -i 's/\r$//' my_script.py
  ```
- **Copy-paste manually instead of using the clipboard button.**
