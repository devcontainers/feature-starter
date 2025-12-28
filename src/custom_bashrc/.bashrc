##########################################################################################
# ls Colors
##########################################################################################
export LS_OPTIONS='--color=auto'
eval "`dircolors`"

##########################################################################################
# Aliases
##########################################################################################
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -lAh'
alias rm='rm -i'
alias gs='git status -sb'
alias ga='git add -A'
alias gc='git commit'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpr='git pull --rebase'
alias pn='pnpm'

##########################################################################################
# Prompt
##########################################################################################
__bash_prompt() {
    local userpart='`export XIT=$? \
        && [ ! -z "${GITHUB_USER}" ] && echo -n "\[\033[0;32m\]@${GITHUB_USER} " || echo -n "\[\033[0;32m\]\u " \
        && [ "$XIT" -ne "0" ] && echo -n "\[\033[1;31m\]➜" || echo -n "\[\033[0m\]➜"`'
    local lightblue='\[\033[1;34m\]'
    local removecolor='\[\033[0m\]'
    PS1="${userpart} ${lightblue}\w ${removecolor}\n\$ "
    unset -f __bash_prompt
}
__bash_prompt
