#!/bin/bash

echo "🔐 Starting Master VPS Security Kit..."

# =========================
# 1. Update system
# =========================
dnf update -y

# =========================
# 2. Install firewall
# =========================
dnf install -y firewalld
systemctl enable --now firewalld

# =========================
# 3. Install Fail2Ban
# =========================
dnf install -y fail2ban
systemctl enable --now fail2ban

cat > /etc/fail2ban/jail.local <<EOF
[sshd]
enabled = true
port = 2468
maxretry = 3
bantime = 3600
findtime = 600
EOF

systemctl restart fail2ban

# =========================
# 4. SSH Hardening
# =========================
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

sed -i 's/^#Port 22/Port 2468/' /etc/ssh/sshd_config
sed -i 's/^Port 22/Port 2468/' /etc/ssh/sshd_config

grep -q "Port 2468" /etc/ssh/sshd_config || echo "Port 2468" >> /etc/ssh/sshd_config

sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
grep -q "PermitRootLogin no" /etc/ssh/sshd_config || echo "PermitRootLogin no" >> /etc/ssh/sshd_config

# =========================
# 5. Firewall rules
# =========================
firewall-cmd --permanent --add-port=2468/tcp
firewall-cmd --reload

# =========================
# 6. Restart SSH
# =========================
systemctl restart sshd

echo "✅ SECURITY SETUP COMPLETE"
echo "⚠️ IMPORTANT:"
echo "👉 Reconnect using: ssh root@IP -p 2468"
