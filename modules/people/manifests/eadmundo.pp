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
  include emacs
  include slate
  include textmate
  include firefox
  #include phantomjs
  #include mongodb
  #include elasticsearch
  #include postgresql
  #include redis
  #include onepassword

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

  $sublime_installed_packages_dir = "${sublime_application_support_dir}/Installed Packages"

  $sublime_user_prefs_dir = "${sublime_packages_dir}/User"

  $sublime_dirs = [$sublime_application_support_dir, $sublime_packages_dir, $sublime_user_prefs_dir]

  file { $sublime_dirs :
    ensure => directory,
    source  => "puppet:///modules/people/${::github_login}/sublime.d/Packages/User",
    recurse => true,
  }

  file { $sublime_installed_packages_dir :
    ensure => directory,
    source => "puppet:///modules/people/${::github_login}/sublime.d/Installed Packages",
    recurse => true,
  }

  include osx::finder::unhide_library
  #include osx::dock::clear_dock
  include osx::dock::hide_indicator_lights
  include osx::global::enable_keyboard_control_access
  include osx::global::expand_print_dialog
  include osx::global::expand_save_dialog
  include osx::global::disable_key_press_and_hold
  include osx::disable_app_quarantine
  include osx::no_network_dsstores

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