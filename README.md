# PG_Docker_replication
TODO: 
1. password parameter for now the password is "thepassword"
2.  failover script 


to build :
docker build -t postrep .
to run  :
docker run -d --name master  postrep
docker run -d --name slave -e SLAVE=<master_ip> postrep
 

