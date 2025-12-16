<p align="center">
	<a href="https://github.com/ChrisAmelia/dotfiles">
		<img src="https://img.shields.io/github/repo-size/ChrisAmelia/dotfiles" alt="Repository Size" />
	</a>
	<a href="https://github.com/ChrisAmelia/dotfiles/blob/master/LICENSE">
		<img src="https://img.shields.io/github/license/ChrisAmelia/dotfiles" alt="Last commit" />
	</a>
	<a href="https://github.com/ChrisAmelia/dotfiles/commits/master">
		<img src="https://img.shields.io/github/last-commit/ChrisAmelia/dotfiles" alt="License" />
	</a>
</p>

# :book: Table of contents

- [Dotfiles](#open_file_folder-dotfiles)
- [Installation](#wrench-installation)
- [Screenshots](#art-screenshots)
	- [Neovim](#neovim)
- [(Neo)Vim Plugins](#bookmark_tabs-neovim-plugins)
- [Other plugins](#bookmark_tabs-other-interesting-plugins)
- [ZSH Plugins](#bookmark_tabs-zsh-plugins)
- [Firefox Plugins](#link-firefox-plugins)
- [GitHub](#link-github)
- [Reddit](#link-reddit)
- [Fonts](#ab-fonts)

# :file_folder: Dotfiles

Development setup using **Oh-My-Zsh** and **Neovim**.  
I aim to have something in-between a light and not too heavy development setup.

## :wrench: Installation

Make [install.sh](install.sh) executable and run it:

```bash
sudo chmod +x install.sh
./install.sh
```

Note: [lsd](https://github.com/lsd-rs/lsd) and [FiraCode](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode)
are not installed by this script.

## :art: Screenshots

### Neovim
![image](https://github.com/user-attachments/assets/fef6c2f6-fcfd-4c97-aefb-38faed784202)

## :bookmark_tabs: (Neo)Vim Plugins

| Category    | Plugin                                                                                | Description                                                                                                     |
| :-          | :-                                                                                    | :-                                                                                                              |
| Colors      | [nvim-colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)                  | A high-performance color highlighter for Neovim which has no external dependencies!                             |
| Colorscheme | [vim-sublime-monokai](https://github.com/ErichDonGubler/vim-sublime-monokai)          | vim-sublime-monokai is a refined Monokai color scheme for vim tries to look like Sublime's default color scheme |
| Completion  | [LuaSnip](https://github.com/L3MON4D3/LuaSnip)                                        | Snippet Engine for Neovim written in Lua.                                                                       |
| Completion  | [cmp-buffer](https://github.com/hrsh7th/cmp-buffer)                                   | nvim-cmp source for buffer words.                                                                               |
| Completion  | [cmp-nvim-lsp-signature-help](https://github.com/hrsh7th/cmp-nvim-lsp-signature-help) | nvim-cmp source for displaying function signatures with the current parameter emphasized.                       |
| Completion  | [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)                               | nvim-cmp source for neovim's built-in language server client.                                                   |
| Completion  | [cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua)                               | nvim-cmp source for neovim Lua API.                                                                             |
| Completion  | [cmp-path](https://github.com/hrsh7th/cmp-path)                                       | nvim-cmp source for filesystem paths.                                                                           |
| Completion  | [cmp-vsnip](https://github.com/hrsh7th/cmp-vsnip)                                     | nvim-cmp source for vim-vsnip.                                                                                  |
| Completion  | [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip)                            | luasnip completion source for nvim-cmp                                                                          |
| Completion  | [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim)                 | AI-powered coding, seamlessly in Neovim                                                                         |
| Completion  | [nvim-autopairs](https://github.com/windwp/nvim-autopairs)                            | A super powerful autopair plugin for Neovim that supports multiple characters.                                  |
| Completion  | [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)                                       | A completion plugin for neovim coded in Lua.                                                                    |
| Completion  | [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)                          | Use treesitter to auto close and auto rename html tag                                                           |
| Completion  | [vim-vsnip-integ](https://github.com/hrsh7th/vim-vsnip-integ)                         | Snippet completion/expansion.                                                                                   |
| Completion  | [vim-vsnip](https://github.com/hrsh7th/vim-vsnip)                                     | VSCode(LSP)'s snippet feature in vim.                                                                           |
| Finder      | [LeaderF](https://github.com/Yggdroot/LeaderF)                                        | An efficient fuzzy finder that helps to locate files, buffers, mrus, gtags, etc. on the fly.                    |
| Finder      | [fzf-lua](https://github.com/ibhagwan/fzf-lua)                                        | Improved fzf.vim written in lua                                                                                 |
| Finder      | [nvim-spectre](https://github.com/nvim-pack/nvim-spectre)                             | Find the enemy and replace them with dark power.                                                                |
| Formatting  | [vim-easy-align](https://github.com/junegunn/vim-easy-align)                          | A simple, easy-to-use Vim alignment plugin.                                                                     |
| Git         | [fugitive.vim](https://github.com/tpope/vim-fugitive)                                 | Git wrapper                                                                                                     |
| Git         | [vim-gitgutter](https://github.com/airblade/vim-gitgutter)                            | A Vim plugin which shows a git diff in the sign column.                                                         |
| Interface   | [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)       | Indent guides on blank lines for Neovim                                                                         |
| Interface   | [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)  | Plugin to improve viewing Markdown files in Neovim                                                              |
| Interface   | [tiny-glimmer.nvim](https://github.com/rachartier/tiny-glimmer.nvim)                  | Smooth customizable animations to text operations like yank, paste, search, undo/redo, and more.                |
| LSP         | [fidget.nvim](https://github.com/j-hui/fidget.nvim)                                   | Extensible UI for Neovim notifications and LSP progress messages.                                               |
| LSP         | [lsp-status.nvim](https://github.com/nvim-lua/lsp-status.nvim)                        | Neovim plugin/library for generating statusline components from the built-in LSP client.                        |
| LSP         | [nvim-eldoc](https://github.com/sj2tpgk/nvim-eldoc)                                   | Eldoc for Neovim!                                                                                               |
| LSP         | [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)                              | Extensions for the built-in LSP support in Neovim for `eclipse.jdt.ls`                                          |
| LSP         | [nvim-lsp-endhints](https://github.com/chrisgrieser/nvim-lsp-endhints)                | Display LSP inlay hints at the end of the line, rather than within the line.                                    |
| LSP         | [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)                            | Collection of common configurations for the Nvim LSP client.                                                    |
| LSP         | [rustaceanvim](https://github.com/mrcjkb/rustaceanvim)                                | Supercharge your Rust experience in Neovim!                                                                     |
| Parser      | [hlargs.nvim](https://github.com/m-demare/hlargs.nvim)                                | Highlight arguments' definitions and usages, asynchronously, using Treesitter.                                  |
| Parser      | [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)                 | Treesitter configurations and abstraction layer for Neovim.                                                     |
| Statusline  | [status-line.lua](nvim/lua/status-line.lua)                                           | Custom statusline, see screenshot                                                                               |
| Tabs        | [barbar.nvim](https://github.com/romgrk/barbar.nvim)                                  | Tabs, as understood by any other editor.                                                                        |
| Testing     | [neotest](https://github.com/nvim-neotest/neotest)                                    | An extensible framework for interacting with tests within NeoVim                                                |

## :bookmark_tabs: Other interesting plugins

| Category       | Plugin                                                                          | Description                                           |
| :-             | :-                                                                              | :-                                                    |
| Fading Buffers | [vimade](https://github.com/TaDaa/vimade)                                       | Fade your inactive buffers                            |
| Integration    | [vim-test](https://github.com/janko/vim-test)                                   | Run your tests at the speed of thought                |
| Interface      | [scrollbar.nvim](https://github.com/Xuyuanp/scrollbar.nvim)                     | scrollbar for neovim(nightly)                         |

## :bookmark_tabs: ZSH Plugins

| Plugin                                                                          | Description                                                    |
| :-                                                                              | :-                                                             |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)         | Suggest commands as you type based on history and completions. |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Provide syntax highlighting for the shell zsh.                 |

## :link: Firefox Plugins

| Plugin                                                                              | Description                                                                                        |
| :-                                                                                  | :-                                                                                                 |
| [Flagfox](https://addons.mozilla.org/en-US/firefox/addon/flagfox)                   | Display a flag icon indicating the current webserver's physical location.                          |
| [Ghostery](https://addons.mozilla.org/en-US/firefox/addon/ghostery)                 | Block ads, stop trackers and speed up websites.                                                    |
| [Grammarly](https://addons.mozilla.org/en-US/firefox/addon/grammarly-1)             | Make sure your messages, documents, and social media posts are clear, mistake-free, and impactful. |
| [HTTPS Everywhere](https://addons.mozilla.org/en-US/firefox/addon/https-everywhere) | Protect your communications by enabling HTTPS encryption.                                          |
| [New Tab Tools](https://addons.mozilla.org/en-US/firefox/addon/new-tab-tools)       | Customizes the new tab page.                                                                       |
| [Tree Style Tabs](https://addons.mozilla.org/en-US/firefox/addon/tree-style-tab)    | Show tabs like a tree.                                                                             |
| [UBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin)       | An efficient blocker: easy on memory and CPU footprint.                                            |

## :link: GitHub

| Project                                                | Description                                                                                  |
| :-                                                     | :-                                                                                           |
| [Neovim](https://github.com/neovim/neovim)             | Vim-fork focused on extensibility and usability.                                             |
| [Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh) | Oh My Zsh is an open source, community-driven framework for managing your zsh configuration. |
| [lsd](https://github.com/lsd-rs/lsd)                   | The next gen ls command                                                                      |

## :link: Reddit

| Reddit                                    | Description                                       |
| :-                                        | :-                                                |
| [Vim](https://www.reddit.com/r/vim/)      | For Vim enthusiasts and anyone interested in Vim. |
| [Neovim](https://www.reddit.com/r/neovim) | vim out of the box — http://neovim.org/           |

## :ab: Fonts

[FiraCode](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode)
