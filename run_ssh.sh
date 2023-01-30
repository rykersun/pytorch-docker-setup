docker run -it --rm -v ./simultaneous_semantic_and_instance_segmentation:/root/simultaneous_semantic_and_instance_segmentation --name test -p 5678:22 -d detectron2
docker inspect -f "{{ .NetworkSettings.IPAddress }}" test
