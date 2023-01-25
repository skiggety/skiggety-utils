# frozen_string_literal: true

# make sure symlinks exist to include installers in test coverage
link_dir = File.expand_path(File.join(__dir__, '../lib/coverage_links'))
FileUtils.mkdir_p link_dir
# puts "link_dir is \"#{link_dir}\""
installer_dir = File.expand_path(File.join(__dir__, '../installers'))
# puts "installer_dir is \"#{installer_dir}\""

necessary_symlinks = []
# Create necessary_symlinks for code coverage
Dir.glob(File.join(installer_dir, '*')).each do |installer|
  next unless File.file?(installer)
  next unless system("head -n 1 #{installer} | grep ruby > /dev/null")

  installer_link = File.join(link_dir, File.basename(installer) + '.rb')
  installer_relpath = File.join('../../installers', File.basename(installer))
  necessary_symlinks << installer_link
  unless File.exist?(installer_link)
    puts "CREATING SYMLINK: #{installer_link} --> #{installer_relpath}"
    File.symlink(installer_relpath, installer_link)
  end
end

# Remove dead links
Dir.glob(File.join(link_dir, '*')).each do |found_symlink|
  unless necessary_symlinks.include?(found_symlink)
    puts "DELETING SYMLINK: #{found_symlink}"
    File.delete(found_symlink)
  end
end

require 'minitest/autorun'
require 'minitest/reporters'
require 'simplecov'

Minitest::Reporters.use! [Minitest::Reporters::ProgressReporter.new(color: true)]

SimpleCov.start do
  track_files 'lib/**/*.rb'
end
