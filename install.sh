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

printf "\n%s\n" "${delimiter}"
printf "Handling main webui requirements..."
printf "\n%s\n" "${delimiter}"
conda install -y -k conda-forge::gxx_linux-64=11.2.0
#conda install -y -c nvidia/label/cuda-11.7.1 cuda-runtime
python -m pip install --no-cache-dir -r requirements_cuda117.txt


printf "\n%s\n" "${delimiter}"
printf "Finished installation"
printf "\n%s\n" "${delimiter}"
exit 0
