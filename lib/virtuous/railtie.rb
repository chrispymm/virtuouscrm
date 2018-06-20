module Virtuous
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/virtuous/tokens.rake'
    end
  end
end
