FactoryGirl.definition_file_paths = ['spec/support/factories']
FactoryGirl.find_definitions

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
