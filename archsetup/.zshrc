# to change in svi
# --------------------- ZSH CONF ------------------- #

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
#--------------------------------------------------#
export ELECTRON_OZONE_PLATFORM_HINT=auto
export EDITOR=nvim
export VISUAL=nvim
export LANG=en_US.UTF-8

# export LC_TIME=en_US.UTF-8

#------------------ DART AND FLUTTER CONFI ------------------ #

export PATH="$PATH:/home/sezium/flutterSDK/flutter/bin/"

#--------------------------------------------------#

HISTFILE=~/.config/zsh/.zsh_history

SAVEHIST=1000
HISTSIZE=999

KEYTIMEOUT=1

setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
setopt globdots

bindkey '^P' history-search-backward
bindkey '^N' history-search-forward
bindkey '^[[Z' autosuggest-accept

# remove word
bindkey '^H' backward-kill-word

# bindkey '^[I' autosuggest-accept
#--------------------------------------------------#

alias vi="nvim +NvimTreeFocus"

alias nvimconf="vi ~/.config/nvim/"
alias zshconf="vi ~/.zshrc"
alias hyprconf="vi ~/.config/hypr/hyprland.conf"
alias hyprpaperconf="vi ~/.config/hypr/hyprpaper.conf"
alias kittyconf="vi ~/.config/kitty/"
alias waybarconf="vi ~/.config/waybar"
alias woficonf="vi ~/.config/wofi"
alias yaziconf="vi ~/.config/yazi"
alias fastfetchconf="vi ~/.config/fastfetch"

# paccache -r # per rimuovere tutto

alias h="history"
alias svi="sudo -e"

alias yazi="yazi pwd"

alias ls="eza --color=always --long --icons=always --no-time --no-permissions --no-user" 
alias tree="eza --color=always --long --icons=always --no-time --no-permissions --tree --no-user" 

alias ff="fastfetch"

# --all per vedere i file nascosti

#--------------------------------------------------#

source ~/.config/zsh/powerlevel10k/powerlevel10k.zsh-theme
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
