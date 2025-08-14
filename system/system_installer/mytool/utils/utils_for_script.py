#!/usr/bin/env python

# Modules
import os

from utils.logger.log import log

# Function for checking helpers


def helpers_existing(config_list, paths):
    # Setting variable
    helpers_missing = True

    # Check path
    for category_name, file_list in config_list.items():
        # base path to script
        base_path = paths["paths"]["python_path"].get(category_name)

        # check exist base path
        if not base_path:
            log(
                f"Missing base path for {
                    category_name}",
                level="error",
                code=3,
            )
        # normalizing base_path
        base_path = normalize_path(base_path)

        # loop for files
        for file_name in file_list:
            # Path
            exist_file = os.path.join(base_path, file_name)

            # check for existing file
            if os.path.isfile(exist_file):
                log(f"{file_name} exist", level="info")
            else:
                log(f"{file_name} doesn't exist", level="warning")
                helpers_missing = False

    # Checking for all helpers
    if helpers_missing:
        log(
            "All helpers are here, starting working...", level="success")
    else:
        log("Helpers aren't all here", level="error", code=2)


def normalize_path(path):
    # return normalizing path
    return os.path.abspath(os.path.expanduser(path))
