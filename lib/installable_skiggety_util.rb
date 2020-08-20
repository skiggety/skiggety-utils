# TODO TODO: write tests
module InstallableSkiggetyUtil

  def run # TODO: extract to InstallableSkiggetyUtil
    $interactive = ! ARGV.delete('--non-interactive')

    if marked_done?
      # TODO?: puts "#{self.class} has already finished"
    else
      if installed?
        puts "#{self.class} can skip installation this time, because it's done already"
      else
        install # TODO: catch exception and wrap in: raise "install command failed for #{self.class}"
      end
      if configured?
        puts "#{self.class} can skip configuration this time, because it's done already"
      else
        configure
      end
      mark_done
    end
  end

  def mark_done
    # TODO: mark it installed with hash codes in filenames
    raise "TODO: Implement"
  end

  def marked_done?
    # TODO: if not already installed (by checking for hash-stamped files
    raise "TODO: Implement"
  end

end

