## Getting Started with SSH

### Where to Type Commands: How to Open a New Shell

### Windows

Computers with Windows operating systems do not automatically have a Unix Shell program installed. In this lesson, we encourage you to use an emulator included in Git for Windows, which gives you access to both Bash shell commands and Git. You can obtain Git for Windows <a href="[git_windows_url]">here</a>.

#### Shell Programs for Windows

* <a href="[git_windows_url]">Git for Windows</a> -- *Recommended*
* <a href="[putty_url]">PuTTY</a>

For advanced users, you may choose one of the following alternatives:

* Install the <a href="[wsl_url]">Windows Subsystem for Linux</a>
* Use the Windows <a href="[powershell_url]">PowerShell</a>

**Warning** 

* Commands in the WSL, PowerShell, or other alternatives may differ slightly from those shown in these guides or presented in the workshop.

#### Shell on macOS

On macOS, the default Unix Shell is accessible by running the Terminal program form the `/Application/Utilities` folder in Finder.

To open Terminal, try one or both of the following:

* In Finder, select the Go menu, then select Utilities, Locate Terminal in the Utilities folder and open it.

* Use the Mac "Spotlight" computer search function (&#8984; Space). Search for: `Terminal` and press `Return`.

#### Shell on Linux

On most versions of Linux, the default Unix Shell is accessible by running the <a href="[gnome_term_url]">(Gnome) Terminal</a> or <a href="[kde_term_url]">(KDE) Konsole</a> or <a href="[xterm_url]">xterm</a>, which can be found via the applications menu or the search bar.

* A working secure-shell (SSH) client.

     * For more information on obtaining/using SSH clients, see <a href="">here</a>.

* A working FSA/pipeline account with cluster access. 
     
     * Contact HPC Systems Administrator (tgoff@mtsu.edu) for more information and to request access to Computational and Data Science resources.

* A working jumphost account or VPN Access.

     *  For access via jumphost, see knowledge article <a href="[jumphost_kb_url]">here</a>.

This page is adapted for systems at Middle Tennessee State University from <a href="[setup_article_url]">"Introduction to High-Performance Computing: Setup"</a> by it's <a href="[carpentry_incubator_authors_url]">authors</a>. It is licensed under the <a href="[cc_by_url]">CC-BY 4.0</a> 2024.

[jumphost_kb_url]: https://help.mtsu.edu/kb?id=kb_article_view&sysparm_article=KB0010238
[setup_article_url]: https://carpentries-incubator.github.io/hpc-intro/setup.html
[carpentry_incubator_authors_url]: https://carpentries-incubator.github.io/hpc-intro/
[cc_by_url]: https://creativecommons.org/licenses/by/4.0/
[git_windows_url]: https://git-scm.com/download/win
[powershell_url]: https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core?view=powershell-7
[wsl_url]: https://docs.microsoft.com/en-us/windows/wsl/install-win10
[gnome_term_url]: https://help.gnome.org/users/gnome-terminal/stable/
[kde_term_url]: https://konsole.kde.org/
[xterm_url]: https://en.wikipedia.org/wiki/Xterm