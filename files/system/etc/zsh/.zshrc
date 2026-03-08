# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

export AUTO_NOTIFY_THRESHOLD=60
export AUTO_NOTIFY_ENABLE_SSH=1

# Load completions
autoload -Uz compinit && compinit
autoload -Uz zmv
autoload -Uz add-zsh-hook

# Add in Powerlevel10k
 zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light Aloxaf/fzf-tab

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions
    
# zinit light zsh-users/zsh-syntax-highlighting
# zinit light zsh-users/zsh-completions

# zinit light zsh-users/zsh-autosuggestions

zinit light MichaelAquilina/zsh-auto-notify
zinit light aubreypwd/zsh-plugin-require

zinit load redxtech/zsh-kitty

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
zinit snippet OMZP::qrcode

ls_after_cd() {
  eza --icons=auto --hyperlink
}
add-zsh-hook chpwd ls_after_cd

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt autocd
# setopt correct
setopt interactivecomments
setopt glob_dots
setopt no_beep
setopt noflowcontrol
setopt prompt_subst
setopt longlistjobs
setopt nonomatch
setopt notify
setopt hash_list_all
setopt completeinword
setopt noshwordsplit

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache

zstyle ':completion:*:git-checkout:*' sort false
zstyle ":fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*" fzf-flags "--preview-window=wrap" "${FZF_TAB_DEFAULT_FZF_FLAGS[@]}"
zstyle ":fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*" fzf-preview "[[ -n \${(P)word} ]] && echo \${(P)word} || echo \<unset\>"
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --hyperlink --icons=auto $realpath'
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
zstyle ':fzf-tab:*' switch-group '<' '>'

HOMEBREW_COMMAND_NOT_FOUND_HANDLER="$(brew --repository)/Library/Homebrew/command-not-found/handler.sh"
if [ -f "$HOMEBREW_COMMAND_NOT_FOUND_HANDLER" ]; then
  source "$HOMEBREW_COMMAND_NOT_FOUND_HANDLER";
fi

# Aliases
alias ls='eza --icons=auto --hyperlink'
alias vim='nvim'
alias c='clear'
alias icat="kitten icat"
alias cat="bat"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh --cmd  cd)"


require "zoxide" "brew install zoxide" "brew"
require "eza" "brew install eza" "brew"
require "fzf" "brew install fzf" "brew"
require "bat" "brew install bat" "brew"
require "nvim" "brew install neovim" "brew"
require "bbrew" "brew install Valkyrie00/homebrew-bbrew/bbrew" "brew"
