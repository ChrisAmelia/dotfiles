# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# Path to your Oh My Zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Source .zprofile to get 'NVIM_INIT' and 'ZSHRC_CONFIG'
. ~/.zprofile

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# PLUGINS {{{
# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(

	autojump
	command-not-found
	copypath
	cp
	debian
	extract
	fancy-ctrl-z
	git
	zsh-autosuggestions
	zsh-syntax-highlighting

)
# }}}

# PROMPT {{{

# Hide username
USER=``
export DEFAULT_USER="$(whoami)"

# Time
PROMPT='%{$fg[yellow]%}[%D{%L:%M:%S}] '$PROMPT
# }}}


# ls on startup
# }}}

# ZSH-AUTOSUGGESTIONS {{{
bindkey '^ ' autosuggest-accept

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=gold,bg=magenta'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# }}}

# EXPORT {{{

# Yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Golang
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Notification for slack, known issue on Ubuntu 16.04
export ELECTRON_USE_UBUNTU_NOTIFIER=1

# Configs for nvim's lspconfig
export JDTLS_HOME=~/GitHub/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/
export JAVA_HOME=/usr/lib/jvm/java-1.17.0-openjdk-amd64/
export WORKSPACE=$HOME/workspace
# }}}

source $ZSH/oh-my-zsh.sh
PROMPT='%{$fg[yellow]%}[%D{%L:%M:%S}] '$PROMPT

# ALIAS {{{
alias ls='lsd'
alias ll='lsd -lArth --color=auto'
alias pdf='evince'
alias nv='nvim'
alias zshconfig="nvim $ZSHRC_CONFIG"
alias neoconfig="nvim $NVIM_INIT"
alias :q=exit
alias gcf="git clean -f"
alias gsf="gco . && gcf" # git super clean
alias moo="fortune | cowsay"
# }}}

# CUSTOM COMMANDS {{{

# ls after cd
function cd {
	builtin cd "$@" && ls
}

ls
