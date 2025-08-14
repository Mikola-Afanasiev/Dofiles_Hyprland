#!/usr/bin/env python

# modules
import subprocess

from utils.logger.log import log

# Package manager


class PackageManager:
    # variable
    def __init__(self, my_packages_list):
        self.my_packages_list = my_packages_list

    def installing_packages(self):
        # system update
        self.installing_all_missing_packages()

    # all packages installed
    def get_all_installed_packages(self):
        # Variable set
        all_installed_packages = set()

        # All installed packages
        result = subprocess.run(
            ["sudo", "pacman", "-Q"], capture_output=True, text=True
        )
        # split versions and package
        if result.returncode == 0:
            for line in result.stdout.splitlines():
                package = line.split()[0]
                all_installed_packages.add(package)

        return all_installed_packages

    def get_all_missing_packages(self):
        # Variable
        missing_packages = {}
        all_installed_packages = self.get_all_installed_packages()

        # Loop
        for category, packages in self.my_packages_list.items():
            # if pkg not installed
            not_installed = [
                pkg_info
                for pkg_info in packages
                if pkg_info["package"] not in all_installed_packages
            ]
            # add into missing packages
            if not_installed:
                missing_packages[category] = not_installed

        return missing_packages

    def installing_all_missing_packages(self):
        missing_packages = self.get_all_missing_packages()

        for category, pkgs in missing_packages.items():
            log(f"Download: {category}", level="info")
            for pkg in pkgs:
                if pkg["manager"] == "pacman":
                    result = subprocess.run(
                        ["sudo", "pacman", "-S", pkg["package"], "--noconfirm"],
                        capture_output=True,
                        text=True,
                    )
                    if result.returncode != 0:
                        log(
                            f"Error: Pacman failed. {result.stderr}",
                            level="error",
                            code=7,
                        )
                        return True
                elif pkg["manager"] == "yay":
                    result = subprocess.run(
                        ["yay", "-S", pkg["package"], "--noconfirm"],
                        capture_output=True,
                        text=True,
                    )
                    error_phrases = [
                        "not found",
                        "no aur found",
                        "error installing",
                        f"no aur package found for {pkg['package']}".lower(),
                    ]
                    stderr_lower = result.stderr.lower()

                    if any(phrase in stderr_lower for phrase in error_phrases):
                        log(
                            f"Failed yay. {
                                result.stderr}",
                            level="error",
                            code=7,
                        )
                        return True
                else:
                    log(
                        "Unknown package manager: {pkg['manager']}",
                        level="error",
                        code=7,
                    )
                    return True
        return False
