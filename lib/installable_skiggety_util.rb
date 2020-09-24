# TODO TODO TODO: write tests

require 'fileutils'

module InstallableSkiggetyUtil

  def self.included base
    base.class_eval do

      def self.run
        self.new.run
      end

    end
  end

  def run
    # TODO: should we catch exceptions and print them without a full stack trace?
    $interactive = ! ARGV.delete('--non-interactive')

    # TODO: REFACTOR:
    unless marked_installed?
      if apparently_installed?
        puts "#{name} installation is already done" # TODO: debug only
        STDOUT.flush
      else
        puts "Installing #{name}"
        STDOUT.flush
        install # TODO: catch exception and wrap in: raise "install command failed for #{self.class}"
      end
      mark_installed
    end
    unless marked_configured?
      if apparently_configured?
        puts "#{name} configurattion is already done" # TODO: debug only
        STDOUT.flush
      else
        puts "Configuring #{name}"
        STDOUT.flush
        configure
      end
      mark_configured
    end

  end

  def name
    File.basename(installer_file_path)
  end

  def mark_installed
    past_install_marker_file_paths.each do |path_to_delete|
      File.delete(path_to_delete)
    end
    FileUtils.touch(current_install_marker_file_path)
    delete_all_config_markers # if install happens, config should happen too--even if it's marked done
  end

  def delete_all_config_markers
    config_marker_file_paths.each do |path_to_delete|
      File.delete(path_to_delete)
    end
  end

  def mark_configured
    past_config_marker_file_paths.each do |path_to_delete|
      File.delete(path_to_delete)
    end
    begin
      FileUtils.touch(current_config_marker_file_path)
    rescue RuntimeError => error
      puts "ERROR: #{error}"
    end
  end

  def marked_configured?
    begin
      return File.exist?(current_config_marker_file_path)
    rescue RuntimeError => error
      puts "ERROR: cannot determine current config marker file, assuming configuration is needed. Original error was: \"#{error.inspect}\""
      return false
    end
  end

  def marked_installed?
    File.exist?(current_install_marker_file_path)
  end

  # TODO: extract delegate_to_user and ask_user to another library
  def delegate_to_user(request_text)
    unless ask_user(request_text)
      raise "user failed to: '#{request_text}"
    end
  end

  def ask_user(request_text)
    if $interactive
      system("#{installer_directory_path}/../bin/ask_user '#{request_text}'")
      return ( $?.exitstatus == 0 )
    else
      raise "Cannot ask user to do the following without being in interactive mode: '#{request_text}'"
    end
  end

  def past_install_marker_file_paths
    result = Dir.glob(File.join(installer_directory_path, install_marker_file_name_prefix + "*"))
    result.delete(current_install_marker_file_path)
    return result
  end

  def current_install_marker_file_path
    File.join(installer_directory_path, current_install_marker_file_name)
  end

  def past_config_marker_file_paths
    result = config_marker_file_paths
    begin
      result.delete(current_config_marker_file_path)
    rescue RuntimeError => error
      puts "ERROR: #{error}"
    end
    return result
  end

  def config_marker_file_paths
    Dir.glob(File.join(installer_directory_path, config_marker_file_name_prefix + "*"))
  end

  def current_config_marker_file_path
    File.join(installer_directory_path, current_config_marker_file_name)
  end

  def current_install_marker_file_name
     install_marker_file_name_prefix + installer_file_hash
  end

  def install_marker_file_name_prefix
    "." + File.basename(installer_file_path) + ".installed_with_version."
  end

  def current_config_marker_file_name
    config_marker_file_name_prefix + config_tree_hash
  end

  def config_marker_file_name_prefix
    "." + File.basename(config_dir_path) + "ured_with_version."
  end

  def installer_directory_path
    File.dirname(installer_file_path)
  end

  def installer_file_hash
    `git hash-object \"#{installer_file_path}\"`.chomp
  end

  def installer_file_path
    File.expand_path(self.class.instance_method(:apparently_installed?).source_location[0])
  end

  def raise_interactive_only_configuration
    raise_interactive_only_action('configure')
  end

  def raise_interactive_only_install
    raise_interactive_only_action('install')
  end

  def raise_interactive_only_action(action)
    raise "Cannot #{action} #{name} in non-interactive mode, user should run \"install-skiggety-utils\" or \"#{installer_file_path}\"."
  end

  def call_peer_installer(name)
    # TODO: perhaps if the installer contains 'include InstallableSkiggetyUtil', we should call it in the same process
    install_command = File.join(installer_directory_path,name)
    unless $interactive
      install_command = install_command + " --non-interactive"
    end
    system(install_command)
    raise "Failed to set up \"#{name}\", which is blocking \"#{self.name}\"." unless ($? == 0 )
  end

  def config_tree_hash
    if config_exist?
      if ( '' != `git status -s #{config_dir_path}`)
        raise "There are uncommitted changes in #{config_dir_path}, so #{self.class} will not bother computing a hash to identify it." # TODO: we could return something random so it's different each time, not sure...
      end
      return `git ls-tree HEAD -- #{config_dir_path}`.split(' ')[2]
    else
      return 'no_hash'
    end
  end

  def config_exist?
    Dir.exist?(config_dir_path)
  end

  def config_dir_path
    installer_file_path + ".config"
  end

  def open_in_browser(url)
    if on_mac_os?
      system("open #{url}")
    elsif on_linux_os?
      systemtrue?("browse #{url} 2>/dev/null") or raise "Failed to open \"#{url}\" in browser"
    else
      raise "TODO: IMPLEMENT"
    end
  end

  def on_mac_os?
    @on_mac_os ||= calc_on_mac_os?
  end

  def calc_on_mac_os?
    return systemtrue?("uname -a | grep Darwin > /dev/null")
  end

  def on_linux_os?
    @on_linux_os ||= calc_on_linux_os?
  end

  def calc_on_linux_os?
    return systemtrue?("uname -a | grep Linux > /dev/null")
  end

  def systemtrue?(command)
    system(command)
    return ( $?.exitstatus == 0 )
  end

  def self_config_path(file_name)
    File.join(config_dir_path,file_name)
  end

  def program_version_option_output_matches?(program, version_regex) # TODO: rename?
    version_output = `#{program} --version | head -n 1`
    return (version_output =~ version_regex ).is_a?(Numeric) # TODO: update desired vim version and make sure it includes the gui version, too
  end

end
