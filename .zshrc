# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

# Starship
eval "$(starship init zsh)"

# Exports
export PATH="/opt/homebrew/opt/openjdk@25/bin/:$PATH"
export PATH="/opt/homebrew/opt/trash-cli/bin:$PATH"
export JAVA_HOME=`/usr/libexec/java_home -v 25`
export EDITOR="emacs -nw"
export VISUAL="emacs -nw"
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=44;33:cd=44;37:su=41;37:sg=46;37"

# Aliases
alias vi='nvim'
alias vim='nvim'
alias cat='ccat'
alias ls="eza --git --icons --color=auto --group-directories-first"
alias ll="eza -l --git --icons --color=auto --group-directories-first"
alias la="eza -la --git --icons --color=auto --group-directories-first"
alias disablesleep="sudo pmset -a disablesleep 1"
alias enablesleep="sudo pmset -a disablesleep 0"
alias nvim-config="cd $HOME/.config/nvim"
alias workspace="cd $HOME/workspace"
alias journal="cd $HOME/workspace/journal"
alias an="cd $HOME/ansible"
alias gitroot='cd $(git rev-parse --show-toplevel)'
alias glo='git log --oneline'
alias pip='pip3'
alias python='python3'
alias c='clear'
alias l='lazygit'
alias n='nvim .'
alias obsidian="cd $HOME/obsidian/"
alias rm='echo "This is not the command you are looking for."; false'

# Docker Aliases
alias docker-compose-up='docker-compose up --detach'
alias docker-compose-down='docker-compose down'
alias docker-system-prune='docker system prune -a'
alias docker-stop-all='docker stop $(docker ps -a -q)'
alias docker-remove-all='docker rm $(docker ps -a -q)'

# Emacs Aliases
alias e="emacsclient -t"
alias emacs-ui='emacsclient -c'
alias emacs-server-start='emacs --daemon'
alias emacs-server-stop="emacsclient -e '(kill-emacs)'"

# Start Emacs daemon if not already running
if ! emacsclient -e "(emacs-pid)" >/dev/null 2>&1; then
    emacs --daemon >/dev/null 2>&1
fi

# Zsh auto-complete customizations
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':autocomplete:*' completion-list no-popup
zstyle ':autocomplete:*' list-lines 15

# Completions
fpath=(
    /opt/homebrew/share/zsh-autocomplete/
    $fpath
)
autoload -Uz compinit
compinit

# Chord conversion
crd() {
    if [ -z "$1" ]; then
        echo "Usage: crd <file>"
        return 1
    fi

    local file="$1"
    chordpro --a2crd -o "$file" "$file"

    if [ $? -eq 0 ]; then
        echo "Converted $file in-place"
    else
        echo "Conversion failed!"
        return 1
    fi
}

# source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH="/Applications/ChordPro.app/Contents/Resources/cli:$PATH"

if [[ "$INSIDE_EMACS" = vterm* ]]; then
  source /opt/homebrew/Cellar/zsh-autosuggestions/0.7.1/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"
