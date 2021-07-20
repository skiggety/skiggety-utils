# frozen_string_literal: true

# TODO TODO: assert ruby version # puts "DEBUG: in #{name} installer, RUBY_VERSION is \"#{RUBY_VERSION}\"."

# TODO: mark more of these methods private

require 'fileutils'

module InstallableSkiggetyUtil

  def self.included(base)
    base.class_eval do
      def self.run
        new.run
      end
    end
  end

  def run
    # TODO TODO: should we catch exceptions and print them without a full stack trace?
    $interactive = !ARGV.delete('--non-interactive')

    # TODO TODO: REFACTOR:
    unless marked_installed?
      if apparently_installed?
        puts "#{name} installation is already done" # TODO: debug only
        $stdout.flush
      else
        puts "Installing #{name}"
        $stdout.flush
        install # TODO TODO: catch exception and wrap in: raise "install command failed for #{self.class}"
      end
      mark_installed
    end
    unless marked_configured?
      if apparently_configured?
        puts "#{name} configuration is already done" # TODO: debug only
        $stdout.flush
      else
        puts "Configuring #{name}"
        $stdout.flush
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
    rescue RuntimeError => e
      puts "ERROR: #{e}"
    end
  end

  def marked_configured?
    File.exist?(current_config_marker_file_path)
  rescue RuntimeError => e
    puts 'ERROR: cannot determine current config marker file, assuming configuration is needed. Original error was: '\
         "\"#{e.inspect}\""
    false
  end

  def marked_installed?
    File.exist?(current_install_marker_file_path)
  end

  # TODO TODO: extract delegate_to_user and ask_user to another library/gem
  def delegate_to_user(request_text)
    raise "user failed to: '#{request_text}" unless ask_user(request_text)
  end

  def ask_user(request_text)
    if $interactive
      system("#{installer_directory_path}/../bin/ask_user '#{request_text}'")
    else
      raise "Cannot ask user to do the following without being in interactive mode: '#{request_text}'"
    end
  end

  def past_install_marker_file_paths
    result = Dir.glob(File.join(installer_directory_path, install_marker_file_name_prefix + '*'))
    result.delete(current_install_marker_file_path)
    result
  end

  def current_install_marker_file_path
    File.join(installer_directory_path, current_install_marker_file_name)
  end

  def past_config_marker_file_paths
    result = config_marker_file_paths
    begin
      result.delete(current_config_marker_file_path)
    rescue RuntimeError => e
      puts "ERROR: #{e}"
    end
    result
  end

  def config_marker_file_paths
    Dir.glob(File.join(installer_directory_path, config_marker_file_name_prefix + '*'))
  end

  def current_config_marker_file_path
    File.join(installer_directory_path, current_config_marker_file_name)
  end

  def current_install_marker_file_name
    install_marker_file_name_prefix + installer_file_hash
  end

  def install_marker_file_name_prefix
    ".#{File.basename(installer_file_path)}.installed_with_version."
  end

  def current_config_marker_file_name
    config_marker_file_name_prefix + config_tree_hash
  end

  def config_marker_file_name_prefix
    ".#{File.basename(config_dir_path)}ured_with_version."
  end

  def raise_interactive_only_configuration
    raise_interactive_only_action('configure')
  end

  def raise_interactive_only_install
    raise_interactive_only_action('install')
  end

  def raise_interactive_only_action(action)
    raise "Cannot #{action} #{name} in non-interactive mode, user should run \"install-skiggety-utils\" or "\
          "\"#{installer_file_path}\"."
  end

  def call_peer_installer(name)
    # TODO^3: perhaps if the installer contains 'include InstallableSkiggetyUtil', we should call it in the same process
    install_command = File.join(installer_directory_path, name)
    install_command += ' --non-interactive' unless $interactive
    system(install_command)
    raise "Failed to set up \"#{name}\", which is blocking \"#{self.name}\"." unless $CHILD_STATUS == 0
  end

  def config_tree_hash
    if config_exist?
      if '' != `git status -s #{config_dir_path}`
        # TODO TODO: we could return something random so it's different each
        # time, or maybe bite the bullet and calculate what the tree hash would
        # be from scratch, not sure...
        raise "There are uncommitted changes in #{config_dir_path}, so #{self.class} will not bother computing a "\
              'hash to identify it.'
      end

      `git ls-tree HEAD -- #{config_dir_path}`.split[2].to_s
    else
      'no_hash'
    end
  end

  def config_exist?
    Dir.exist?(config_dir_path)
  end

  def config_dir_path
    installer_file_path + '.config'
  end

  def self_config_path(file_name)
    File.join(config_dir_path, file_name)
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

  def open_in_browser(url)
    if on_mac_os?
      assert_system("open #{url}")
    elsif on_linux_os?
      assert_system("browse #{url} 2>/dev/null")
    else
      raise NotImplementedError, 'TODO: implement this for this OS' # IGNORE_TODO
    end
  end

  def on_mac_os?
    @on_mac_os ||= calc_on_mac_os?
  end

  private def calc_on_mac_os?
    system('uname -a | grep Darwin > /dev/null')
  end

  def apt_available?
    @apt_available ||= calc_apt_available?
  end

  private def calc_apt_available?
    system('which apt > /dev/null')
  end

  def on_linux_os?
    @on_linux_os ||= calc_on_linux_os?
  end

  private def calc_on_linux_os?
    system('uname -a | grep Linux > /dev/null')
  end

  def assert_system(command)
    system(command) or raise "Failed to run command: \"#{command}\""
  end

  # TODO TODO: rename?
  def program_version_option_output_matches?(program, version_regex)
    version_output = `#{program} --version | head -n 1`
    (version_output =~ version_regex).is_a?(Numeric) # TODO TODO: update desired vim version
  end

  def brew_install_latest(package_name)
    system("brew upgrade #{package_name}") or
      system("brew install #{package_name}") or
      raise "FAILED to upgrade or install #{package_name} with homebrew"
  end

  def brew_install_cask_latest(package_name)
    system("brew upgrade --cask #{package_name}") or
      system("brew install --cask #{package_name}") or
      raise "FAILED to upgrade or install cask #{package_name} with homebrew"
  end

end
