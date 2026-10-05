sudo pacman -Sy --noconfirm nodejs npm 
paru -S --noconfirm --needed \
  cargo clang llvm \
  imagemagick \
  postgresql-libs \
  git-delta \
  github-cli podman 

sudo sysctl kernel.unprivileged_userns_clone=1 
