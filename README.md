packaging-ruby-apps
===================

A straight foward example for packaging ruby apps into rpms without much fuss

Tested on Centos 6.4


1. Install a local ruby into /opt ( and include bundler )
      example: /opt/ruby-local-2.0.0-p247

2. Symlink your ruby into /usr/bin
      example: /usr/bin/ruby-local-2.0.0-p247

3. Package your apps using bundler into its own directory under /opt
      example: /opt/stash-git-pull-all

4. Make sure the App uses  the correct ruby
       example: #!/usr/bin/env ruby-local-2.0.0-p247

5. Fix the PATH, BUNDLE_GEM, use bundle exec
    To allow your app to be executed from outside its App dir




The pkg-ruby/build-ruby.sh script is used to make an rpm file for ruby

The pkg-ruby-app/build-ruby-app.sh script is used to build a self-contained ruby app
