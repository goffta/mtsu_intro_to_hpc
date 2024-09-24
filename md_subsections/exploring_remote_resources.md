# Exploring Cluster Resources

## Prerequisites

For a comprehensive list of prerequisites and related guides, see [here](./getting_started.md#prerequisites).

## Overview

### Questions
- How does my local computer compare to cluster resources?
- How does the login node compare to the compute nodes?
- Are all compute nodes alike?

### Objectives
- Survey system resources using ```nproc```, ```free```, and the slurm queuing system
- Compare & contrast resources on the local machine, login node, and compute nodes
- Learn about cluster filesystems using ```df```
- See ```who``` else is logged in
- Assess the number of available and occupies compute nodes


## Look Around the Cluster

If you have not already done so, connect to cluster:

```
[you@jumphost02 ~]$ ssh yourUsername@babbage.mtsu.edu
```
Take a look at your home directory on the remote system:
```
[yourUsername@babbage ~]$ ls
```

If this is your first time logging in, you will likely see output similar to this:
``` 
[yourUsername@babbage ~]$ ls
public
```

When you first login to the cluster, you will be redirected to your home directory. A link to a shared public folder is automatically created for you the first time you login to the cluster (on babbage). Files located in public can be accessed by anyone with access to the cluster.

### Using HPC filesystems

On HPC systems, there are a number of places avialable for you to store your files. Each different type of storage differs in the amount of space available as well as the speed at which they can be accessed. On babbage there are three (3) different types:
- Home - This is a network filesystem; data stored here is accessible throughout the cluster. Files stored here are typically slower to access as the data is actually stored on another server and must be transmitted over the network.
- Scratch - this is typically faster than the networked Home directory; it is located on each individual compute node at ``` /scratch ```.
- Projects - Another alternative to Scratch space with higher quota limits and better performance than the Home storage (often lower performance than Scratch).

---

This page is adapted for systems at Middle Tennessee State University from [Introduction to High-Performance Computing](https://carpentries-incubator.github.io/hpc-intro/) by it's [authors](https://carpentries-incubator.github.io/hpc-intro/setup.html). It is licensed under the [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) 2024.