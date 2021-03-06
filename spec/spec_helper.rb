# frozen_string_literal: true

# Code coverage
require "simplecov"
require "coveralls"
Coveralls.wear!
SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([
                                                                  SimpleCov::Formatter::HTMLFormatter,
                                                                  Coveralls::SimpleCov::Formatter
                                                                ])
SimpleCov.start do
  add_group "Libraries", "lib"
  add_filter "spec"
end

require "model_validator"
require "factory_bot"
Dir[File.join(__dir__, "support", "*.rb")].sort.each { |file| require file }
Dir[File.join(__dir__, "factories", "*.rb")].sort.each { |file| require file }
Dir[File.join(__dir__, "models", "*.rb")].sort.each { |file| require file }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FactoryBot::Syntax::Methods
end

# Allow mocking of Rails.logger without warning
RSpec::Mocks.configuration.allow_message_expectations_on_nil = true
