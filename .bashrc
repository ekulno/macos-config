#!/bin/bash
HISTSIZE=100000
HISTFILESIZE=200000

eval "$(direnv hook bash)"

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

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

RED_LIGHT="\[\033[01;31m\]"
GREEN_LIGHT="\[\033[01;32m\]"
YELLOW_LIGHT="\[\033[01;33m\]"
BLUE_LIGHT="\[\033[01;34m\]"
NC="\[\033[00m\]"

PS1="$GREEN_LIGHT\u@\h$NC:$BLUE_LIGHT\w$RED_LIGHT\$(parse_git_branch)$YELLOW_LIGHT\$(parse_k8s_coords)$NC\$ "

if [[ $TERM==xterm* ]]; then
    # terminal tab
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
fi