#!/bin/bash
MODEL_DIR="/text-generation-webui-container/text-generation-webui/models"
cd "$MODEL_DIR"
MODEL_FILE_COUNT=$(("ls -A | wc -l"))

source "${CONDA_DIR}/etc/profile.d/conda.sh"
conda activate "$VENV_DIR"

if [ $MODEL_FILE_COUNT -gt 2 ]; then
    echo "Models found. Use '/text-generation-webui-container/link_shared_models.sh' to relink models from shared storage."
else
    python /text-generation-webui-container/link_shared_models.py
fi

cd /text-generation-webui-container/text-generation-webui
python server.py --auto-devices --chat --api
