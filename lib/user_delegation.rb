# frozen_string_literal: true

module UserDelegation

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

end
