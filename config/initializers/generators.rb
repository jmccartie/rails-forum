Rails.application.config.generators do |g|
  g.stylesheets          false
  
  g.template_engine      :haml
  g.test_framework       :rspec, :fixture => false, :views => false
  g.view_specs   false
  g.fixture_replacement  :factory_girl,  :dir => 'spec/factories'
end
