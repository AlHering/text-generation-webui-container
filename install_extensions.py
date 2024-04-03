#################################################
# Script for installing common extensions for webui.
# The additional extensions are selected based on own preferences.
#################################################

# text generation extension installer v0.1
import os


DEFAULT_CONDA_DIR = "/text-generation-webui-container/conda"
DEFAULT_VENV_DIR = "/text-generation-webui-container/venv"
EXTENSION_FOLDER = "/text-generation-webui-container/text-generation-webui/extensions"
# Format for additional extensions: (<extension repository for cloning>, <particular commit to checkout>, <extension folder name>)
ADDITIONAL_EXTENSIONS = [
]

base_cd_command = "cd /text-generation-webui-container/text-generation-webui/extensions"
for extension in ADDITIONAL_EXTENSIONS:
    print(f"Handling {extension[2]}")
    cmd = f"{base_cd_command} && git clone {extension[0]} && cd {extension[2]}"
    if os.environ.get("STRICT_EXTENSION_VERSIONING", "False") == "True":
        cmd += f" && git checkout {extension[1]}"
    os.system(cmd)

base_python_command = f"source {os.environ.get('CONDA_DIR', DEFAULT_CONDA_DIR)}/etc/profile.d/conda.sh && conda activate {os.environ.get('VENV_DIR', DEFAULT_CONDA_DIR)}"
for root, dirs, _ in os.walk(EXTENSION_FOLDER, topdown=True):
    for extension_folder in dirs:
        requirements_file = os.path.join(root, extension_folder, "requirements.txt")
        script_file = os.path.join(root, extension_folder, "script.py")
        if os.path.isfile(requirements_file):
            os.system(f"{base_python_command} && python -m pip install {requirements_file}")
        if os.path.isfile(script_file):
            os.system(f"{base_python_command} && python {script_file}")
    break

print("Finished adding extensions.")
