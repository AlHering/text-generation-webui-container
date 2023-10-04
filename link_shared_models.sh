#!/bin/bash

ln -sf /text-generation-webui-container/machine_learning_models/MODELS/* /text-generation-webui-container/text-generation-webui/models/
ln -sf /text-generation-webui-container/machine_learning_models/LORAS/* /text-generation-webui-container/text-generation-webui/loras/

find /text-generation-webui-container/text-generation-webui -xtype l -print -delete
