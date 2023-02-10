# frozen_string_literal: true

require 'shellwords'

module UserDelegation

  def delegate_to_user(request_text)
    raise "user failed to: '#{request_text}" unless ask_user(request_text)
  end

  def delegate_diff_to_user(target_path, template_path)
    vimdiff_command = "vim -d #{target_path} #{template_path}"
    (ask_user_yn("Ready to make #{File.basename(target_path)} edits with a vimdiff?") &&
     assert_system(vimdiff_command)) ||
      shellask("Make suggested edits, using an alternative or a command like '#{vimdiff_command}'.")
  end

  def shellask(request_text)
    if $interactive
      request = request_text.shellescape
      system("#{installer_directory_path}/../bin/shellask #{request}")
    else
      raise "Cannot ask user to do the following without being in interactive mode: '#{request_text}'"
    end
  end

  def ask_user_yn(question_text)
    shellask(question_text) # TODO: real implementation at some point
  end

  # TODO^2: maybe shellask isn't always the best way to ask the user a question.  Change calls to this to call the
  # shellask method or something like ask_user_yn:
  def ask_user(request_text)
    if $interactive
      system("#{installer_directory_path}/../bin/shellask '#{request_text}'")
    else
      raise "Cannot ask user to do the following without being in interactive mode: '#{request_text}'"
    end
  end

  def delegate_download_and_install_to_user(download_url, name)
    if $interactive
      open_in_browser(download_url)
      delegate_to_user("Download/install #{name} manually.  The download page should be open now.")
    else
      raise_interactive_only_install
    end
  end

  def open_in_browser(url)
    if on_mac_os?
      assert_system("open #{url}")
    elsif on_linux_os?
      assert_system("browse #{url} 2>/dev/null &")
    else
      raise NotImplementedError, 'TODO: implement this for this OS' # IGNORE_TODO
    end
  end

end
