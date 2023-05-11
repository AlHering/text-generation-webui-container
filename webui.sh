#!/bin/bash

MODEL_DIR="/oobabooga-webui-container/text-generation-webui/models"
cd "$MODEL_DIR"
MODEL_FILE_COUNT=$(("ls -A | wc -l"))

if [ $MODEL_FILE_COUNT -gt 2 ]; then
    echo "Models found. Use '/oobabooga-webui-container/link_shared_models.sh' to relink models from shared storage."
else
    bash /oobabooga-webui-container/link_shared_models.sh
fi

source /oobabooga-webui-container/venv/bin/activate
cd /oobabooga-webui-container/text-generation-webui
python server.py --auto-devices --chat --xformers --model-menu
