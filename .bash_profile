# remove warning about zsh being apple's preferred shell
export BASH_SILENCE_DEPRECATION_WARNING=1

# set nano as default text editor
export VISUAL="nano"
export EDITOR="nano"

# ll command
alias ll="ls -la"

# inform gpg on how to obtain decryption key for gpg private key
export GPG_TTY=$(tty)

# autocompletion for brew
eval "$(/opt/homebrew/bin/brew shellenv)"

# autocompletion for git
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# activation of autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# activation of bashrc
[ -r $HOME/.bashrc ] && source $HOME/.bashrc

export PATH="$PATH:$HOME/.local/bin"