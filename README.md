# 🔐 Master VPS Security Kit

A simple automation script to harden and secure a Linux VPS (tested on RHEL/CentOS/Alma/Rocky based systems using **dnf**).

It installs and configures essential security layers like firewall, Fail2Ban, and SSH hardening in one run.

---

## ⚡ Features

### 🛡️ System Security
- Full system update (`dnf update`)
- Automatic security patching base

### 🔥 Firewall Protection
- Installs **firewalld**
- Enables and starts firewall service
- Opens only required SSH port

### 🚫 Brute-force Protection
- Installs **Fail2Ban**
- Protects SSH from brute-force attacks
- Auto-bans suspicious IPs:
  - Max retry: 3
  - Ban time: 1 hour
  - Find time: 10 minutes

### 🔑 SSH Hardening
- Changes SSH port from `22 → 2468`
- Disables root login
- Secures SSH access

### 🌐 Network Security
- Only allows SSH through firewall (custom port)
- Blocks unwanted external access

---

## ⚙️ Requirements

- Linux VPS (CentOS / AlmaLinux / Rocky Linux / RHEL)
- Root access
- `dnf` package manager support

---

## 📥 Installation

### 1. Create script file
```bash
nano secure-vps.sh

chmod +x secure-vps.sh

./secure-vps.sh
