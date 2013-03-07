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
  include adium

  package {
    [
     'bash-completion',
     'tmux',
     ]:
  }

  $homedir = "/Users/${::luser}"

  file { "${homedir}/.profile":
    content => template("people/${::github_login}/profile.sh"),
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

  class plist( $github_login, $dirs, $app, $plist) {

    file { $dirs:
      ensure => directory,
    }

    $plist_path = "${dirs[-1]}/${plist}"
    $plist_template_path = "people/${github_login}/${app}/${plist}"

    file { $plist_path:
      content => template($plist_template_path)
    }

  }

  class adium_accounts_plist {
    class { 'plist':
      github_login => $::github_login,
      dirs => [
        "${application_support_dir}/Adium 2.0",
        "${application_support_dir}/Adium 2.0/Users",
        "${application_support_dir}/Adium 2.0/Users/Default",
      ],
      app => 'adium',
      plist => 'Accounts.plist',
    }
  }

  class adium_login_preferences_plist {
    class { 'plist':
      github_login => $::github_login,
      dirs => [
        "${application_support_dir}/Adium 2.0",
      ],
      app => 'adium',
      plist => 'Login Preferences.plist',
    }
  }

  include adium_accounts_plist
  include adium_login_preferences_plist

}