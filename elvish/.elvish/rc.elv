# Modules ──────────────────────────────────────────────────────────────────────

use epm
use re

epm:install\
  &silent-if-installed=$true\
  github.com/alexherbo2/command-duration.elv\
  github.com/zzamboni/elvish-completions\
  github.com/zzamboni/elvish-modules\
  github.com/tylerreckart/gondolin

use github.com/alexherbo2/command-duration.elv/lib/command-duration
use github.com/zzamboni/elvish-modules/alias
use github.com/tylerreckart/gondolin/gondolin

# Language
E:LANG = en_US.UTF-8

# Environment variables ────────────────────────────────────────────────────────
E:OSTYPE = (uname -s)
E:XDG_CONFIG_HOME = $E:HOME"/.config"
E:XDG_CACHE_HOME = $E:HOME"/.cache"
E:XDG_DATA_HOME = $E:HOME"/.local/share"
E:DOTFILES = $E:HOME"/.dotfiles"
E:GOPATH = $E:HOME"/.go"
E:PROJECTS = $E:HOME"/Sites/dev"
E:PERSONAL_STORAGE = $E:HOME"/Box Sync"
E:PERSONAL_ENVS = $E:PERSONAL_STORAGE"/dotfiles/zsh_personal"

if (test -x /usr/local/bin/brew) {
  E:HOMEBREW_ROOT = (/usr/local/bin/brew --prefix)
} else {
  E:HOMEBREW_ROOT = $E:HOME"/usr/local"
}

# Libraries
PYTHON2 = [(put ~/Library/Python/2.*)][-1]
PYTHON3 = [(put ~/Library/Python/3.*)][-1]


# Until yarn fixes itself & link binaries to '/usr/local/bin'
# $(${HOMEBREW_ROOT:-/usr/local}/bin/python3 -m site --user-base)/bin(N-/)
# $(${HOMEBREW_ROOT:-/usr/local}/bin/python2 -m site --user-base)/bin(N-/)
paths = [
  $E:DOTFILES"/bin"
  ./node_modules/.bin
  $E:HOMEBREW_ROOT"/opt/python/libexec/bin"
  /usr/local/{bin,sbin}
  $E:HOMEBREW_ROOT"/opt/coreutils/libexec/gnubin"
  $E:XDG_CONFIG_HOME"/yarn/global/node_modules/.bin"
  $E:HOME"/.cargo/bin"
  $E:GOPATH"/bin"
  $PYTHON3"/bin"
  $PYTHON2"/bin"
  $@paths
]


# Applications
E:TERMINAL = kitty
if (eq $E:OSTYPE 'Darwin') {
  E:BROWSER='open'
}


if (has-external nvim) {
  E:EDITOR = nvim
  E:MANPAGER="nvim +'set ft=man' -"
} elif (has-external vim) {
  E:EDITOR = vim
  E:MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man' -\""
} else {
  E:MANPAGER='less'
}

E:MANWIDTH=120
# E:MANPATH = [
#   $E:HOMEBREW_ROOT"/opt/coreutils/libexec/gnuman"
#   $@manpath
# ]

E:VISUAL = $E:EDITOR
E:GIT_EDITOR = $E:EDITOR
E:PAGER = less
E:LESS='-F -g -i -M -R -S -w -X -z-4'

if (or (has-external lesspipe) (has-external lesspipe.sh)) {
  E:LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
}

E:KEYTIMEOUT=1
E:GPG_TTY=(tty)

E:RIPGREP_CONFIG_PATH=$E:DOTFILES"/misc/.rgrc"
FZF_CMD='fd --hidden --follow --no-ignore-vcs --exclude ".git/*" --exclude "node_modules/*"'
E:FZF_DEFAULT_OPTS='--min-height 30 --height 50% --reverse --tabstop 2 --multi --margin 0,3,3,3 --preview-window wrap'
E:FZF_DEFAULT_COMMAND=$FZF_CMD" --type f"
E:FZF_CTRL_T_COMMAND=$FZF_CMD
E:FZF_CTRL_T_OPTS='--preview "(highlight -O ansi -l {} || cat {} || tree -C {}) 2> /dev/null | head -200" --bind "?:toggle-preview"'
E:FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"
E:FZF_ALT_C_COMMAND=$FZF_CMD" --type d ."
E:FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
E:FZF_VIM_LOG=(git config --get alias.l | awk '{$1=""; print $0;}' | tr -d '\r')

E:HOMEBREW_INSTALL_BADGE="⚽️"
E:HOMEBREW_NO_ANALYTICS=1
E:HOMEBREW_FORCE_BREWED_GIT=1
E:WEECHAT_PASSPHRASE=(security find-generic-password -g -a weechat 2>&1| perl -e 'if (<STDIN> =~ m/password: \"(.*)\"$/ ) { print $1; }')
# `cd ~df` or `z ~df`
# hash -d df=~/.dotfiles

SYMBOLS=[
"λ"
"ϟ"
"▲"
"∴"
"→"
"»"
"৸"
]

E:PURE_PROMPT_SYMBOL=$SYMBOLS[(randint 0 (count $SYMBOLS))]
E:PURE_GIT_BRANCH=" "


E:PYTHONSTARTUP=$E:HOME"/.pyrc.py"

# di directories
# ex executable files
# fi regular files
# ln symlinks
# ur,uw,ux user permissions
# gr,gw,gx group permissions
# tr,tw,tx others permissions
# sn the numbers of a file's size
# sb the units of a file's size
# uu user that is you
# un user that is someone else
# gu a group that you belong to
# gn a group you aren't a member of
# ga new file in Git
# gm a modified file in Git
# gd a deleted file in Git
# gv a renamed file in Git
# da a file's date
E:EXA_COLORS="uu=38;5;249:un=38;5;241:gu=38;5;245:gn=38;5;241:da=38;5;245:sn=38;5;7:sb=38;5;7:ur=38;5;3;1:uw=38;5;5;1:ux=38;5;1;1:ue=38;5;1;1:gr=38;5;3:gw=38;5;5:gx=38;5;1:tr=38;5;3:tw=38;5;1:tx=38;5;1:di=38;5;12:ex=38;5;7;1:*.md=38;5;229;4:*.png=38;5;208:*.jpg=38;5;208:*.gif=38;5;208"

# Prompt ───────────────────────────────────────────────────────────────────────

# ❯ echo Tchou                       alex at othala in ~/configuration on master

# edit:prompt = {
#   put $E:PURE_PROMPT_SYMBOL" "
# }

# edit:rprompt = {
#   edit:styled (whoami) magenta
#   put ' at '
#   edit:styled (hostname) yellow
#   put ' in '
#   edit:styled (tilde-abbr $pwd) green
#   try {
#     branch = $E:PURE_GIT_BRANCH" "(git rev-parse --abbrev-ref HEAD)
#     status = (git status --porcelain | slurp)
#     put ' on '
#     edit:styled $branch magenta
#     # [?] → Unstaged changes
#     # [!] → Ready to commit
#     if (re:match '(?m)^.\S' $status) {
#       edit:styled '?' green
#     } elif (re:match '(?m)^.\s' $status) {
#       edit:styled '!' green
#     }
#   } except { } 2> /dev/null
# }

# Hooks ────────────────────────────────────────────────────────────────────────

# Display user-friendly durations
# edit:before-readline = [
#   $@edit:before-readline
#   {
#     if (> $command-duration:value 60) {
#       echo (edit:styled (
#         printf 'Finished in %s (%s)' \
#           (friendly-duration (* $command-duration:value 1000)) \
#           (date +'%a %-d %b %-I:%M %p') \
#       ) cyan) > /dev/tty
#     }
#   }
# ]

# # Commands ─────────────────────────────────────────────────────────────────────

# # Hit Enter to repeat last command
# fn enter {
#   last-command = [(edit:command-history)][-1][cmd]
#   if (eq '' $edit:current-command) {
#     edit:current-command = $last-command
#   }
#   edit:smart-enter
# }

# # Thanks to Diego Zamboni to show me the initial implementation,
# # on #elvish the 2018-03-14 at 17:40:20.
# # https://github.com/zzamboni

# # Project
# fn project {
#   attach -tag Terminal elvish > /dev/null
#   attach -tag Git elvish > /dev/null
#   attach -tag Editor kak
# }

# # GTD
# fn diary {
#   try {
#     socket = (i3 --get-socketpath 2> /dev/null)
#     i3-msg --quiet mark Diary
#   } except error { }
#   cd ~/diary
#   attach kak (date +%Y).md
# }

# Hijack
alias:new cp cp -i
alias:new ln ln -i
alias:new mkdir mkdir -p
alias:new mv mv -i
alias:new rm rm -i
alias:new type type -a
alias:new which which -a
alias:new $E:EDITOR

if (has-external htop) {
  alias:new top htop
}

if (has-external exa) {
  alias:new ll exa --tree --all --group-directories-first
} elif (has-external tree) {
  alias:new ll tree --dirsfirst -a -L 1
} else {
  alias:new ll l -d .*/ */
}

alias:new c clear
alias:new KABOOM { yarn global upgrade --latest; brew update; brew upgrade; brew prune; brew cleanup -s; brew doctor }
alias:new chromekill { ps ux | grep '[C]hrome Helper --type renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill }
alias:new emptytrash { sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash }
alias:new ip dig +short myip.opendns.com @resolver1.opendns.com
alias:new localip ipconfig getifaddr en1
alias:new ips { ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1' }
alias:new fs stat -f '%z bytes'
alias:new flushdns sudo killall -HUP mDNSResponder

if (has-external jq) {
  alias:new formatJSON jq .
} else {
  alias:new formatJSON python -m json.tool
}

alias:new dots cd $E:DOTFILES
alias:new work mx lightspeed lightspeed
alias:new play mx ϟ
alias:new cask brew cask
alias:new apache sudo apachectl

TERM_NAME = (get-env TERM)

if (has-prefix TERM_NAME "tmux") {
  echo "hi"
  alias:new :sp tmux split-window
  alias:new :vs tmux split-window -h
  alias:new ssh TERM=xterm-256color ssh
  alias:new vagrant TERM=xterm-256color vagrant
  alias:new brew TERM=xterm-256color brew
}

if (has-external emacs) { alias:new emacs TERM=xterm-256color emacs }
if (has-external task) { alias:new t task }
if (has-external grc) { alias:new curl grc curl }
if (has-external stow) { alias:new stow stow --ignore ".DS_Store" }
if (has-external bat) { alias:new cat bat }
if (has-external python3) { alias:new server python3 -m http.server 80 }

# fn kak-connect [@arguments]{
#   try {
#     xclip -out | from-json | each [data]{
#       E:KAK_SESSION = $data[session]
#       E:KAK_CLIENT = $data[client]
#     }
#   } except error { } 2> /dev/null
#   e:kak-connect $@arguments
# }

# # Key-bindings ─────────────────────────────────────────────────────────────────

# # Navigation
# edit:insert:binding[Alt-l] = { edit:location:start }
# edit:insert:binding[Alt-n] = { edit:navigation:start }

# # Enter to repeat last command
# edit:insert:binding[Enter] = $enter~

# # Clear
# edit:insert:binding[Ctrl-l] = { clear > /dev/tty }

# # Next / Previous
# edit:insert:binding[Ctrl-n] = { edit:history:start }
# edit:history:binding[Ctrl-n] = { edit:history:down }

# edit:insert:binding[Ctrl-p] = { edit:history:start }
# edit:history:binding[Ctrl-p] = { edit:history:up }

-exports- = (alias:export)


# lib/private???
# [ -f ${PERSONAL_ENVS} ] && source ${PERSONAL_ENVS} || echo "Personal ENV variables are not loaded";

# if [ -f ${HOME}/.zshrc.local ]; then
#   source ${HOME}/.zshrc.local
# else
#   if [[ -z "${HOMEBREW_GITHUB_API_TOKEN}" && -z "${GITHUB_TOKEN}" && -z "${GITHUB_USER}" ]]; then
#     echo "These ENV vars are not set: HOMEBREW_GITHUB_API_TOKEN, GITHUB_TOKEN & GITHUB_USER. Add them to ~/.zshrc.local"
#   fi
# fi

# (( $+commands[jira] )) && eval "$(jira --completion-script-zsh)"
