# Requirements
* Neovim 0.9+ (https://neovim.io)
* Nerd Fonts (https://nerdfonts.com)
* Git (https://git-scm.com)
* Node and NPM (https://nodejs.org)

# Installation
<details>
<summary>Unix</summary>
<br>

Clone this repository using Git:
```
git clone https://github.com/king-of-ducks/nvim.git ~/.config/nvim
```

Remove `README.md` (optionally)
```
cd ~/.config/nvim
rm README.md
```
</details>

<details>
<summary>Windows (PowerShell)</summary>
<br>

`Not made yet, sorry :(`
</details>

# Usage
## Installing Plugins
Open Neovim to install all the plugins
```
nvim
```
(If Lazy.nvim hasn't opened automatically, do this command)
```
:Lazy install
```

## Managing CMP.nvim
CMP is a plugin that adds autocomplete. In this config, by default, language server set to `clangd`. It's located at last line in `init.lua`. It looks like this:
```
require('lspconfig')['clangd'].setup { capabilities = capabilities}
```

If you want to set your language server, change `clangd` to another language server. You can install servers using `NPM`, like this:
```
npm install -g <YOUR_LS_NAME>
```
