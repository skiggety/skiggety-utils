
# make sure symlinks exist to include installers in test coverage
link_dir = File.expand_path(File.join(__dir__, '../lib/coverage_links'))
puts "link_dir is \"#{link_dir}\""
installer_dir = File.expand_path(File.join(__dir__, '../installers'))
puts "installer_dir is \"#{installer_dir}\""
Dir.glob(File.join(installer_dir,'*')).each do |installer|
  if File.file?(installer)
    if system("head -n 1 #{installer} | grep ruby > /dev/null")
      installer_link = File.join(link_dir,File.basename(installer) + '.rb')
      installer_relpath = File.join('../../installers', File.basename(installer))
      if ! File.exist?(installer_link)
        puts "CREATING SYMLINK: #{installer_link} --> #{installer_relpath}"
        File.symlink(installer_relpath, installer_link)
      end
    end
  end
end


#require_relative '../installers/vim'

require "minitest/autorun"
require 'minitest/reporters'
require 'simplecov'

Minitest::Reporters.use! [Minitest::Reporters::ProgressReporter.new(:color => true)]

SimpleCov.start do
  track_files 'lib/**/*.rb'
end
# TODO: follow https://github.com/simplecov-ruby/simplecov/issues/926 for a new version of ximplecov that won't complain about @enable_for_subprocesses not being initialized
