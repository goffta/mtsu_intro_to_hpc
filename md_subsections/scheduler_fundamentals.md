# Scheduler Fundamentals

## Prerequisites

For a comprehensive list of prerequisites and related guides, see [here](./getting_started.md#prerequisites).

## Overview

### Questions
- What is a scheduler and why does a cluster need one?
- How do I launch a program to run on a compute node in the cluster?
- How do I capture the output of a program that is run on a node in the cluster?

### Objectives
- Submit a simple script to the cluster.
- Monitor the execution of jobs using command line tools.
- Inspect the output and error files of your jobs.
- Find the right place to put large datasets on the cluster.

## Job Scheduler
A large HPC system might have thousands of nodes and thousands of users; how can we decide who gets to user what and when? How can we ensure that a task is run with the needed resources and that those resources remain available throughout the scheduled task? This is the purpose of a special piece of software called the *scheduler*. On MTSU's clusters, the Slurm scheduler manages which jobs run where and when.

![alt text](../img/restaurant_queue_manager.svg "Scheduler infographic")
* CC-BY-2.0, sabryr

## Running a Batch Job
The most basic use of the scheduler is to run a command non-interactively. Any command (or combination/series of commands) that you want to run on the cluster is called a *job*; the process of using a scheduler to run the job is called *batch job submission*.

In this case, the job we want to run is a shell script -- this is essentially just a text file contianing a list of UNIX commands to be executed in a sequential manner. This example shell script will have three essential parts:

- On the very first line, we must add ``` #!/bin/bash ```. The ``` #! ``` ("hash-bag" or "shebang") tells the computer what program is meant to execute the contents of this file; in this case, we are letting the computer know that the commands that follow are written for the command-line shell.
- Anywhere below the first line, we'll add an ``` echo ``` command with a useful message to print in the terminal. ``` echo -n ``` will print everything that follows, *without* ending the line by printing the new-line character.
- On the last line, we'll invoke the ``` hostname ``` command, which will print the name of the node that the script is run on.
- You'll notice that we've added in the ``` sleep ``` command with an integer 10 after. Because this job exectutes so quickly, we must add this line to illustrate schduler functions.

```
[yourUsername@babbage ~]$ nano example-job.sh
```
Type the following in to the file you have just created:
```
#!/bin/bash
sleep 10
echo -n "This script is running on "
hostname
```

Lets run the script. Does it execute on the cluster or on the head node?

```
[yourUsername@babbage ~]$ bash example-job.sh
```
```
This script is running on babbage.mtsu.edu
```

This script just ran on the head node; we want to take advantage of compute nodes. We need to use the scheduler to queue up ``` example-job.sh ``` to run on a compute node.

To submit this task to the scheduler, we use ``` sbatch ``` command. This creates a *job* which will execute the *script* when *dispatched* to a compute node which the queuing system has identifies as available to perform the requested work.

```
[yourUsername@babbage ~]$ sbatch example-job.sh
```
```
Submitted batch job 14836
```

That's all we need to submit a job. Our work is done; the scheduler now takes over and tries to run the job for us. While the job is waiting to run, it goes into a list of jobs called the *queue*. To check on our job's status, we check the queue using the command ``` squeue -u yourUsername ```

```bash
JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
14836 interactive   example- tgoff R       0:30      1 c1
```
We can see all the pertinent details of our running jobs; most importantly that it is in the ``` R ``` or ``` RUNNING ``` state. Sometimes your jobs might need to wait in a queue  (``` PENDING ``` ) or have an error (``` E ```).

### Where's the Output?
On the login node, the script printed output to the terminal; but now, when ```squeue``` shows the job has finished, nothing printed to the terminal.

Cluster job output is typically redirected to a file in the directory where you launched it from. Use the ```ls``` command to find the file and the ```cat``` command to read the file.

```bash
[yourUsername@babbage ~]$ ls
slurm-14836.out

[yourUsername@babbage ~]$ cat slurm-14836.out
This script is running on c1.babbage.mtsu.edu
```

## Job Customization

The job we ran in the previous section used all of the scheduler's default options. In your research, that's probably not what you want. The default options represent a reasonable minimum for basic tasks. Chances are, you will need more cores, more memory, more time, among other special considerations. To gain access to these resources you must customize your job script.

Comments in UNIX shell scripts (denoted by ```#```) are typically ignored, with notable exceptions (the special first line of our script being the first). Another important exception to this rule are ```#SBATCH``` designed to pass directives on to the Slurm scheduler. Anything following the ```#SBATCH``` command is interpreted as an instruction to the scheduler.

To illustrate, let's use the ```-J``` option to change the name of the job.

Edit the example-job.sh:

```bash
[yourUsername@babbage ~]$ nano example-job.sh
```
Add the new slurm directive:
```
#!/bin/bash
#SBATCH -J hello-world

sleep 10
echo -n "This script is running on "
hostname
```

Submit the job and monitor its status:
```bash
[yourUsername@babbage ~]$ sbatch example-job.sh
```
```
Submitted batch job 14839
```
```bash
[yourUsername@babbage ~]$ squeue -u yourUsername
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             14839 interacti hello-wo    user  R       0:03      1 c1
```
## Resource Requests
What about more important changes, such as the number of cores, memory, and time for your jobs? One of the most critical things when working on an HPC system is specifying the resources required to run a job. This allows the scheduler to find the right time and place to schedule your job. If you do not specify the requirements you will likely be stuck with the default resources, which is probably not what you want.

The folowing are several key resource request:
- ```--ntasks=<ntasks>``` or ```-n <ntasks>```: How many CPU cores does your job need, in total?
- ```--time <days-hours:minutes:seconds>``` or ```-t <days-hours:minutes:seconds>```: How much real-world time (walltime) will your job take to run? You can omit the ```<days>``` part if you wish.
- ```--mem=<megabytes>```: How much memory on a node does your job need in megabytes? You can also specify gigabytes by adding a lowercase "g" afterwards (example: ```--mem=5g```)
- ```--nodes=<nnodes>``` or ```-N <nnodes>```: How many separate machines does your job need to run on? Note that if you set ```ntasks``` to a number greater than what one machine can offer, Slurm should set this value automatically.

Please note that just *requesting* these resources won't make your job run any faster, nor will it necessarily mean that you will consume all of the resources requested. It only means that those resources are made available to you. Your job might use less memory, less time, or fewer cores/nodes than requested. It's best if your requests accurately reflect your job's requirements. This will be covered in another section of this workshop.

## Cancelling a Job

Sometimes a mistake is made and a job needs to be cancelled. This can be done with the ```scancel``` command. As an example, lets submit a job and then cancel it using it's job number. Before we submit our example-job.sh script, first modify it to extend the walltime so that it will run long enough that we have the opportunity to cancel it (by changing the ```---time``` SBATCH directive).

```bash
[yourUsername@babbage ~]$ sbatch example-job.sh
Submitted batch job 14839
[yourUsername@babbage ~]$ squeue -u yourUsername
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             14839 interacti hello-wo    user  R       0:03      1 c1
```

```bash
[yourUsername@babbage ~]$ scancel 14839
[yourUsername@babbage ~]$ squeue -u yourUsername
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
```

You can also cancel all of your jobs at once by using the ```-u``` option. This will delete all jobs for your username.

## Other Types of Jobs

So far we've been running jobs in batch mode (non-interactively). Most of your long runs wilil be like this. However, sometimes we need to run jobs interactively. Creating an entire job script might be overkill for small tasks, but the resources required are too great for the login node to handle. A good example of this might be building a genome index for alignment with a tool such as [HISAT2](https://daehwankimlab.github.io/hisat2/). We can run interactive jobs with the ```srun``` command (we also have the ```hpcshell``` shell function (a wrapper around the srun command)).

```srun``` runs a single command on the cluster and then exits. As an example:

```bash
[yourUsername@babbage ~]$ srun hostname
c2.babbage.mtsu.edu
```
```srun``` (and ```hpcshell```) accepts all of the same options as ```sbatch```; however, instead of specifying these in a script, these options are specified on the command-line when starting a job. To submit a job that uses 2 CPUs, you could use the following command:

```bash
[yourUsername@babbage ~]$ srun -n 2 echo "This job will use 2 CPUs."
This job will use 2 CPUs.
This job will use 2 CPUs.
```
Typically, the resulting shell environment will be the same as for sbatch.

## Interactive jobs

Sometimes you'll need more resources and more interaction than the one command srun provides. In this case, you can make use of the ```hpcshell``` shell function wrapper for ```srun```. This will give you a bash prompt on a compute node. 

### Using remote graphics

To see graphical output inside your jobs, you will need to utilize X11 forwarding and have an X11 client on your local machine. To connect to the clusters with this feature enabled, use the ```-Y``` option when you login with the ```ssh``` command. You will need to add this to your jumphost ssh command as well as the ssh command from the jumphost to the cluster login node.

To demonstrate what happens when you create a graphics window on the remote node, you can use the xeyes command. A pair of eyes should pop up (press ```Ctrl-C``` to stop). 

- If you are using a Mac, you must have installed XQuarts (and restarted your computer).
- If you are using Windows 11, you must have installed XMing as well as set the ```DISPLAY```
environment variable to point to your Xming server.
```bash
export DISPLAY=$HOSTNAME:0.0
```

---

This page is adapted for systems at Middle Tennessee State University from [Introduction to High-Performance Computing](https://carpentries-incubator.github.io/hpc-intro/) by it's [authors](https://carpentries-incubator.github.io/hpc-intro/setup.html). It is licensed under the [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) 2024.