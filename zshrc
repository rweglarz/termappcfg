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
zstyle ':completion:*:ssh:*' hosts

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
alias kc='kubectl -n client'
alias kcgp='kubectl -n client get pods -o wide'
alias kks='kubectl -n kube-system'
alias kksgp='kubectl -n kube-system get pods -o wide'
alias kksgpp='kubectl -n kube-system get pods -o wide -l "app in (pan-mgmt,pan-ngfw)"; kubectl -n kube-system get pods -o wide -l "k8s-app in (pan-cni)"'
alias kksev='kubectl -n kube-system get events  --sort-by="{.lastTimestamp}"'
alias kl4j='kubectl -n log4j'
alias kl4jgp='kubectl -n log4j get pods -o wide'
alias kp1='kubectl -n prod1'
alias kp1gp='kubectl -n prod1 get pods -o wide'
alias kp2='kubectl -n prod2'
alias kp2gp='kubectl -n prod2 get pods -o wide'
alias kp9gp='kubectl -n prod9 get pods -o wide'
alias kgn='kubectl get nodes -o wide'
alias kgpv='kubectl get pv -o custom-columns=name:.metadata.name,status:.status.phase,claim.name:.spec.claimRef.name,claim.uid:.spec.claimRef.uid,handle:.spec.csi.volumeHandle'
alias kgpvc='kubectl get pvc --all-namespaces -o custom-columns=ns:.metadata.namespace,name:.metadata.name,uid:.metadata.uid,volume:.spec.volumeName,capacity:.spec.resources.requests.storage,class:.spec.storageClassName'
alias kgs='kubectl -n kube-system get panslotconfigs pan-mgmt-svc-slots -o json | gsed "s/{/\n{/g" | egrep config_done'
alias kcm='kubectl -n custom-metrics'
alias kgu='kubectl get pods -A -o wide -l workload=ubuntu'
alias tgt='~/bin/tf-tgt-p-a.sh'
alias tpp='terraform plan -out p1'
alias tppnr='terraform plan -refresh=false -out p1'
alias tppnrnc='terraform plan -refresh=false -no-color -out p1'
alias tpd='terraform plan -destroy -out p1'
alias tpa='terraform apply p1'
alias tpo='terraform output'
alias tpoj='terraform output -json'
alias pca='~/bin/panorama.py commit-all'
alias p1='~/bin/panorama.py --panorama-creds-file ~/pan1_creds.json'
alias p1ca='~/bin/panorama.py --panorama-creds-file ~/pan1_creds.json commit-all'
alias p1ld='~/bin/panorama.py --panorama-creds-file ~/pan1_creds.json list-devices'
alias p1lld='~/bin/panorama.py --panorama-creds-file ~/pan1_creds.json list-licensed-devices'
alias p1ls='~/bin/panorama.py --panorama-creds-file ~/pan1_creds.json list-sessions'
alias p2='~/bin/panorama.py --panorama-creds-file ~/pan2_creds.json'
alias p2ca='~/bin/panorama.py --panorama-creds-file ~/pan2_creds.json commit-all'
alias p2ld='~/bin/panorama.py --panorama-creds-file ~/pan2_creds.json list-devices'
alias p2ls='~/bin/panorama.py --panorama-creds-file ~/pan2_creds.json list-sessions'
alias p5='~/bin/panorama.py --panorama-creds-file ~/pan5_creds.json'
alias p5ca='~/bin/panorama.py --panorama-creds-file ~/pan5_creds.json commit-all'
alias p5ld='~/bin/panorama.py --panorama-creds-file ~/pan5_creds.json list-devices'
alias p5ls='~/bin/panorama.py --panorama-creds-file ~/pan5_creds.json list-sessions'
alias pr='~/bin/panorama.py --panorama-creds-file ~/panrami_creds.json'
alias tpgo='~/bin/tf-tgt-p-a.sh && ~/bin/panorama.py commit-all && terraform plan -out p1 && terraform apply p1 &&  ~/bin/panorama.py commit-all'
alias awsscg='f() { aws autoscaling set-desired-capacity --region eu-central-1 --auto-scaling-group-name $1 --desired-capacity $2 };f'
alias timestamp='gawk "{ print strftime(\"[%Y-%m-%d %H:%M:%S]\"), \$0 }"'
alias gssh='f() { h=$(shift); gcloud compute ssh $h --tunnel-through-iap --ssh-key-file ~/.ssh/id_rsa "$@" }; f'
alias gcl='gcloud compute instances list --format="table(NAME, networkInterfaces[0].networkIP:label='nic0-ip',networkInterfaces[1].networkIP:label='nic1-ip',networkInterfaces[0].accessConfigs[0].natIP:label='nic0-pub-ip',networkInterfaces[1].accessConfigs[0].natIP:label='nic1-pub-ip',tags.items.list():label=TAGS,status)"'

WORDCHARS='*?-_[]~&;!#$%^(){}<>'
export PATH=$PATH:~/bin:~/bin/google-cloud-sdk/bin/:/usr/local/bin/:/opt/homebrew/bin/:~/Library/Python/3.9/bin/
HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=5000
export KUBE_EDITOR=vim
export EDITOR=/usr/bin/vim

