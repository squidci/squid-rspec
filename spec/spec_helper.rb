unless RUBY_PLATFORM =~ /java/
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  SimpleCov.start do
    add_filter 'spec'
  end
end

require 'squid-rspec'

RSpec.configure do |config|
  config.order = 'random'
end
