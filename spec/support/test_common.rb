require_relative '../../test_common/capybara'
require_relative '../../test_common/page_objects'
require_relative '../../test_common/personas'
require_relative '../../test_common/messaging'
require_relative '../../test_common/helpers'
RSpec.configure do |c|
  c.include Calculator::Test::Pages, type: :feature
end
RSpec.configure do |c|
  c.include Calculator::Test::Setup, type: :feature
end
