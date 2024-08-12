#!/bin/bash

# configure the terminal to be remember many lines
HISTSIZE=100000
HISTFILESIZE=200000

# activate direnv
eval "$(direnv hook bash)"

# determine current git branch, if in a repo
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# determine current k8s cluster and namespace, if any
parse_k8s_coords(){
    cluster_name=$(kubectl config current-context 2> /dev/null)
    if [[ $? == 0 ]]; then
        cluster_ns=$(kubectl config view --minify -o jsonpath='{..namespace}')
        if [[ "$cluster_ns" == "" ]]; then 
            cluster_ns="default"
        fi
        echo "($cluster_name>$cluster_ns)"
    fi
}

# color/formating codes 
RED_LIGHT="\[\033[01;31m\]"
GREEN_LIGHT="\[\033[01;32m\]"
YELLOW_LIGHT="\[\033[01;33m\]"
BLUE_LIGHT="\[\033[01;34m\]"
NC="\[\033[00m\]"

# formulate bash prompt
PS1="$GREEN_LIGHT\u@\h$NC:$BLUE_LIGHT\w$RED_LIGHT\$(parse_git_branch)$YELLOW_LIGHT\$(parse_k8s_coords)$NC\$ "

# formulate terminal tab text (doesn't work for iterm2)
if [[ $TERM==xterm* ]]; then
    # terminal tab
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
fi


