# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
#bindkey -e
export EDITOR=vim

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# promote start new line
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="↱"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="↳ "
#POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="λ"
#POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="> "
# 新的命令与上面的命令隔开一行
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

source ~/powerlevel10k/powerlevel10k.zsh-theme

# autojump
[[ -s /home/wujing/.autojump/etc/profile.d/autojump.sh ]] && source /home/wujing/.autojump/etc/profile.d/autojump.sh ]]
alias tnew="tmux new -s"
alias ll="ls -al"
export ANACONDAPATH=$HOME/anaconda3/bin
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export RUSTPATH=$HOME/.cargo/bin
export JAVA_HOME=/usr/local/jdk1.8.0_221
export JRE_HOME=$JAVA_HOME/jre
# for scala
export SBT_HOME=/usr/local/sbt
export BOOST_INCLUDE=/usr/local/include
export BOOST_LIB=/usr/local/lib
export PATH=$BOOST_LIB:$SBT_HOME/bin:$JAVA_HOME/bin:$ANACONDAPATH:$RUSTPATH:$GOROOT/bin:$GOPATH/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export TERM="screen-256color"
export DISABLE_AUTO_TITLE='true'

# for autosuggestions dependency
#antigen bundle zsh-users/zsh-autosuggestions

plugins=(
  git 
  autojump 
  vi-mode 
  zsh-autosuggestions
)

#source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=11,bg=gray,bold,underline"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
