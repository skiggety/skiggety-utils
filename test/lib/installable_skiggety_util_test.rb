require "test_helper"
require 'installable_skiggety_util'

class RawDummyInstaller
  include InstallableSkiggetyUtil
end

class DummyInstaller < RawDummyInstaller
  def installer_file_path
    "/installer_dir/dummy"
  end
end

class DummyNoOpInstaller < DummyInstaller
  include InstallableSkiggetyUtil

  def apparently_configured?
    true
  end

  def apparently_installed?
    true
  end

end

class TestInstallableSkiggetyUtil < Minitest::Test

  # TODO TODO TODO TODO: write more tests, but not private methods

  def setup
    @raw_subject = RawDummyInstaller.new
    @subject = DummyInstaller.new
    @no_op_subject = DummyNoOpInstaller.new
  end

  # TODO: test self.run
  # TODO: test run
  # TODO: test name
  # TODO: test mark_installed
  # TODO: test delete_all_config_markers
  # TODO: test mark_configured
  # TODO: test marked_configured?
  # TODO: test marked_installed?
  # TODO: test delegate_to_user(request_text)
  # TODO: test ask_user(request_text)
  # TODO: test past_install_marker_file_paths
  # TODO: test current_install_marker_file_path
  # TODO: test past_config_marker_file_paths
  # TODO: test config_marker_file_paths
  # TODO: test current_config_marker_file_path
  # TODO: test current_install_marker_file_name
  # TODO: test install_marker_file_name_prefix
  # TODO: test current_config_marker_file_name
  # TODO: test config_marker_file_name_prefix
  # TODO: test raise_interactive_only_configuration
  # TODO: test raise_interactive_only_install
  # TODO: test raise_interactive_only_action(action)
  # TODO: test call_peer_installer(name)
  # TODO: test config_tree_hash
  # TODO: test config_exist?
  # TODO: test config_dir_path
  # TODO: test self_config_path(file_name)

  def test_installer_directory_path
    assert_equal "/installer_dir", @subject.installer_directory_path
  end

  # TODO: test installer_file_hash (use raw dummy and a stub like with test_installer_file_path because the main dummy will override these methods)
    # TODO: Perhaps make sure the installer gets read as having run and has no git changes, then add a newline to the end of the file, make sure it gets read as needing to run, then revert the change and make sure it gets read as having run.

  def test_installer_file_path
    fake_method = Object.new
    class << fake_method
      def source_location
        ["/installers/dummy.rb", 1]
      end
    end
    RawDummyInstaller.stub( :instance_method, fake_method) do
      assert_equal "/installers/dummy.rb", @raw_subject.installer_file_path
    end
  end

  # TODO: test open_in_browser(url)

  # TODO: test on_mac_os? and test on_linux_os? together? maybe make sure exactly one method of this kind returns true? or in that case wouldn't it just be better to replace these methods with one os method that returns a string
  # TODO: test on_mac_os?
  # TODO: test on_linux_os?

  def test_assert_system_true
    @subject.assert_system('true') #no exception expected
  end

  def test_assert_system_false
    assert_raises RuntimeError do
      @subject.assert_system('false')
    end
  end

  # TODO: test program_version_option_output_matches?(program, version_regex)

end
