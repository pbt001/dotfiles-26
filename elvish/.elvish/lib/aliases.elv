fn KABOOM {
  yarn global upgrade --latest
  brew update
  brew upgrade
  brew prune
  brew cleanup -s
  brew doctor
}
fn apache [@_args]{ sudo apachectl $@_args }
fn c [@_args]{ clear $@_args }
fn cask [@_args]{ brew cask $@_args }
fn chromekill {
  ps ux | grep '[C]hrome Helper --type renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs killall
}
fn cp [@_args]{ cp -i $@_args }
fn dots { cd /Users/ahmed/.dotfiles }
fn emacs [@_args]{ TERM=xterm-256color emacs $@_args }
fn emptytrash {
  sudo rm -rfv /Volumes/*/.Trashes
  sudo rm -rfv ~/.Trash
}
fn flushdns { sudo killall -HUP mDNSResponder }
fn formatJSON [@_args]{ python -m json.tool $@_args }
fn fs [@_args]{ stat -f %z bytes $@_args }
fn ip [@_args]{ dig +short myip.opendns.com @resolver1.opendns.com $@_args }
fn ips { ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1' }
fn ll [@_args]{
  if (has-external exa) {
    exa --tree --all --group-directories-first $@_args
  } elif (has-external tree) {
    tree --dirsfirst -a -L 1 $@_args
  } else {
    l -d .*/ */ $@_args
  }
}
fn ln [@_args]{ ln -i $@_args }
fn localip [@_args]{ ipconfig getifaddr en1 $@_args }
fn mkdir [@_args]{ mkdir -p $@_args }
fn mv [@_args]{ mv -i $@_args }
fn nvim [@_args]{ $@_args }
fn rm [@_args]{ rm -i $@_args }
fn server [@_args]{ python3 -m http.server 80 $@_args }
fn stow [@_args]{ stow --ignore .DS_Store $@_args }
fn t [@_args]{ task $@_args }


if (has-external htop) {
  fn top [@_args]{ htop $@_args }
}

fn type [@_args]{ type -a $@_args }
fn which [@_args]{ which -a $@_args }

fn play [@_args]{ mx ϟ $@_args }
fn work [@_args]{ mx lightspeed lightspeed $@_args }
