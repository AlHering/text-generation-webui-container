#!/bin/bash

CURRENT_TS=$(date '+%Y_%b_%d-(%H-%M-%S)')
EXPORT_PATH="/oobabooga-webui-container/machine_learning_models/CHARACTERS/EXPORTED"
cd EXPORT_PATH
if [[ ! -d "${CURRENT_TS}" ]]
then
    mkdir "${CURRENT_TS}"
fi
EXPORT_TS_PATH="${EXPORT_PATH}/${CURRENT_TS}"

cp -R "/oobabooga-webui-container/text-generation-webui/characters" $EXPORT_TS_PATH
cp -R "/oobabooga-webui-container/text-generation-webui/logs" $EXPORT_TS_PATH

7z a -sdel "${EXPORT_PATH}/${CURRENT_TS}.7z" $EXPORT_TS_PATH
