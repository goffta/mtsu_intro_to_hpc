# Connecting to Cluster Resources

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
      </ul>
    </li>
    <li><a href="#editing-slurm-submit-script">Connecting to MTSU CDS HPC</a></li>
      <ul>
        <li><a href="#jumphost">Jumphost</a></li>
        <li><a href="#vpn">VPN</a></li>
        <li><a href="#other">Other</a></li>
      </ul>
  </ol>
</details>

## Prerequisites

For a comprehensive list of prerequisites and related guides, see [here](./getting_started.md#prerequisites).

## General Information

MTSU does not allow direct access to CDS resources from outside the campus firewall and also requires the use of multi-factor authentication (MFA) for security reasons. This necessitates using one of the methods in the following section to access MTSU's cluster resources.

## Jumphost

To use MTSU's jumphost, you must have fulfilled all the requirements in the prerequisites [here](./getting_started.md#prerequisites). If you have not, you **MUST** go back and review/fulfill all requirements. If you have, continue below.

Go ahead and open up your terminal or graphical ssh client (if at this point you are confused or don't know what is required **STOP** and go [here](./setup.md#getting-started-with-ssh).

Using the command below (and replacing `yourUsername` with your Pipeline/FSA username, we will now login to the jumphost with the following command (graphical client steps will differ between platforms):

```
[you@yourlaptop:~]$ 
```

## VPN

## Other

The other methods available of connecting to MTSU cluster resources are via workstations in campus labs, CDS PhD GTA machines, and other on-campus hard wired resources (assets connected to campus network via Ethernet) are available via ssh. If you are accessing cluster resources from one of these other sources, you may proceed as if you are connected to campus VPN (there is no jumphost intermediary connection required).