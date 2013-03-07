class people::eadmundo {

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

  package {
    [
     'bash-completion',
     'tmux',
     ]:
  }

  $homedir = "/Users/${::luser}"

  file { "${homedir}/.profile":
    content => template("people/${::github_login}-profile.sh"),
    mode => '0644',
  }

}