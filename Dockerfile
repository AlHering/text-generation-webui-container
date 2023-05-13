FROM nvidia/cuda:11.7.0-devel-ubuntu20.04
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
COPY . .

# Install prerequisits
RUN apt-get update && apt-get install -y apt-utils \
        software-properties-common \
        build-essential wget curl git nano ffmpeg libsm6 libxext6 \
        p7zip-full p7zip-rar \
        python3-pip python3-venv

# Create venv
RUN if [ ! -d "venv" ]; \
then \
    python3 -m venv venv; \
fi 

# Networking
ENV PORT 7860
EXPOSE $PORT

# Link shared models
RUN /bin/bash /text-generation-webui-container/link_shared_models.sh

# Setting up text-generation-webui
RUN /bin/bash /text-generation-webui-container/install.sh

# Start stable-diffusion-webui
CMD ["/bin/bash", "run_webui.sh"]
