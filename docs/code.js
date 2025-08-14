// Code text
// Installention guide
// First step
const install_guide_step_first_code = `
mkdir -p ~/.config/.dotfiles/
cd ~/.config/.dotfiles/
git clone https://github.com/Mikola-Afanasiev/dotfiles_hyprland
`.trim();

// Second step
const install_guide_step_second_code = `
sudo pacman -S poetry --noconfirm
`.trim();

// Third step
const install_guide_step_third_code = `
cd ~/.config/.dotfiles/system/system_installer/script/ poetry run
python3 setup.py
`.trim();

// Apply changes with id
document.getElementById("install_guide_step_first_code").textContent =
	install_guide_step_first_code;

document.getElementById("install_guide_step_second_code").textContent =
	install_guide_step_second_code;

document.getElementById("install_guide_step_third_code").textContent =
	install_guide_step_third_code;
