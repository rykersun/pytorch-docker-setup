docker run -it --name test -p 5678:22 -d detectron2
docker inspect -f "{{ .NetworkSettings.IPAddress }}" test
