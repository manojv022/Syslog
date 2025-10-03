https://www.keepalived.org/


- Keepalived is an open-source Linux software that provides high availability and load balancing using the Virtual Router Redundancy Protocol (VRRP). It creates a virtual IP address (VIP) or floating IP that acts as a single gateway, routing traffic to a cluster of servers. If the primary (active) server fails, Keepalived automatically fails over to a backup server, ensuring continuous service availability and minimizing downtime. It also monitors the health of backend servers to manage the server pool dynamically


**Key Functions**

-  `High Availability (HA):`
    Keepalived uses VRRP to establish a primary (master) and backup (slave) relationship between servers. The master server holds the VIP, and if it becomes unresponsive, a backup server quickly takes over the VIP and begins directing traffic. This active-passive or active-active setup ensures services remain accessible. 

- `Load Balancing:`
Keepalived uses the Linux Virtual Server (LVS) kernel module to distribute network traffic across multiple backend servers. It can manage a pool of servers, checking their health and sending traffic only to healthy servers. 
- `Health Monitoring:`
Keepalived incorporates various health checks to determine the status of services. If a backend server or a service on it fails, the health checker signals the failover mechanism to reroute traffic, maintaining service continuity. 
- `VRRP Protocol:`
VRRP is the core protocol Keepalived uses. It enables servers to form a virtual router group, appearing as a single, highly available router to clients. 



**How It Works**

   - `Virtual IP (VIP):` A shared virtual IP address is configured across multiple servers. 

- `Master/Backup Roles:` One server acts as the master, holding the VIP, while others are backups. 
- `Health Checks:` Keepalived constantly monitors the status of the master server and the backend services. 
- `Failover:` If the master server fails, a backup server detects the failure and rapidly takes over the VIP, becoming the new master. 
- `Traffic Redirection:` Network traffic is redirected to the new master server, with minimal or no interruption to users
