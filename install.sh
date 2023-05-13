#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

printf "\n%s\n" "${delimiter}"
printf "Creating and sourcing virtual environment"
printf "\n%s\n" "${delimiter}"

if [[ -f "${SCRIPT_DIR}/venv"/bin/activate ]]
then
    source "${SCRIPT_DIR}/venv"/bin/activate
else
    printf "\n%s\n" "${delimiter}"
    printf "\e[1m\e[31mERROR: Cannot activate python venv, aborting...\e[0m"
    printf "\n%s\n" "${delimiter}"
    exit 1
fi 

printf "\n%s\n" "${delimiter}"
printf "Handling GPTQ-for-LLaMa..."
printf "\n%s\n" "${delimiter}"
cd text-generation-webui/
if [[ ! -d "repositories" ]]
then
    mkdir "repositories"
fi 
cd "repositories"
git clone https://github.com/qwopqwop200/GPTQ-for-LLaMa.git -b cuda
cd "GPTQ-for-LLaMa"
git checkout 2154dff2cbe8a401f7c4ca34049c12ab44a637b0

pip install wheel ninja
pip install -r requirements.txt
python setup_cuda.py build
python setup_cuda.py install


printf "\n%s\n" "${delimiter}"
printf "Handling main webui requirements..."
printf "\n%s\n" "${delimiter}"
cd "${SCRIPT_DIR}/text-generation-webui"
pip install torch torchvision torchaudio
pip install -r requirements.txt
pip uninstall -y gradio_client && pip install -y gradio_client==0.1.0
cd "${SCRIPT_DIR}"

printf "\n%s\n" "${delimiter}"
printf "Finished installation"
printf "\n%s\n" "${delimiter}"
exit 0
