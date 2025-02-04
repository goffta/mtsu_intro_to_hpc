# File Transfer & SSH Tunneling on MTSU HPC Clusters

## Overview

When transferring files to and from the MTSU HPC clusters (`hamilton.cs.mtsu.edu` or `babbage.mtsu.edu`), users must go through an intermediate host (`jumphost.mtsu.edu`). The jumphost requires access via **SSH on port 2222** and users will be prompted for their verification code upon login.

This guide covers:
- Secure file transfer methods using `scp` and `rsync` (MacOS/Linux)
- Windows-specific transfer methods using **WinSCP** and **command-line tools**
- Common troubleshooting tips

---

## File Transfer for macOS & Linux Users

### **Using SCP (Secure Copy Protocol)**
SCP is a simple and effective way to transfer files through the jumphost.

#### **Uploading Files to the Cluster**
```bash
scp -o ProxyJump=yourusername@jumphost.mtsu.edu:2222 localfile.txt yourusername@hamilton.cs.mtsu.edu:/home/yourusername/
```

#### **Downloading Files from the Cluster**
```bash
scp -o ProxyJump=yourusername@jumphost.mtsu.edu:2222 yourusername@hamilton.cs.mtsu.edu:/home/yourusername/remotefile.txt .
```

#### **Transferring Entire Directories**
```bash
scp -r -o ProxyJump=yourusername@jumphost.mtsu.edu:2222 local_directory yourusername@hamilton.cs.mtsu.edu:/home/yourusername/
```

---

### **Using Rsync (Recommended for Large Transfers)**
`rsync` provides more flexibility and efficiency for transferring files, as it only copies changes rather than entire files.

#### **Sync a Local Folder to the Cluster**
```bash
rsync -av -e "ssh -J yourusername@jumphost.mtsu.edu:2222" local_folder/ yourusername@hamilton.cs.mtsu.edu:/home/yourusername/
```

#### **Sync Files from the Cluster to Local Machine**
```bash
rsync -av -e "ssh -J yourusername@jumphost.mtsu.edu:2222" yourusername@hamilton.cs.mtsu.edu:/home/yourusername/remote_folder/ local_folder/
```

---

## File Transfer for Windows Users

Windows users have multiple ways to transfer files: **WinSCP** (GUI tool) and **command-line methods (OpenSSH or rsync via WSL).**

### **Using WinSCP (Recommended for GUI Users)**
1. Download and install **WinSCP** from [winscp.net](https://winscp.net/).
2. Open WinSCP and configure a new session:
   - **File protocol:** `SFTP`
   - **Host name:** `jumphost.mtsu.edu`
   - **Port number:** `2222`
   - **User name:** `yourusername`
3. Click **Advanced > Connection > Tunnel**
   - Enable **Connect through SSH tunnel**
   - **Host name:** `hamilton.cs.mtsu.edu` or `babbage.mtsu.edu`
   - **User name:** `yourusername`
4. Click **Login** and authenticate when prompted.
5. Use the GUI to drag-and-drop files between local and remote systems.

---

### **Using SCP from the Windows Command Prompt**
Recent versions of Windows 10/11 include OpenSSH, allowing SCP usage from the command prompt.

#### **Uploading a File to the Cluster**
```cmd
scp -o "ProxyJump yourusername@jumphost.mtsu.edu:2222" localfile.txt yourusername@hamilton.cs.mtsu.edu:/home/yourusername/
```

#### **Downloading a File from the Cluster**
```cmd
scp -o "ProxyJump yourusername@jumphost.mtsu.edu:2222" yourusername@hamilton.cs.mtsu.edu:/home/yourusername/remotefile.txt .
```

#### **Transferring an Entire Folder**
```cmd
scp -r -o "ProxyJump yourusername@jumphost.mtsu.edu:2222" local_directory yourusername@hamilton.cs.mtsu.edu:/home/yourusername/
```

---

### **Using Rsync via Windows Subsystem for Linux (WSL)**
If you have WSL installed, you can use `rsync` as described in the MacOS/Linux section:
```bash
rsync -av -e "ssh -J yourusername@jumphost.mtsu.edu:2222" local_folder/ yourusername@hamilton.cs.mtsu.edu:/home/yourusername/
```

---

## Troubleshooting

### **Common Issues & Fixes**

#### **Authentication Issues**
- Ensure you enter your verification code correctly when prompted.
- If your password is not working, try resetting it via MTSU’s IT support.

#### **Connection Issues**
- Verify that you are using **port 2222** for the jumphost.
- Try adding `-v` to SSH commands for verbose output to debug:
  ```bash
  ssh -v -J yourusername@jumphost.mtsu.edu:2222 yourusername@hamilton.cs.mtsu.edu
  ```

#### **Slow Transfers or Large Files**
- Use `rsync` instead of `scp` for better performance on large datasets.
- Add compression with `-z`:
  ```bash
  rsync -avz -e "ssh -J yourusername@jumphost.mtsu.edu:2222" large_folder/ yourusername@hamilton.cs.mtsu.edu:/home/yourusername/
  ```

---

## Summary
| Method | Platform | Best For |
|--------|----------|-----------|
| SCP | macOS, Linux, Windows (cmd) | Quick single file transfers |
| Rsync | macOS, Linux, Windows (WSL) | Large/synced transfers |
| WinSCP | Windows | GUI users, drag-and-drop |

Use this guide to efficiently transfer files between your local machine and the MTSU HPC clusters!
