# Effective Resource Usage

## Prerequisites

For a comprehensive list of prerequisites and related guides, see [here](./getting_started.md#prerequisites).

## Overview

### Questions
- How do I transfer files to (and from) the cluster?

### Objectives
- Transfer files to and from an HPC cluster.

## Download Files from the Internet

One of the quickest ways to download files from the internet is to use the ```wget```. Any file that can be downloaded with your web browser through a direct download link can be downloaded with the ```wget``` command. This is a quick way to download datasets or source code. The syntax for these commands is:
- ```wget [-O new_name] https://some/link/to/a/file```

## Archiving Files

One of the greatest challenges faced when transferring data between remote HPC systems is that of large numbers of files. There is resource overhead involved in transferring each individual file; when transferring large numbers of files these overheads combine and slow down data transfers.

One solution to this problem is to archive multiple files into smaller numbers of larger files before transferring to improve efficiency. Sometimes the archiving process involves *compression* to reduce the amount of data to be transferred. The most common archiving command used on a our cluster will be ```tar```.

```tar``` can be used to combine files and folders into a single archive file, and optionally, compress the result.





---

This page is adapted for systems at Middle Tennessee State University from [Introduction to High-Performance Computing](https://carpentries-incubator.github.io/hpc-intro/) by it's [authors](https://carpentries-incubator.github.io/hpc-intro/setup.html). It is licensed under the [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/) 2024.