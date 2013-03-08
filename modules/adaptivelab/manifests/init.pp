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
    command => "defaults write com.apple.Safari AutoOpenSafeDownloads -bool NO",
    provider => shell,
    onlyif => "[[ `defaults read com.apple.Safari AutoOpenSafeDownloads` == 0 ]] && exit 1"
  }

  define plistbuddy($plist, $property, $value, $buddy_path="/usr/libexec/PlistBuddy") {

    notify { "[[ `$buddy_path -c \"Print :${property}\" ${plist}` == ${value} ]] || exit 1": }

    exec { "${plist}-${property}-${value}":
      command => "$buddy_path -c \"Set :${property} ${value}\" ${plist}",
      provider => shell,
      onlyif => "[[ `$buddy_path -c \"Print :${property}\" ${plist}` == ${value} ]] || exit 1",
    }

  }

  class enable_developer_toolbar_safari($preferences_dir) {

    adaptivelab::plistbuddy { 'enable-developer-toolbar-safari-1':
      plist => "${preferences_dir}/com.apple.Safari.plist",
      property => 'com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled',
      value => 'true',
    }

    adaptivelab::plistbuddy { 'enable-developer-toolbar-safari-2':
      plist => "${preferences_dir}/com.apple.Safari.plist",
      property => 'IncludeDevelopMenu',
      value => 'true',
    }

  }

  class disable_java_in_safari($preferences_dir) {

    adaptivelab::plistbuddy { 'disable-java-in-safari-1':
      plist => "${preferences_dir}/com.apple.Safari.plist",
      property => 'com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled',
      value => 'false',
    }

    adaptivelab::plistbuddy { 'disable-java-in-safari-2':
      plist => "${preferences_dir}/com.apple.Safari.plist",
      property => 'WebKitJavaEnabled',
      value => 'false',
    }

  }

}