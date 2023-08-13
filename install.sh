#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR

printf "\n%s\n" "${delimiter}"
printf "Activating conda environment"
printf "\n%s\n" "${delimiter}"
 
if [[ -f "${CONDA_DIR}/etc/profile.d/conda.sh"  ]]
then
    source "${CONDA_DIR}/etc/profile.d/conda.sh"
else
    printf "\n%s\n" "${delimiter}"
    printf "\e[1m\e[31mERROR: Cannot initialize conda, aborting...\e[0m"
    printf "\n%s\n" "${delimiter}"
    exit 1
fi 

printf "\n%s\n" "${delimiter}"
printf "Setting up conda environment..."
printf "\n%s\n" "${delimiter}"
conda activate "$VENV_DIR"
#conda install -y -k pytorch[version=2,build=py3.10_cuda11.7*] torchvision torchaudio pytorch-cuda=11.7 cuda-toolkit ninja git -c pytorch -c nvidia/label/cuda-11.7.0 -c nvidia
pip install --no-cache-dir torchvision==0.15.2+cu117 torchaudio==2.0.2+cu117 torch==2.0.1+cu117 xformers==0.0.20 accelerate==0.21.0 --extra-index-url https://download.pytorch.org/whl/cu117

printf "\n%s\n" "${delimiter}"
printf "Handling main webui requirements..."
printf "\n%s\n" "${delimiter}"
cd "${SCRIPT_DIR}/text-generation-webui"
python -m pip install -r requirements.txt

#printf "\n%s\n" "${delimiter}"
#printf "Handling GPTQ-for-LLaMa..."
#printf "\n%s\n" "${delimiter}"

#if [[ ! -d "repositories" ]]
#then
#    mkdir "repositories"
#fi 
#cd "repositories"
#git clone https://github.com/qwopqwop200/GPTQ-for-LLaMa.git -b cuda
#cd "GPTQ-for-LLaMa"
#git checkout cad95ae8944b784f575d86baab2081d56ce82110

#python -m pip install wheel
#python -m pip install -r requirements.txt
#python -m pip install
#python setup_cuda.py build
#if [[ -f "setup_cuda.py" ]]
#then
#    mv setup_cuda.py setup.py
#fi 
#python -m pip install .

#python -m pip uninstall -y gradio_client && python -m pip install gradio_client==0.1.0
cd "${SCRIPT_DIR}"

printf "\n%s\n" "${delimiter}"
printf "Finished installation"
printf "\n%s\n" "${delimiter}"
exit 0
