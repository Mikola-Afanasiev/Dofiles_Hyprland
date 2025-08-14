#!/usr/bin/env python
# Modules
import yaml

import configs

# Global debug variable for log.py function
DEBUG_MODE = False

# Load yaml


def load_yaml_file(path):
    with open(path, "r") as f:
        return yaml.safe_load(f)


# Config setup


def setup_config(script_path, config_name, change_zsh=False, keyboard=False):
    config = configs.ConfigManager(
        script_path["paths"]["python_path"]["cache_files"],
        script_path["paths"][config_name]["my_config"],
        script_path["paths"][config_name]["standard_config"],
    )
    if change_zsh:
        config.zsh_shell_changing()

    if keyboard:
        configs.ConfigManager.keyboardx11()

    config.sync_configs()

    return config
