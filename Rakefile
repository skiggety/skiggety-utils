require 'rake/testtask'

# TODO TODO TODO TODO: report/ratchet coverage
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = false
end

task :default => :test
