# Python Environment Management on MTSU HPC Clusters

## Overview

MTSU's HPC clusters (`hamilton.cs.mtsu.edu` and `babbage.mtsu.edu`) provide **Miniconda** as the primary Python environment manager. To use Python, users must first **load the Miniconda module** and can then activate a shared environment or create their own environment.

This guide covers:
- Loading Miniconda and available environments
- Cloning and managing Conda environments
- Installing packages
- Activating and deactivating environments
- Best practices for working with Conda on HPC systems

---

## Loading Miniconda and Viewing Available Environments

### **Load Miniconda Module**
Before using Conda, users must load the Miniconda module:
```bash
module load miniconda
```

### **List Available Conda Environments**
After loading Miniconda, you can view available shared environments with:
```bash
conda env list
```
This will display a list of environments, including shared environments located in a central directory.

### **Activate a Shared Environment**
To use a shared environment, activate it with:
```bash
source activate shared_env_name
```
Replace `shared_env_name` with the actual environment name from the list.

**Why use `source activate` instead of `conda activate` on an HPC system?**  
On some HPC systems, `conda activate` may not work correctly because it modifies environment variables in a way that requires an interactive shell. Many HPC setups rely on batch scripts, where `source activate` ensures that the environment is set up properly without conflicting with system defaults.

---

## Cloning a Shared Conda Environment

Since shared environments are typically **read-only**, users can **clone** them to create their own editable copy:
```bash
conda create --name my_env --clone shared_env_name
```
This will create `my_env` as an exact copy of `shared_env_name`, allowing users to install additional packages.

To activate the cloned environment:
```bash
source activate my_env
```

---

## Creating a New Conda Environment

Users can create their own Conda environment from scratch:
```bash
conda create --name my_new_env python=3.9
```
To activate it:
```bash
source activate my_new_env
```
After activation, packages can be installed as needed.

---

## Installing and Managing Packages

Once inside a Conda environment, users can install Python packages with:
```bash
conda install package_name
```
For example, to install NumPy:
```bash
conda install numpy
```
To install multiple packages at once:
```bash
conda install pandas matplotlib scipy
```

### **Installing Packages from a Requirements File**
If you have a list of required packages in a file (`requirements.txt`), install them with:
```bash
conda install --file requirements.txt
```

### **Listing Installed Packages**
To view installed packages in the active environment:
```bash
conda list
```

---

## Exporting and Sharing Conda Environments

Users can **export** their environment setup to a YAML file for sharing or backup:
```bash
conda env export > environment.yml
```
This file can be used to recreate the environment later:
```bash
conda env create -f environment.yml
```

---

## Deactivating and Removing Environments

### **Deactivating an Active Environment**
To exit an active Conda environment:
```bash
conda deactivate
```

### **Removing a Conda Environment**
To delete an environment when it is no longer needed:
```bash
conda remove --name my_env --all
```

---

## Best Practices for Using Conda on HPC

1. **Use Shared Environments When Possible**
   - This reduces redundancy and saves disk space.
   - If modifications are needed, clone the shared environment instead of modifying it.

2. **Avoid Installing Packages in the Base Environment**
   - Keep the base environment clean and create separate environments for different projects.

3. **Check Installed Packages Before Installing New Ones**
   - Use `conda list` to see if the package is already installed in the environment.

4. **Use Environment YAML Files for Reproducibility**
   - Always export the environment configuration when working on long-term projects to ensure consistency across sessions and systems.

By following these guidelines, users can effectively manage Python environments on MTSU's HPC clusters while ensuring smooth workflows and compatibility with shared resources.
