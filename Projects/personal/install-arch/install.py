import os
import subprocess

paru_list: list(str) = []
system_list: list(str) = []

#   terminal/basic
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
        "tmux",
        "kubectl",
        "pass",
        "base-devel",
        "starship",
    ]
)

# backup
system_list.extend(["borg", "borgmatic"])

#   backgrounds
# CURRENTLY NOOP

#   bluetooth
# Install bluetooth controls
system_list.extend(
    [
        "bluez",
        "bluez-utils",
    ]
)

#   desktop
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

#   development
system_list.extend(
    [
        "clang",
        "llvm",
        "imagemagick",
        "postgresql-libs",
        "git-delta",
        "github-cli",
        "podman",
    ]
)
paru_list.append("jre-jetbrains")

# Maybe with mise?
# system_list.extend(
#     "nodejs",
#     "npm"
# )

#   fonts
paru_list.extend(
    [
        "ttf-jetbrains-mono-nerd",
        # "nerd-fonts-inter",
    ]
)

#   nvim
system_list.extend(
    [
        "neovim",
        "luarocks",
        "tree-sitter-cli",
        "tree-sitter",
    ]
)

#   power
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

#   printer
# paru_list.extend(
#     "cups","cups-pdf","cups-filters","system-config-printer",
# )
# sudo systemctl enable --now cups.service

#   sway
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

#   theme
# Use dark mode for QT apps too (like VLC and kdenlive)


# extras
system_list.extend(["qt6ct", "qpdf"])

# Prefer dark mode everything
# sudo pacman -S --noconfirm gnome-themes-extra # Adds Adwaita-dark theme
# gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
# gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

#   xtras
# paru -S --noconfirm --needed \
#   libreoffice
# paru_list.extend("gum")


def run(cmd: str, with_output: bool = False) -> str:
    # print(cmd.split(" "))
    out = subprocess.check_output(cmd.split(" "), text=True).strip()
    print(out)
    return out if with_output else ""


def paru():
    run(f"paru -Sy --noconfirm --needed {' '.join(paru_list)}")


def pacman():
    run(f"sudo pacman -Sy --noconfirm --needed {' '.join(system_list)}")


def install_arch():
    paru()
    pacman()

    # Turn on bluetooth by default
    run("sudo systemctl enable --now bluetooth.service")

    #   mimetypes
    if os.path.exists(
        os.path.join(os.environ.get("HOME"), ".local", "share", "applications")
    ):
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
    uswm_path = os.path.join(os.environ.get("HOME"), ".config", "uswm")
    if not os.path.exists(uswm_path):
        os.mkdir(uswm_path)
    with open(os.path.join(uswm_path, "default-id"), "w") as f:
        f.writelines(["sway.desktop"])

    # Setup shell just in case
    user = run("whoami")
    run(f"sudo chsh -s /usr/bin/zsh {user}", with_output=True)


if __name__ == "__main__":
    install_arch()
