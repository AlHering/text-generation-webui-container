FROM nvidia/cuda:11.7.1-devel-ubuntu22.04
ENV PYTHONUNBUFFERED 1

# Setting up basic repo 
ARG DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Setting up working directory
ADD ./ text-generation-webui-container/
WORKDIR /text-generation-webui-container
ENV RUNNING_IN_DOCKER True
ENV CONDA_DIR "/text-generation-webui-container/conda"
ENV VENV_DIR "/text-generation-webui-container/venv"
COPY . .

# Install prerequisits
RUN apt-get update && apt-get install -y apt-utils \
    software-properties-common \
    build-essential wget curl git nano ffmpeg libsm6 libxext6 \
    p7zip-full p7zip-rar \
    python3-pip python3-venv && apt-get clean -y

# Download and install miniconda
RUN curl -Lk "https://repo.anaconda.com/miniconda/Miniconda3-py310_23.1.0-1-Linux-x86_64.sh" > "miniconda_installer.sh" \
    && chmod u+x "miniconda_installer.sh" \
    && /bin/bash "miniconda_installer.sh" -b -p "$CONDA_DIR" \
    && echo "Installed miniconda version:" \
    && "${CONDA_DIR}/bin/conda" --version

# Create conda environment
RUN "${CONDA_DIR}/bin/conda" create -y -k --prefix "$VENV_DIR" python=3.10

# Networking
ENV PORT 7860
EXPOSE $PORT

# Setting up text-generation-webui
RUN /bin/bash /text-generation-webui-container/install.sh

# Start text-generation-webui
CMD ["python3", "/text-generation-webui-container/link_shared_models.py", "&&", "/bin/bash", "/text-generation-webui-container/run_webui.sh"]
