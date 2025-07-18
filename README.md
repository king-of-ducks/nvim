# Hello
This is my `nvim` config. Feel free to use it, copy and modify as you want

# Requirements
* Neovim 0.9+ (https://neovim.io)
* Nerd Fonts (https://nerdfonts.com)
* Git (https://git-scm.com)

# Installation (Unix)

Clone this repository using Git:
```bash
git clone https://github.com/king-of-ducks/nvim.git ~/.config/nvim
```
<br>

Delete the `.git` folder:
```bash
cd ~/.config/nvim
rm -rf .git
```
<br>

Install LSP (optional, but recommended):
```vim
nvim -c ":MasonInstallAll"
```
(That'll install `clangd` and `pyright`)
<br><br>

# Uninstallation

Just remove `nvim` folder:
```bash
rm -rf ~/.config/nvim
```
