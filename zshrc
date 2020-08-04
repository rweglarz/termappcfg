# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source ~/powerlevel10k/powerlevel10k.zsh-theme

autoload -U colors
colors
autoload -Uz compinit
compinit


#zstyle ':completion:*' menu select
#zstyle ':completion:*' show-ambiguity 'true'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' show-ambiguity $color[bg-red]

setopt nomenucomplete
setopt noautomenu

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search


command -v kubectl &> /dev/null && source <(kubectl completion zsh)

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

WORDCHARS='*?-_[]~&;!#$%^(){}<>'
export PATH=$PATH:~/bin
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=5000
