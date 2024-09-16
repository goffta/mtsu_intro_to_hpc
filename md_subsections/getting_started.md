## Getting Started

### Prerequisites

* A working secure-shell (SSH) client.

     * For more information on obtaining/using SSH clients, see <a href="">here.<a>

* A working FSA/pipeline account with cluster access. 
     
     * Contact HPC Systems Administrator (tgoff@mtsu.edu) for more information and to request access to Computational and Data Science resources.
* A working jumphost account or VPN Access.

     *  For access via jumphost, see knowledge article <a href="[jumphost_kb_url]">here</a>.

### Initial Setup
<a name="initial-setup"></a>
1. Open Terminal application (PuTTY or WSL on Windows, Terminal on MacOS or Linux).
2. Login to the jumphost or connect to VPN.
3. Login to babbage.
   ```sh
   ssh babbage.mtsu.edu
   ```
4. Copy job template from shared directory
   ```sh
   cp /home/shared/walker/scripts/slurm/walker.sh .
   ```
<p align="right">(<a href="#readme-top">back to top</a>)</p>

[jumphost_kb_url]: https://help.mtsu.edu/kb?id=kb_article_view&sysparm_article=KB0010238