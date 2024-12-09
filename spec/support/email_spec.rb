require "email_spec"
require "email_spec/rspec"

RSpec.configure do |c|
  c.include EmailSpec::Helpers
  c.include EmailSpec::Matchers
end
