# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source ~/powerlevel10k/powerlevel10k.zsh-theme
source ~/almostsecret

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
setopt +o nomatch

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search


command -v kubectl &> /dev/null && source <(kubectl completion zsh)
[[ -f ~/bin/google-cloud-sdk/completion.zsh.inc ]] && source ~/bin/google-cloud-sdk/completion.zsh.inc

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

alias k='kubectl'
alias kks='kubectl -n kube-system'
alias kksgp='kubectl -n kube-system get pods -o wide'
alias kksgpp='kubectl -n kube-system get pods -o wide -l "app in (pan-mgmt,pan-ngfw)"; kubectl -n kube-system get pods -o wide -l "k8s-app in (pan-cni)"'
alias kksev='kubectl -n kube-system get events  --sort-by="{.lastTimestamp}"'
alias kp='kubectl -n prod1'
alias kpgp='kubectl -n prod1 get pods -o wide'
alias kgn='kubectl get nodes -o wide'
alias kgpv='kubectl get pv -o custom-columns=name:.metadata.name,status:.status.phase,claim.name:.spec.claimRef.name,claim.uid:.spec.claimRef.uid'
alias kgpvc='kubectl get pvc --all-namespaces -o custom-columns=ns:.metadata.namespace,name:.metadata.name,uid:.metadata.uid,volume:.spec.volumeName,capacity:.spec.resources.requests.storage,class:.spec.storageClassName'

WORDCHARS='*?-_[]~&;!#$%^(){}<>'
export PATH=$PATH:~/bin:~/bin/google-cloud-sdk/bin/
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=5000
export KUBE_EDITOR=vim

