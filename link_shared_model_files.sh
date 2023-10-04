#!/bin/bash

for file in /text-generation-webui-container/machine_learning_models/MODELS/*/*.bin; do
    echo $file
    ln -sf $file /text-generation-webui-container/text-generation-webui/models/ 
done

find /text-generation-webui-container/text-generation-webui -xtype l -print -delete
