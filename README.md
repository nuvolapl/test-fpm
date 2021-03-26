```shell
docker-compose up -d --build
docker container ps
docker stats ${CONTAINER_FPM_ID}
curl -I http://127.0.0.1:8888/
ab -c 128 -n 1024 http://127.0.0.1:8888/
```
