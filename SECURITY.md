# Galactica Network Validators Security Checklist

## Introduction
This document provides security configurations for validators in the Galactica Network, ensuring node security and network integrity.

## Clock Synchronization
- **NTP (Network Time Protocol):** Use NTP to synchronize your server's clock with internet standard time servers.
  ```sh
  sudo apt-get update && sudo apt-get install ntp
  sudo systemctl enable ntp && sudo systemctl start ntp
  ```
- **Check synchronization:** Use `ntpq -p` to verify time accuracy regularly.

## Firewall Configuration with UFW
- **Installation:** If not present, install UFW using `sudo apt-get install ufw`.
- **Initial Configuration:**
    - **Enable SSH Access:** First, allow SSH connections to maintain remote access.
      ```sh
      sudo ufw allow 22/tcp
      ```
    - **Enable UFW:** Activate UFW with `sudo ufw enable`.
    - **Default Policies:** Set to deny incoming and allow outgoing connections.
      ```sh
      sudo ufw default deny incoming
      sudo ufw default allow outgoing
      ```
- **Allow Necessary Ports:** Open ports required by Galactica Network, e.g., `sudo ufw allow 26656/tcp` for P2P communication.

## Conclusion
Following these streamlined security practices will safeguard your Galactica Network validator node. Regular updates and reviews of security configurations are advised to counter new threats.
