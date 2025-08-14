#!/usr/bin/env python
# Modules
import sys

import yaml
import setup_steps
# List of errors
with open("script/configuration_yaml/errors_for_script.yaml") as f:
    errors = yaml.safe_load(f)

# log function


def log(text, level="info", code=None):
    # DEBUG MODE flag
    if setup_steps.DEBUG_MODE:
        return
    # colors
    colors = {
        "info": "\033[94m",
        "success": "\033[92m",
        "warning": "\033[93m",
        "error": "\033[91m",
        "reset": "\033[0m",
    }
    # color in variable
    color = colors.get(level, colors["info"])
    reset = colors["reset"]
    lang = "EN"

    # print
    print(f"{color}[{level.upper()}]: {text} {reset}")

    if code is not None:
        try:
            code_description = errors["errors"][code]["message"][lang]
            print(
                f"{color}Code: {code}. Description: {
                    code_description} {reset}"
            )
        except KeyError:
            print(f"{color}Code: {code} not found in errors{reset}")

    if level == "error" and code is not None:
        sys.exit(code)
