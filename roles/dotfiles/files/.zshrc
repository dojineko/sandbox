# PATH
[[ -z "$ORG_PATH" ]] && export ORG_PATH="$PATH"
[[ -z "$ORG_MANPATH" ]] && export ORG_MANPATH="$MANPATH"
export PATH="$ORG_PATH"
export MANPATH="$ORG_MANPATH"

# local/bin
[[ -d $HOME/.local/bin ]] || mkdir -p $HOME/.local/bin
export PATH="$HOME/.local/bin:$ORG_PATH"

# Alias
alias sudo='sudo -E'
alias grep='grep --color'
alias ls='ls --color=auto --show-control-chars'
alias ll='ls -l'

# PS1 (Redhat Style)
PS1="[${USER}@${HOST%%.*} %1~]%(!.#.$) "

# history
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt EXTENDED_HISTORY

# history search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# zplug
[[ -f ~/.zplug/init.zsh ]] || { curl -sL zplug.sh/installer | zsh }
source ~/.zplug/init.zsh
zplug "zplug/zplug"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "lib/theme-and-appearance", from:oh-my-zsh
zplug "themes/agnoster", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh, if:"(( $+commands[git] ))"
zplug "mollifier/anyframe"
zplug "motemen/ghq", as:command, from:gh-r, rename-to:ghq
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "github/hub", as:command, from:gh-r, rename-to:hub

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

# disable auto_cd
unsetopt AUTO_CD

# PS1 NL
PS1="$PS1
%(!.#.$) "

# Anyframe
zstyle ":anyframe:selector:" use fzf
zstyle ":anyframe:selector:fzf:" command 'fzf -e'
bindkey '^xb' anyframe-widget-cdr
bindkey '^x^b' anyframe-widget-checkout-git-branch
bindkey '^xr' anyframe-widget-execute-history
bindkey '^x^r' anyframe-widget-execute-history
bindkey '^xp' anyframe-widget-put-history
bindkey '^x^p' anyframe-widget-put-history
bindkey '^xg' anyframe-widget-cd-ghq-repository
bindkey '^x^g' anyframe-widget-cd-ghq-repository
bindkey '^xk' anyframe-widget-kill
bindkey '^x^k' anyframe-widget-kill
bindkey '^xi' anyframe-widget-insert-git-branch
bindkey '^x^i' anyframe-widget-insert-git-branch
bindkey '^xf' anyframe-widget-insert-filename
bindkey '^x^f' anyframe-widget-insert-filename

# hub
which hub >/dev/null 2>/dev/null && alias git=hub

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
which anyenv >/dev/null 2>/dev/null || (
    git clone https://github.com/riywo/anyenv ~/.anyenv
)
eval "$(anyenv init -)"

# Works path
export WORKS_PATH="$HOME/works"
[[ -d "$WORKS_PATH" ]] || mkdir -p $WORKS_PATH

# Go
export GOPATH="$WORKS_PATH"
export PATH="$GOPATH/bin:$PATH"

# diff-highlight
export PATH=/usr/share/git/diff-highlight:$PATH
