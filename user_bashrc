#
# ~/.bashrc
#
 alias ls='ls --color=auto'
 alias grep='grep --colour=auto'
# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs

umask 022

#PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
PS1='\[\e[1;36m\][\A]\[\e[1;34m\]\u@\[\e[1;33m\]\H:\[\e[1;36m\]\w\$\[\e[0m\] '
export EDITOR=/usr/bin/vim
export PAGER=/usr/bin/less

export OSSLSUBJ='-subj "/C=UA/ST=Kyiv/L=Kyiv/O=Fulcrum Rocks/CN=rancher.fulcrum.rocks"'

# History
#Чтобы одинаковые команды не сохранялись в истории:
HISTCONTROL=ignoredups
#Не добавлять запись в историю команд, если команда начинается с пробела:
HISTCONTROL=ignorespace
#стираются все повторения, в том числе идущие не подряд, но в разной последовательности. (например, после cd..ls..cd..ls останется cd и ls)
HISTCONTROL=erasedups
# Чтобы история команд сохранялась сразу после ввода (а не во время закрытия терминала)
shopt -s histappend
PROMPT_COMMAND='history -a' 

### Proxy
#export http_proxy="http://192.168.1.25:3128"
#export https_proxy=$http_proxy
#export ftp_proxy=$http_proxy
#export rsync_proxy=$http_proxy

# PATH end envs
PATH="${PATH}:/usr/bin/:${USER}/.local/bin"; export PATH;
source ~/.ssh/env

# Ansible
export ANSIBLE_INVENTORY=~/hosts
export ANSIBLE_NOCOWS=1
export ANSIBLE_CONFIG=~/.ansible.cfg

### functions

if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

function ssh() {
    if [ -z "$2" ]; then
        /usr/bin/ssh -t $1 'export PS1="\[\033[01;35m\]\u@\h\[\033[01;34m\] \W\[\033[00m\]\[\033[01;34m\] #\[\033[00m\] "; bash -i'
    else
        /usr/bin/ssh "$@"
    fi
}

if [ -f $(brew --prefix)/bash_completion.d/kubectl ]; then
   . $(brew --prefix)/bash_completion.d/kubectl
fi

# completion @2
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
# completion gcloud
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"
