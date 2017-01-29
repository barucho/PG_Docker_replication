# PG_Docker_replication
TODO: 
1. password parameter for now the password is "thepassword"
2.  failover script 


to build :
docker build -t postrep .
to clean:
docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
to run  :
docker run -d --name master  postrep
docker run -d --name slave -e SLAVE=<master_ip> postrep
run failover:
docker exec -it -u postgres slave  bash -c 'pg_ctl promote'
show log:
docker logs slave
show replication status:
docker exec -it -u postgres master  bash -c 'echo "select * from pg_stat_replication;" |psql' 
docker exec -it -u postgres slave  bash -c 'echo "select now()-pg_last_xact_replay_timestamp();" |psql'