# Description

一個 PyTorch 的 Docker，符合 [simultaneous_semantic_and_instance_segmentation](https://github.com/lihaoliu-cambridge/simultaneous_semantic_and_instance_segmentation) 這個專案所需的環境

# Clone

以下指令將 Clone 這個 Docker 以及 [simultaneous_semantic_and_instance_segmentation](https://github.com/lihaoliu-cambridge/simultaneous_semantic_and_instance_segmentation) 這個 Submodule

```bash
git clone --recurse-submodules git@github.com:rykersun/pytorch-docker-setup.git
```

# Build Docker Image

運行 `build_docker.sh` 會建立一個名為 detectron2 的 Docker Image

```bash
./build_docker.sh
```

# Create And Run Docker Container

以下指令會使用 detectron2 這個 Image 建立並執行一個名為 detectron2_environment 的 Docker Container

```bash
docker run --name detectron2_environment -it detectron2
```

加上 `-v` 可以將 [simultaneous_semantic_and_instance_segmentation](https://github.com/lihaoliu-cambridge/simultaneous_semantic_and_instance_segmentation) 掛載至 Container

```bash
docker run -v $(pwd)/simultaneous_semantic_and_instance_segmentation:/root/simultaneous_semantic_and_instance_segmentation --name detectron2_environment -it detectron2
```

# SSH

啟動 Container SSH Server

```bash
docker run -it -v $(pwd)/simultaneous_semantic_and_instance_segmentation:/root/simultaneous_semantic_and_instance_segmentation --name sshd_detectron2_environment -p 5678:22 -d detectron2
```

取得 Docker Container IP Address

```bash
docker inspect -f "{{ .NetworkSettings.IPAddress }}" sshd_detectron2_environment
```

## Connect to Docker Container

Host 端記得先安裝 SSH

```bash
# Ubuntu

sudo apt install ssh
```

On localhost:

```bash
ssh root@localhost -p 5678

# 使用者名稱: root
# 密碼: 123456
```

On other machine:

```bash
ssh root@<Container IP Address>

# 使用者名稱: root
# 密碼: 123456
```

## Stop Container SSH Server

```bash
docker rm -f sshd_detectron2_environment
```
