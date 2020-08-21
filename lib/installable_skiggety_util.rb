# TODO TODO: write tests

require 'fileutils'

module InstallableSkiggetyUtil

  def run # TODO: extract to InstallableSkiggetyUtil
    $interactive = ! ARGV.delete('--non-interactive')

    # TODO TODO TODO TODO TODO TODO: put a begin/?? block around this. Exceptions should cause us to give up and move on. Exceptions should be thrown if the install cannot complete
    if ! marked_installed?
      if apparently_installed?
        puts "#{self.class} can skip installation this time, because it's done already" # TODO: debug only
      else
        install # TODO: catch exception and wrap in: raise "install command failed for #{self.class}"
      end
      mark_installed
    end
    if config_exist?
      if ! marked_configured?
        if apparently_configured?
          puts "#{self.class} can skip configuration this time, because it's done already" # TODO: debug only
        else
          configure
        end
        mark_configured
      end
    end
  end

  def mark_installed
    # TODO: delete any past_install_marker_file_paths, and ignore them all in .gitignore
    FileUtils.touch(current_install_marker_file_path)
  end

  def mark_configured
    # TODO: delete any past_config_marker_file_paths, and ignore them all in .gitignore
    FileUtils.touch(current_config_marker_file_path)
  end

  def marked_installed?
    File.exist?(current_install_marker_file_path)
  end

  def config_exist?
    Dir.exist?(config_dir_path)
  end

  def marked_configured?
    File.exist?(current_config_marker_file_path)
  end

  def current_install_marker_file_path
    File.join(installer_directory_path, current_install_marker_file_name)
  end

  def current_config_marker_file_path
    File.join(installer_directory_path, current_config_marker_file_name)
  end

  def current_install_marker_file_name
    "." + File.basename(installer_file_path) + ".installed_with_version." + installer_file_hash
  end

  def current_config_marker_file_name
    "." + File.basename(config_dir_path) + "ured_with_version." + config_tree_hash
  end

  def installer_directory_path
    File.dirname(installer_file_path)
  end

  def installer_file_hash
    `git hash-object \"#{installer_file_path}\"`.chomp
  end

  def installer_file_path
    File.expand_path(self.class.instance_method(:install).source_location[0])
  end

  def config_tree_hash
    if ( '' != `git status -s #{config_dir_path}`)
      raise "There are uncommitted changes in #{config_dir_path}, so #{self.class} will not do any configuration"
    end
    return `git ls-tree HEAD -- #{config_dir_path}`.split(' ')[2]
  end

  def config_dir_path
    installer_file_path + ".config"
  end

end

