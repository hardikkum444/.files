#----------theme------------
# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
autoload -U promptinit && promptinit					# autoload prompt
setopt autocd		# Automatically cd into typed directory.
#stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

##Enable git on the right side
#autoload -Uz vcs_info
#precmd_vcs_info() { vcs_info }
#precmd_functions+=( precmd_vcs_info )
#setopt prompt_subst
#RPROMPT=\$vcs_info_msg_0_
#zstyle ':vcs_info:git:*' formats '%F{yellow}(%b)%f'
#zstyle ':vcs_info:*' enable git

# Enable git on the left side
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# Set the format for the Git branch display
zstyle ':vcs_info:git:*' formats '%F{yellow}(%b)%f'
zstyle ':vcs_info:*' enable git

# Set the prompt to include the Git branch at the start
PROMPT='${vcs_info_msg_0_} %F{green}%n@%F{cyan}%m%f %F{magenta}%~%f %# '

# History:
setopt APPEND_HISTORY # adds history
setopt CORRECT
#setopt COMPLETE_IN_WORD
#setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt HIST_IGNORE_SPACE #if command started with a space, it will not get added to history.
setopt SHARE_HISTORY  # acc. to man zshoptions INC_APPEND_HISTORY should be turned off, if this is on
#setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_IGNORE_DUPS # don't record dupes in history
#setopt EXTENDED_HISTORY # add timestamps to history, not really useful.
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.config/zsh/history

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/aliasrc"

# emit OSC 7 for foot to spawn new window in same directory.
function osc7-pwd() {
    emulate -L zsh # also sets localoptions for us
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
} 
add-zsh-hook -Uz chpwd chpwd-osc7-pwd

#Speed up zsh compinit :- https://gist.github.com/ctechols/ca1035271ad134841284
#autoload -Uz compinit && compinit
autoload -Uz compinit
for dump in ~/.config/zsh/zcompdump(N.mh+24); do
  compinit
done
compinit -C

zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.
# Basic auto/tab complete:
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} #add colors in tab completion
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'  'r:|=*' 'l:|=* r:|=*' #case insensitive tab completion
#fpath=(/usr/share/zsh/site-functions $fpath)


autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
# Search backwards and forwards with a pattern
bindkey -M vicmd '/' history-incremental-pattern-search-backward
bindkey -M vicmd '?' history-incremental-pattern-search-forward

# set up for insert mode too
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward
bindkey '^D' delete-char-or-list
bindkey '^k' kill-line
bindkey "^N" history-beginning-search-forward-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^B" backward-char
#allow backspace to clear newline.
bindkey '^?' backward-delete-char
#bindkey "^F" forward-char
# bindkey "^A" beginning-of-line
bindkey "^A" vi-beginning-of-line
bindkey "^e" end-of-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "\e[27;2;13~" accept-line  # shift+return
bindkey "\e[27;5;13~" accept-line  # ctrl+return
# Use vim keys in tab complete menu:
# vi mode
bindkey -v
export KEYTIMEOUT=1
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -e
#bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
# function zle-keymap-select () {
#     case $KEYMAP in
#         vicmd) echo -ne '\e[1 q';;      # block
#         viins|main) echo -ne '\e[5 q';; # beam
#     esac
# }
zle -N zle-keymap-select
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

#cd into directory with fzf epic
#bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

#https://github.com/ohmyzsh/ohmyzsh/issues/3440
#no longer need to reload shell after installing a package
# style ':completion:*' rehash true

# Edit line in vim with ctrl-t:
autoload edit-command-line
zle -N edit-command-line
bindkey '^t' edit-command-line

# Load syntax highlighting; should be last.
#source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null

alias rid='sudo pacman -Rcns'
alias pac='sudo pacman -Sy'
alias ls='eza'
alias py='python3'
# alias l='ls -l --icons'
alias l='eza -al --icons --group-directories-first'
alias sugpu='sway --unsupported-gpu'
alias vi='nvim'
alias gfmt='gofmt -w *.go'
alias history='history 0'

# git aliases
alias gst='git status'
alias gad='git add'
alias gp='git push'
alias gc='git commit'

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

git_prompt_info() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        branch=$(git rev-parse --abbrev-ref HEAD)
        if [[ -n $(git status --porcelain) ]]; then
            echo "%{$fg[blue]%}git:%{$reset_color%}%{$fg[red]%}($branch) %{$fg[yellow]%}✗ %{$reset_color%}"
        else
            echo "%{$fg[blue]%}git:%{$reset_color%}%{$fg[green]%}($branch) %{$fg[yellow]%}%{$reset_color%}"

        fi
    fi
}

# PROMPT="%(?:%{$fg_bold[green]%}%1{➜%a :%{$fg_bold[red]%}%1{➜%} ) %{$fg[cyan]%}%c%{$reset_color%} "
PROMPT="%{$fg_bold[green]%}➜%{$reset_color%}  %{$fg[cyan]%}%c%{$reset_color%} "


PROMPT+='$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# echo -ne '\e[6 q' # beam mode cursor
# echo -ne '\e[2 q' # block mode curson 
echo -ne '\e[4 q' # underline mode cursor

preexec() { echo -ne '\e[4 q' ;}

export DOCKER_HOST=unix:///var/run/docker.sock

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
    yazi --clear-cache
}
export EDITOR=nvim
