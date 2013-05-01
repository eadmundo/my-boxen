class people::eadmundo {

  include caffeine
  include chrome
  include dropbox
  include iterm2::stable
  include virtualbox
  include vagrant
  include wget
  include sublime_text_2
  #include emacs
  #include phantomjs
  #include nginx
  #include mongodb
  #include elasticsearch
  include textmate
  include slate
  #include postgresql
  #include redis
  include hub
  include onepassword

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

  # define plist( $github_login, $directory, $app, $plist) {

  #   $plist_path = "${directory}/${plist}"
  #   $plist_template_path = "people/${github_login}/${app}/${plist}"

  #   file { $plist_path:
  #     content => template($plist_template_path),
  #     require => Package['Adium']
  #   }

  #   $escaped_plist_path = escape_spaces($plist_path)

  #   exec { "${plist_path}-to-binary":
  #     command => "plutil -convert binary1 ${escaped_plist_path}",
  #     require => File[$plist_path]
  #   }

  # }

  # $adium_app_support_dir = "${application_support_dir}/Adium 2.0"
  # $adium_users_dir = "${adium_app_support_dir}/Users"
  # $adium_users_default_dir = "${adium_users_dir}/Default"

  # $adium_dirs = [$adium_app_support_dir, $adium_users_dir, $adium_users_default_dir]

  # file { $adium_dirs:
  #   ensure => directory,
  #   require => Package['Adium']
  # }

  # eadmundo::plist { 'adium_accounts':
  #   github_login => $::github_login,
  #   directory => $adium_users_default_dir,
  #   app => 'adium',
  #   plist => 'Accounts.plist',
  # }

  # eadmundo::plist { 'adium_login_preferences':
  #   github_login => $::github_login,
  #   directory => $adium_app_support_dir,
  #   app => 'adium',
  #   plist => 'Login Preferences.plist',
  # }

  # $preferences_dir = "${homedir}/Library/Preferences"

  # class {'adaptivelab::enable_developer_toolbar_safari':
  #   preferences_dir => $preferences_dir,
  # }

  # class {'adaptivelab::disable_java_in_safari':
  #   preferences_dir => $preferences_dir,
  # }

}