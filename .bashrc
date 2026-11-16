# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    .bashrc                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: marisous <marisous@student.42lisb...>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/11/16 07:17:17 by marisous          #+#    #+#              #
#    Updated: 2026/11/16 07:17:47 by marisous         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# More colors!
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
PURPLE="\[\033[0;35m\]"
RESET="\[\033[0m\]"
RED='\e[0;31m'
BROWN='\e[0;33m'
# Change command prompt
source ~/.GITenv/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
export PS1="$BLUE\u@\h$RED\$(__git_ps1)$BROWN \W \n $ $RESET"

# User specific aliases and functions
alias ssh='ssh -Y'
alias cl='clear'
alias grep='grep --color=tty'
alias root='root -l'
alias greper='grep -r'
alias psm='ps -df| grep $USER'
alias PT='setxkbmap pt'
alias EN='setxkbmap us'
alias rm='rm -iv'
alias mv='mv -iv'
alias cp='cp -vp'
alias rtil='rm -f *~'
alias topu="top -u $USER -c"
alias h='history'
alias e='emacs -nw'
# alias ec="emacsclient -e '(emacs-pid)' >/dev/null 2>&1 || emacs --daemon; emacsclient -t"
# alias e="ec -nw"
alias ed="e --eval \"(mj/dark-theme)\""
alias ke="emacsclient --eval '(kill-emacs)' >/dev/null 2>&1"
alias nse='emacs -nw -q -l ~/.emacs_2'
alias mua='indexAllEmails && mu index'

export EDITOR='emacs -nw -q -l ~/.emacs_2'

# Alias to multiple ls commands
alias ls='ls --color=always' # add colors and file type extensions
alias sl='ls'
alias ll='ls -lh'
alias la='ls -A'                # show hidden files
alias lx='ll -XB'               # sort by extension
alias lk='ll -Sr'               # sort by size
alias lc='ll -cr'               # sort by change time
alias lu='ll -ur'               # sort by access time
alias lr='ll -R'                # recursive ls
alias lt='ll -tr'               # sort by date
alias lm='ll -a |more'          # pipe through='more'
alias nls='ls --color=never'    # remove ls colors
# Alias to access folders
alias cd..='cd ..'
alias cd,,='cd..'
alias ..='cd..'
alias ...='cd ../..'

# New work directory
export WORK="${HOME}/work/"
# alias cdt="cd /home/${USER}/Documents/personal/Doutoramento/TeseDoutoramento/"
alias cdw="cd $WORK"
alias cdv="cd /var/www/html/"
alias cdp='cd $WORK/Projects42/'
alias cdem="cd $WORK/myemacs/"
# Activate python enviromnent locally
alias activate='source ./{.,}*/bin/activate'

indexAllEmails(){
mu init --maildir=/home/${USER}/.Mail/ \
   --personal-address=email1@gmail.com \
   --personal-address=email2@gmail.com \
   --personal-address=email3@gmail.com
}

# Connect to the GCP instance
alias getginstances="gcloud compute instances list"
connectMyGCP(){
    local NAME=$1
    local MCSNAME=$(getginstances | grep $NAME | cut -d' ' -f1)
    local MCSERVER=$(gcloud compute instances describe $MCSNAME | grep natIP | cut -d':' -f2 | cut -d' ' -f2)
    gcloud compute ssh $MCSNAME --zone=europe-west1-b  -- -t "sudo su - ${USER}" # --command="sudo su -  ${USER}"
}

gscp() {
    local NAME="$1"
    shift
    local LISTOFFILES=("$@")
    if [ ${#LISTOFFILES[@]} -eq 0 ]; then echo "Error: No files"; return 1; fi

    local MCSNAME=$(getginstances | grep "$NAME" | awk '{print $1}')
    if [ -z "$MCSNAME" ]; then echo "Error: Instance not found"; return 1; fi
# --command="sudo su - ${USER}"
}


gscp() {
    local NAME="$1"
    shift
    local LISTOFFILES=("$@")
    if [ ${#LISTOFFILES[@]} -eq 0 ]; then echo "Error: No files"; return 1; fi

    local MCSNAME=$(getginstances | grep "$NAME" | awk '{print $1}')
    if [ -z "$MCSNAME" ]; then echo "Error: Instance not found"; return 1; fi

    gcloud compute scp "${LISTOFFILES[@]}" "$MCSNAME:~/" --zone=europe-west1-b

    # Quoted mv for spaces
    local MV_CMD="sudo mv"
    for f in "${LISTOFFILES[@]}"; do
        MV_CMD="$MV_CMD ~/'${f//\'/\'\"\'\"\'}'"  # Escape single quotes if any
    done
    MV_CMD="$MV_CMD /home/${USER}/ && sudo chown -R ${USER}:${USER} /home/${USER}/"

    gcloud compute ssh "$MCSNAME" --zone=europe-west1-b --command="$MV_CMD"
}

source ~/.GITenv/git-completion.bash


reminder_cd() {
    builtin cd "$@" && { [ ! -f .cd-reminder ] || cat .cd-reminder 1>&2; }
}
# alias cd=reminder_cd

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Added by Antigravity CLI installer
export PATH="${HOME}/.local/bin:$PATH"

export HEADER42_LOGIN=marisous
export HEADER42_MAIL=marisous@student.42lisboa.com

#################################################################################

# # Mount and unmount WSmaker for VBS
# alias mVBS='mkdir mVBS && sshfs ${USER}@${HOSTNAME}:${PATH}/VBS/ mVBS/'
# alias uVBS='fusermount -u mVBS/ && rmdir mVBS/'

# syncFromQAQC() {
#     if [ -z "$1" ]; then
# 	echo "No argument provided. Use one of these:"
# 	echo "Digital Bare"
#     else
# 	rsync -azr --exclude="data*" --exclude="Electrical*" --exclude="Configuration*" -e "ssh -J ${USER}@${PROXYHOST}"  --progress ${USER}@${MACHINEHOST}:/lab/QAQC/$1/ ~/work/IT/QAQC/$1/
#     fi
# }

# alias mongosh='OPENSSL_CONF=/dev/null mongosh'
