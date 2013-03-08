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

  define plistbuddy($plist, $property, $value) {

    exec { "${plist}-${property}-${value}":
      command => "/usr/libexec/PlistBuddy -c \"Set :${property} ${value}\" ${plist}",
    }

  }

  class enable_developer_toolbar_safari($preferences_dir) {

    adaptivelab::plistbuddy { 'enable-developer-toolbar-safari-1':
      plist => "${preferences_dir}/com.apple.Safari.plist",
      property => 'com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled',
      value => '1',
    }

    adaptivelab::plistbuddy { 'enable-developer-toolbar-safari-2':
      plist => "${preferences_dir}/com.apple.Safari.plist",
      property => 'IncludeDevelopMenu',
      value => '1',
    }

  }

  class disable_java_in_safari($preferences_dir) {

    adaptivelab::plistbuddy { 'disable-java-in-safari-1':
      plist => "${preferences_dir}/com.apple.Safari.plist",
      property => 'com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled',
      value => '0',
    }

    adaptivelab::plistbuddy { 'disable-java-in-safari-2':
      plist => "${preferences_dir}/com.apple.Safari.plist",
      property => 'WebKitJavaEnabled',
      value => '0',
    }

  }

}