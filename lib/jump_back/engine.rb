module JumpBack
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.assets false
      g.helper false
    end
    initializer "jump_back.methods" do |app|
      ActiveSupport.on_load :action_view do
        include JumpBack::Helpers
      end
      ActiveSupport.on_load :action_controller do
        include JumpBack::Redirection
      end
    end
  end
end
