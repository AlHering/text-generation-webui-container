# -*- coding: utf-8 -*-
"""
****************************************************
*    text-generation-webui-container       *
*        (c) 2024 Alexander Hering         *
****************************************************
"""
import os
import re
from typing import List


SHARED_MODEL_FOLDER = "/text-generation-webui-container/machine_learning_models/MODELS"
SHARED_LORA_FOLDER = "/text-generation-webui-container/machine_learning_models/LORAS"
INTERNAL_MODEL_FOLDER = "/text-generation-webui-container/text-generation-webui/models/"
INTERNAL_LORA_FOLDER = "/text-generation-webui-container/text-generation-webui/loras/"
QUANT_PATTERN = r".+Q[0-9_KLMSX]{3,6}.*(\.safetensors|.gguf)"


def get_quants(files: List[str]) -> List[str]:
    """
    Function for extracting quantized model safetensors from list of files.
    :param files: List of files.
    :return: List of quantized model safetensor files.
    """
    files = [file if not (".gguf-split-" in file or ".gguf.part" in file) else file.split(".gguf")[0]+".gguf" for file in files]
    return list(set([file for file in files if re.fullmatch(QUANT_PATTERN, file) is not None]))


for root, dirs, files in os.walk(SHARED_MODEL_FOLDER, topdown=True): 
    print(root)
    if not files == ["model.txt"]:
        quants = get_quants(files)
        if quants:
            print(f"{root} -> linking separately for {quants}")
            for quant in quants:
                quant_folder = os.path.join(INTERNAL_MODEL_FOLDER, quant)
                if not os.path.exists(quant_folder):
                    os.makedirs(quant_folder)
                for file in [file for file in files if not any(file.startswith(q) for q in quants)]:
                    os.system(f"ln -sf {os.path.join(root, file)} {quant_folder}")
                for file in [file for file in files if file.startswith(quant)]:
                    os.system(f"ln -sf {os.path.join(root, file)} {quant_folder}")
        else:
            print(f"{root} -> Full linkage")
            os.system(f"ln -sf {root} {INTERNAL_MODEL_FOLDER}")
os.system(f"ln -sf {SHARED_LORA_FOLDER}/* {INTERNAL_LORA_FOLDER}")
os.system("find /text-generation-webui-container/text-generation-webui -xtype l -delete")
