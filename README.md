## Important Notes
- this repo is a customized and decoupled version of oobabooga's Text Generation WebUI (https://github.com/oobabooga/text-generation-webui) 
- this repo is strongly linked personal infrastructure preferences and experiments
    - this especially includes the mounting and linking concept

## Used Repositories/Code
| Name         | Link     | release/commit |
|--------------|-----------|------------|
| oobabooga's Text Generation WebUI |  https://github.com/oobabooga/text-generation-webui    |    v1.6.1     |

## Installation
### 1. Install Docker

```sh
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
(https://docs.docker.com/engine/install/ubuntu/)

### 2. Install the NVIDIA-Docker-Runtime
The NVIDIA-Docker-Runtime needs to be installed.
```sh
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
    && curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu20.04/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update
sudo apt-get install -y nvidia-docker2 nvidia-container-runtime

sudo systemctl restart docker
```
(https://github.com/nvidia/nvidia-docker/wiki/Installation-(version-2.0))

### 3. Clone or download and unpack this repository

After cloning or downloading and unpacking, you might want to add to or adjust the code. An example might`link_shared_model_folders.sh`.
This script is later used for linking the model folders which will be mounted to `text-generation-webui-container/machine_learning_models` into the webui model folders at `text-generation-webui-container/text-generation-webui/models` and `text-generation-webui-container/text-generation-webui/loras`. You can, however, ignore this file and later mount your local model folder directly to the target model folders.

### 4. Build a Docker image from the repository
```sh
nvidia-docker build -t text-generation-webui-container:v1.6_base <path to repo folder>
```
### 5. Start a container based off of the image
```sh
nvidia-docker run \
    -it <--net=host or -p 7860:7860> --gpus all \
    --mount type=bind,source=<my local model folder>,target=/text-generation-webui-container/machine_learning_models \
    --mount type=bind,source=<my local character folder>, target=/text-generation-webui-container/machine_learning_models/text_generation_characters \
    text-generation-webui-container:v1.6_base
```

Note, that you can also open a terminal by appending `/bin/bash` to the command above. You will get to a terminal inside the running container and execute the bash script for re-linking the machine learning model folders, if necessary. Afterwards you can start the webui manually with `bash run_webui.sh`.

Note, that you can also directly mount your model or output folders to the targets `text-generation-webui-container/text-generation-webui/models`, `text-generation-webui-container/text-generation-webui/loras`.

### 6. (Re)run the container
If you exit the container and it is stopped, you can use 
```sh
docker ps --all
```
to retrieve the name of the `text-generation-webui-container:v1.6_base` container and rerun and interactively enter it with
```sh
nvidia-docker restart <container name> &&  nvidia-docker exec -it <container name> /bin/bash
```
Inside the docker container's shell, you can run the webui again by using 
```sh
bash run_webui.sh
```

