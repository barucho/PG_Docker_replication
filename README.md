## PG_Docker_replication

### to build :
```bash 
docker build -t postrep .
```
### to clean:
```bash 
docker rmi $(docker images | grep "^<none>" | awk '{print $3}')
```
### to run  :
```bash 
docker run -d --name master  postrep
docker run -d --name slave -e SLAVE=<master_ip> postrep
```
### run failover:
```bash 
docker exec -it -u postgres slave  bash -c 'pg_ctl promote'
```
### show log:
```bash
docker logs slave
```
### show replication status:
```bash 
docker exec -it -u postgres master  bash -c 'echo "select * from pg_stat_replication;" |psql' 
docker exec -it -u postgres slave  bash -c 'echo "select now()-pg_last_xact_replay_timestamp();" |psql'
```
