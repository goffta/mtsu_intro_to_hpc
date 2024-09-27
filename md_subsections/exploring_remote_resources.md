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
- Home - This is a network filesystem; data stored here is accessible throughout the cluster. Files stored here are typically slower to access as the data is actually stored on another server and must be transmitted over the network. There is a ``` 10 GB ``` storage quota by default for all users.
- Scratch - this is typically faster than the networked Home directory; it is located on each individual compute node at ``` /scratch ```.
- Projects - Another alternative to Scratch space with higher quota limits and better performance than the Home storage (often lower performance than Scratch); it is located at ``` /projects ```.

### Nodes

A cluster is comprised of individual computers that are called *nodes* (sometimes you will hear them referred to as *servers*). On a cluster there are different types of nodes, each with a different purpose. When you ssh to the cluster you are accessing the cluster's *head node*. This node acts as a gateway for the rest of the cluster resources; as such, it should **NOT** be used for time-consuming or resource-intensive tasks. It is well suited for uploading and downloading files, setting up software stacks, and running small tasks.

To see who else is logged in to the login node, you can run the following command:

```
[yourUsername@babbage ~]$ who

```

This command may show only your user ID, but there are most likely several other users connected at any given time.

The real work on the cluster gets done on the *compute* (or *worker*) *nodes*. Compute nodes come in different shapes and sizes, and are designed for different purposes.

All interactions with computer nodes are handled by a specialized piece of software called a *scheduler* (babbage and hamilton both use the Slurm scheduler). Using the command below we can use the scheduler to tell us some more information about the compute nodes on the cluster.

To view all of the compute nodes, you can use the command ``` sinfo ```.

```
[yourUsername@babbage ~]$ sinfo
PARTITION         AVAIL  TIMELIMIT  NODES  STATE NODELIST
interactive-cpu*     up    2:00:00     10   idle c[1-10]
research-cpu         up 3-00:00:00     10   idle c[1-10]
research-dual-gpu    up 2-00:00:00      4   idle c[11-14]
research-gpu         up 4-00:00:00      9   idle c[11-14,17-21]
research-bigmem      up 7-00:00:00      2   idle c[15-16]
```

### Explore a Compute Node

To see the the CPU/Memory resources on each compute node, run the command:
```
[yourUsername@babbage ~]$ sinfo -o "%n %c %m" | column -t
```

To see the available GPU resouces available on each **partition**, run the command
```
[yourUsername@babbage ~]$ sinfo -o "%P %G %D %N"
```


---

This page is adapted for systems at Middle Tennessee State University from [Introduction to High-Performance Computing](https://carpentries-incubator.github.io/hpc-intro/) by it's [authors](https://carpentries-incubator.github.io/hpc-intro/setup.html). It is licensed under the [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) 2024.