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

  $application_support_dir = "${homedir}/Library/Application Support"

  $sublime_application_support_dir = "${application_support_dir}/Sublime Text 2"

  $sublime_packages_dir = "${sublime_application_support_dir}/Packages"

  $sublime_user_prefs_dir = "${sublime_packages_dir}/User"

  $sublime_dirs = [$sublime_application_support_dir, $sublime_packages_dir, $sublime_user_prefs_dir]

  file { $sublime_dirs :
    ensure => directory,
  }

  repository { $sublime_user_prefs_dir:
    source  => "${::github_login}/sublime.d",
    require => File[$sublime_dirs],
  }

}