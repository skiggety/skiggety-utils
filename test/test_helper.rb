$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "minitest/autorun"
require 'minitest/reporters'
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(:color => true)]
