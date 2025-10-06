4  docker network ls

  835  docker ps | grep kind-control-plane

  836  docker inspect i<d> | grep HostPort

  837  sudo iptables -L FORWARD -n -v

  838  sudo iptables -t nat -L PREROUTING -n -v --line-numbers

  839  sudo iptables -t nat -L POSTROUTING -n -v --line-numbers

  840  crontab -l

  841  ls

  842  sudo iptables -t nat -A PREROUTING -p tcp --dport 31161 -j DNAT --to-destination 172.18.0.2:31161

  843  sudo iptables -t nat -A POSTROUTING -p tcp -d 172.18.0.2 --dport 31161 -j MASQUERADE

  844  sudo tcpdump -i any port 31161

  845  sudo iptables -t nat -L PREROUTING -n -v --line-numbers | grep 31161

  846  sudo iptables -t nat -L POSTROUTING -n -v --line-numbers | grep 31161

  847  sudo iptables -t nat -D POSTROUTING 5

  848  sudo iptables -t nat -A POSTROUTING -p tcp -s 172.18.0.2 --sport 31161 -j MASQUERADE

  849  sudo iptables -t nat -L POSTROUTING -n -v --line-numbers | grep 31161

  850  sudo iptables -t nat -L POSTROUTING -n -v --line-numbers

  851  curl -v http://x.x.x.x:31161

  852  curl -kvv http://x.x.x.x:31161

  853  sudo iptables -t nat -D POSTROUTING 5

  854  sudo iptables -t nat -L POSTROUTING -n -v --line-numbers

  855  sudo tcpdump -i any port 31161 -nn

  856  kubectl get svcc

  857  kubectl get

  858  kubectl get svc -o wide

  859  kubectl get node -o wide

  860  sudo iptables -t nat -L POSTROUTING -n -v --line-numbers

  861  sudo iptables -t nat -L POSTROUTING -n -v --line-numbers | grep 31161

  862  sudo iptables -t nat -A PREROUTING -p tcp --dport 31161 -j DNAT --to-destination 172.18.0.2:31161

  863  sudo iptables -t nat -A PREROUTING -p tcp --dport 31616 -j DNAT --to-destination 172.18.0.2:31616

  864  sudo iptables -t nat -A POSTROUTING -s 172.18.0.2/32 -j MASQUERADE

 

  867  sudo tcpdump -i any port 31161 or port 31616 -nn

  868  kubectl get pods -o wide

  869  kubectl exec -it podname -- ss -tlnp

  870  sudo iptables -L FORWARD -n -v

  871  sudo iptables -I FORWARD -s 172.18.0.0/16 -j ACCEPT

  872  sudo iptables -I FORWARD -d 172.18.0.0/16 -j ACCEPT

  873  sudo tcpdump -i any port 31161 or port 31616 -nn

  874  nc -vz x.x.x.x. 31616

  875  curl -v http://x.x.x.x:31161

  876  ftp -v

  877  lftp --version

  878  ftp -v

  879  history

 
sudo iptables -t nat -A PREROUTING -p tcp --dport 31161 -j DNAT --to-destination 172.18.0.2:31161

  863  sudo iptables -t nat -A PREROUTING -p tcp --dport 31616 -j DNAT --to-destination 172.18.0.2:31616

  864  sudo iptables -t nat -A POSTROUTING -s 172.18.0.2/32 -j MASQUERADE

  865  curl -v http://x.x.x.x:31161

  866  nc -vz ip port

  867  sudo tcpdump -i any port 31161 or port 31616 -nn

  868  kubectl get pods -o wide

  869  kubectl exec -it xxxxxx -- ss -tlnp

  870  sudo iptables -L FORWARD -n -v

  871  sudo iptables -I FORWARD -s 172.18.0.0/16 -j ACCEPT

  872  sudo iptables -I FORWARD -d 172.18.0.0/16 -j ACCEPT

  873  sudo tcpdump -i any port 3123 or port 354 -nn

  874  nc -vz x.x.x.x. 354

  875  curl -v http://ip:port

 
