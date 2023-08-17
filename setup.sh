#! /bin/bash

DIR=`pwd`
FDIR="$HOME/.local/share/fonts"
TDIR="$HOME/.local/share/themes"


# install dependencies
install_dependencies() {
  packages=("herbstluftwm" "polybar" "rofi" "picom" "dunst" "kitty" "xclip" "viewnior" "brightnessctl" "git" "vim")

  for package in "${packages[@]}"; do
    if ! dpkg -l | grep -q "^ii\s*$package"; then
        echo "Installing $package..."
        if sudo apt install -y "$package"; then
          echo "$package successfully installed"
        else
          echo "$package failed to install" && exit
        fi
    else
        echo "$package is already installed."
    fi
  done
}


# install fonts
install_fonts() {
  echo -e "\n[*] Installing fonts..."
  [[ ! -d "$FDIR" ]] && mkdir -p "$FDIR"
  cp -rf $DIR/fonts/ "$FDIR"
  fc-cache -fv > /dev/null 2>&1
}


# install gtk theme
install_gtk_theme() {
  echo -e "\n[*] Installing gtk theme..."
  [[ ! -d "$TDIR" ]] && mkdir -p "$TDIR"
  cp -rf $DIR/gtk-theme/Awesthetic-dark/ "$TDIR"
}


# install icons
install_icons() {
  echo -e "\n[*] Installing icons..."
  git clone https://github.com/cutefishos/icons.git
  cd icons
  mkdir build
  cd build
  cmake ..
  make
  sudo make install
}



main() {
  clear
  install_dependencies
  install_fonts
  install_gtk_theme
  install_icons
  
  # move config files to ~/.config
  [[ -d "$HOME/.config/herbstluftwm/"]] && mv $HOME/.config/herbstluftwm/ $HOME/.config/herbstluftwm.old

  [[ -d "$HOME/.config/kitty/"]] && mv $HOME/.config/kitty $HOME/.config/kitty.old

  cp -r $DIR/herbstluftwm $DIR/kitty ~/.config
}


main



