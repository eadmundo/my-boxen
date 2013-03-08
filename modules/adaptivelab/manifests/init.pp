class adaptivelab {

  include alfred
  include caffeine
  include chrome
  include dropbox
  include iterm2::stable
  include virtualbox
  include vagrant
  include wget
  include sublime_text_2
  include phantomjs
  include adium

  package {
    [
     'bash-completion',
     'tmux',
     ]:
  }

  exec { 'disable-safe-files-in-safari':
    command => "defaults write com.apple.Safari AutoOpenSafeDownloads -bool NO"
  }

}