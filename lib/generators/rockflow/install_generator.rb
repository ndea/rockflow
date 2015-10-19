module Rockflow
  class InstallGenerator < Rails::Generators::Base
    source_root(File.expand_path(File.dirname(__FILE__)))

    def copy_initializer
      copy_file '../../templates/rockflow.rb', 'config/initializers/rockflow.rb'
    end
  end
end