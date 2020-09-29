require 'rake/testtask'

# TODO TODO TODO: colorized test output:
# TODO TODO TODO: report/ratchet coverage
Rake::TestTask.new do |t|
  t.libs << 'tests'
  t.test_files = FileList["test/*/*_test.rb"]
  t.verbose = false
end
