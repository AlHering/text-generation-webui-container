## Important Notes
- this repo is a customized and decoupled version of oobabooga's Text Generation WebUI (https://github.com/oobabooga/text-generation-webui) 
- this repo is strongly linked personal infrastructure preferences and experiments
    - this especially includes the mounting and linking concept

## Used Repositories/Code
| Name         | Link     | release/commit |
|--------------|-----------|------------|
| oobabooga's Text Generation WebUI |  https://github.com/oobabooga/text-generation-webui    |    9ac5287     |

## Installation
### 1. Install Docker

```sh
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
(https://docs.docker.com/engine/install/ubuntu/)

### 2. Clone or download and unpack this repository

After cloning or downloading and unpacking, you might want to add to or adjust the code. An example might`link_shared_model_folders.sh`.
This script is later used for linking the model folders which will be mounted to `text-generation-webui-container/machine_learning_models` into the webui model folders at `text-generation-webui-container/text-generation-webui/models` and `text-generation-webui-container/text-generation-webui/loras`.
The same goes for the character folder. You can, however, ignore this file and later mount your local model folder directly to the target model folders.

### 3. Build a Docker image from the repository
```sh
docker build -t text-generation-webui-container:v1.8 <path to repo folder>
```
### 4. Start a container based off of the image
```sh
docker run \
    -it <--net=host or -p 7860:7860> --gpus all \
    --mount type=bind,source=<my local model folder>,target=/text-generation-webui-container/machine_learning_models/MODELS \
    --mount type=bind,source=<my local lora folder>,target=/text-generation-webui-container/machine_learning_models/LORAS \
    --mount type=bind,source=<my local character folder>, target=/text-generation-webui-container/text_generation_characters \
    text-generation-webui-container:v1.8
```

Note, that you can also open a terminal by appending `/bin/bash` to the command above. You will get to a terminal inside the running container and execute the bash script for re-linking the machine learning model folders, if necessary. Afterwards you can start the webui manually with `bash run_webui.sh`.

Note, that you can also directly mount your model or output folders to the targets `text-generation-webui-container/text-generation-webui/models`, `text-generation-webui-container/text-generation-webui/loras` and `text-generation-webui-container/text-generation-webui/characters`. Binding the folders is optional, but when no model folder is bound, there will be the need to download models afterwards, which then will exclusively be stored inside the docker container.

### 5. (Re)run the container
If you exit the container and it is stopped, you can use 
```sh
docker ps --all
```
to retrieve the name of the `text-generation-webui-container:v1.8` container and rerun and interactively enter it with
```sh
docker restart <container name> &&  docker exec -it <container name> /bin/bash
```
Inside the docker container's shell, you can run the webui again by using 
```sh
bash run_webui.sh
```

