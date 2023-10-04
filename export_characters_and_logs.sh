#!/bin/bash
#################################################
# Script for exporting character data.
#################################################

# character exporter v0.1

CURRENT_TS=$(date '+%Y_%b_%d-(%H-%M-%S)')
EXPORT_PATH="/text-generation-webui-container/text_generation_characters/EXPORTED"
if [[ ! -d "${EXPORT_PATH}" ]]
then
    mkdir "${EXPORT_PATH}"
fi
cd EXPORT_PATH
if [[ ! -d "${CURRENT_TS}" ]]
then
    mkdir "${CURRENT_TS}"
fi
EXPORT_TS_PATH="${EXPORT_PATH}/${CURRENT_TS}"

cp -R "/text-generation-webui-container/text-generation-webui/characters" $EXPORT_TS_PATH
cp -R "/text-generation-webui-container/text-generation-webui/logs" $EXPORT_TS_PATH

7z a -sdel "${EXPORT_PATH}/${CURRENT_TS}.7z" $EXPORT_TS_PATH
