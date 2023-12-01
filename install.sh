rpm-ostree update
rpm-ostree install git --apply-live
rpm-ostree install zsh --apply-live
rpm-ostree install nvim -apply-live
rpm-ostree install gh --apply-live

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/Monoid
cd ~

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
cp .zshrc ~/.zshrc

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.github.tchx84.Flatseal -y
flatpak install flathub com.bitwarden.desktop -y
flatpak install flathub com.brave.Browser -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub org.signal.Signal -y
flatpak install flathub com.valvesoftware.Steam -y
flatpak install flathub io.itch.itch -y
flatpak install flathub net.lutris.lutris -y

toolbox create gopher
toolbox run --container gopher sudo dnf install golang
mkdir -p $HOME/go

toolbox create rustacean
toolbox run --container rustacean $(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh)

toolbox create nodummy
toolbox run --container nodummy sudo dnf install nodejs

mkdir ~/.config/alacritty
cp alacritty.yml ~/.config/alacritty/alacritty.yml

mkdir ~/.config/nvim
cp init.lua ~/.config/nvim/init.lua

systemctl reboot
