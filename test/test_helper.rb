$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "minitest/autorun"
require 'minitest/reporters'
require 'simplecov'

Minitest::Reporters.use! [Minitest::Reporters::ProgressReporter.new(:color => true)]

SimpleCov.start
# TODO: follow https://github.com/simplecov-ruby/simplecov/issues/926 for a new version of ximplecov that won't complain about @enable_for_subprocesses not being initialized
