#!/usr/bin/env python

import os
import subprocess

import log
import utils_for_script


class ConfigManager:
    def __init__(self, path_to_config, file_name, standard_config_path):
        self.my_config_path = os.path.join(
            utils_for_script.normalize_path(path_to_config),
            (file_name),
        )
        self.standard_config_path = utils_for_script.normalize_path(
            standard_config_path
        )

    def files_are_equal(self):
        differnce_between_files = subprocess.run(
            ["sudo", "diff", self.my_config_path, self.standard_config_path],
            capture_output=True,
            text=True,
        )
        return differnce_between_files

    def update_configs(self):
        # truncate
        truncating_configs = subprocess.run(
            ["sudo", "truncate", "-s", "0", self.standard_config_path],
            capture_output=True,
            text=True,
        )

        if truncating_configs.returncode != 0:
            return False

        subprocess.run(
            ["sudo", "chmod", "+x", self.standard_config_path],
            capture_output=True,
            text=True,
        )
        # text
        cmd = "cat '{}' >> '{}'".format(
            self.my_config_path,
            self.standard_config_path,
        )
        # replacing confings
        replacing_configs = subprocess.run(
            ["sudo", "bash", "-c", cmd],
            capture_output=True,
        )
        if replacing_configs.returncode != 0:
            log.log(replacing_configs.stderr, level="error", code=6)

            subprocess.run(
                ["sudo", "chmod", "-x", self.standard_config_path],
                capture_output=True,
                text=True,
            )
            return False

        subprocess.run(
            ["sudo", "chmod", "-x", self.standard_config_path],
            capture_output=True,
            text=True,
        )
        return True

    def sync_configs(self):
        # sync confings
        result = self.files_are_equal()

        if result.returncode == 0:
            log.log("Files are identical.", level="success")
        else:
            log.log("Files aren't identical", level="warning")
            log.log("Starting updating", level="info")
            # updating confings
            updating_configs_check = self.update_configs()
            if updating_configs_check:
                log.log("Files are identical. Success", level="success")
            else:
                log.log("Updating configs, something went wrong",
                        level="error", code=4)

    def zsh_shell_changing(self):
        # Path to shell
        shell = os.environ.get("SHELL", "")
        # check which shell
        if shell == "/usr/bin/zsh":
            log.log("You have already had zsh as shell", level="success")
        else:
            result = subprocess.run(["bash", "-c", "chsh -s $(which zsh)"])
            if result.returncode != 0:
                log.log("Error with zsh", level="error", code=5)

    @staticmethod
    def keyboardx11():
        # Keyboard
        subprocess.run(
            [
                "sudo",
                "localectl",
                "set-x11-keymap",
                "de,us,ru",
                "pc105",
                "",
                "grp:alt_shift_toggle",
            ],
            capture_output=True,
            text=True,
        )
