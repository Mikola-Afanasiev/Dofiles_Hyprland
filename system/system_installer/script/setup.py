#!/usr/bin/env python
# Modules
import click

import apps
import setup_steps
import utils_for_script

# Click


@click.command()
@click.option(
    "-H",
    "--skip-helpers",
    is_flag=True,
    default=False,
    help="Skip checking helpers. ⚠️Warning: this could cause an error.",
)
@click.option(
    "-P",
    "--skip-packages",
    is_flag=True,
    default=False,
    help="Skip updating packages and skip installing packages.",
)
@click.option(
    "-C",
    "--skip-config",
    is_flag=True,
    default=False,
    help="Skip configs set up (zshrc, hyprland, keyboard).",
)
@click.option(
    "-CZ",
    "--skip-config-zshrc",
    is_flag=True,
    default=False,
    help="Skip zsh set up in configs.",
)
@click.option(
    "-CH",
    "--skip-config-hyprland",
    is_flag=True,
    default=False,
    help="Skip hyprland set up in configs.",
)
@click.option(
    "-CK",
    "--skip-config-keyboard",
    is_flag=True,
    default=False,
    help="Skip keyboard set up in configs.",
)
@click.option(
    "-D",
    "--debug",
    is_flag=True,
    default=False,
    help="Disable debug mode.(Log Function)",
)
# @click.pass_context
# Main function
def main(
    skip_helpers,
    skip_packages,
    skip_config,
    skip_config_zshrc,
    skip_config_hyprland,
    skip_config_keyboard,
    debug,
):
    # Debug mode change for log.py function
    setup_steps.DEBUG_MODE = debug
    # Helpers
    helpers = setup_steps.load_yaml_file(
        "script/configuration_yaml/helpers.yaml")
    standard_packages_list = setup_steps.load_yaml_file(
        "script/configuration_yaml/packages.yaml"
    )
    script_path = setup_steps.load_yaml_file(
        "script/configuration_yaml/paths.yaml")

    # Check for helpers
    if not skip_helpers:
        utils_for_script.helpers_existing(
            helpers["helpers_list"],
            script_path,
        )

    # Updating packages
    if not skip_packages:
        packages_manager = apps.PackageManager(standard_packages_list)

        packages_manager.installing_packages()

    # Configs
    if not skip_config:
        if not skip_config_zshrc:
            # Zshrc config
            setup_steps.setup_config(script_path, "zshrc", change_zsh=True)
        if not skip_config_hyprland:
            # Hyprland
            setup_steps.setup_config(script_path, "hyprland")
        if not skip_config_keyboard:
            # Keyboard
            setup_steps.setup_config(script_path, "keyboardru", keyboard=True)


if __name__ == "__main__":
    main()
