#!/usr/bin/env python

import subprocess

# function for searching a path


def search_config_path():
    # searching dotfiles
    dotfiles_path = subprocess.run(
        ["find", "/", "-type", "d", "-name", ".dotfiles"],
        capture_output=True,
        text=True,
    )

    # deleate new line new line character
    dotfiles_path = dotfiles_path.stdout.strip()

    # searching in dotfiles a starship conf
    starship_path = subprocess.run(
        ["find", dotfiles_path, "-type", "d", "-name", "zsh_starship_conf"],
        capture_output=True,
        text=True,
    )

    # delete new line character
    starship_path = starship_path.stdout.strip()
