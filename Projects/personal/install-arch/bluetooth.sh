# Install bluetooth controls
paru -S --noconfirm --needed bluez bluez-utils

# Turn on bluetooth by default
sudo systemctl enable --now bluetooth.service
