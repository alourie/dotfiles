import subprocess

paru_list: list(str) = []
system_list: list(str) = []

####   terminal
system_list.extend(
    [
        "wget",
        "curl",
        "unzip",
        "fd",
        "fzf",
        "ripgrep",
        "zoxide",
        "bat",
        "wl-clipboard",
        "fastfetch",
        "man",
        "less",
        "whois",
        "plocate",
        "ghostty",
        "starship",
    ]
)

####   backgrounds
# CURRENTLY NOOP

####   base
system_list.extend(["pass", "qpdf", "base-devel"])

####   bluetooth
# Install bluetooth controls
system_list.extend(
    [
        "bluez",
        "bluez-utils",
    ]
)

####   desktop
system_list.extend(
    [
        "brightnessctl",
        "playerctl",
        "pamixer",
        "pavucontrol",
        "wireplumber",
        "wl-clip-persist",
        "nautilus",
        "sushi",
        "evince",
        "imv",
        "mpv",
    ]
)

####   development
system_list.extend(
    [
        "clang",
        "llvm",
        "imagemagick",
        "postgresql-libs",
        "git-delta",
        "github-cli",
        "podman",
        "jre-jetbrains",
    ]
)

# Maybe with mise?
# system_list.extend(
#     "nodejs",
#     "npm"
# )

####   fonts
paru_list.extend(
    [
        "ttf-jetbrains-mono-nerd",
        "nerd-fonts-inter",
    ]
)

####   nvim
system_list.extend(
    [
        "neovim",
        "luarocks",
        "tree-sitter-cli",
        "tree-sitter",
    ]
)

####   power
# Setting the performance profile can make a big difference. By default, most systems seem to start in balanced mode,
# even if they're not running off a battery. So let's make sure that's changed to performance.
system_list.extend(
    [
        "power-profiles-daemon",
    ]
)

# if ls /sys/class/power_supply/BAT* &>/dev/null; then
#   # This computer runs on a battery
#   powerprofilesctl set balanced
# else
#   # This computer runs on power outlet
#   powerprofilesctl set performance
# fi

####   printer
# paru_list.extend(
#     "cups","cups-pdf","cups-filters","system-config-printer",
# )
# sudo systemctl enable --now cups.service

####   sway
system_list.extend(
    [
        "mako",
        "uwsm",
        "libnewt",
        "xdg-desktop-portal-gtk",
        "sway",
        "swaybg",
        "swaylock",
        "swayidle",
        "noctalia",
    ]
)

####   theme
# Use dark mode for QT apps too (like VLC and kdenlive)
system_list.extend(
    [
        "qt6ct",
    ]
)

# Prefer dark mode everything
# sudo pacman -S --noconfirm gnome-themes-extra # Adds Adwaita-dark theme
# gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
# gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

####   xtras
# paru -S --noconfirm --needed \
#   libreoffice
# paru_list.extend("gum")


def run(cmd: str):
    # print(cmd.split(" "))
    print(subprocess.check_output(cmd.split(" "), text=True).strip())


def paru():
    run(f"paru -Sy --noconfirm --needed {' '.join(paru_list)}")


def pacman():
    run(f"sudo pacman -Sy --noconfirm --needed {' '.join(system_list)}")


def install_arch():
    paru()
    pacman()

    # Turn on bluetooth by default
    run("sudo systemctl enable --now bluetooth.service")

    ####   mimetypes
    run("update-desktop-database ~/.local/share/applications")

    # Open all images with imv
    (
        run(f"xdg-mime default imv.desktop ${format}")
        for format in (
            "image/jpeg",
            "image/gif",
            "image/webp",
            "image/bmp",
            "image/tiff",
        )
    )

    # Open PDFs with the Document Viewer
    run("xdg-mime default org.gnome.Evince.desktop application/pdf")

    # Containers? Clarify
    run("sudo sysctl kernel.unprivileged_userns_clone=1")

    # select default session for uwsm
    run("uwsm select")


if __name__ == "__main__":
    install_arch()
