module JumpBack
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.assets false
      g.helper false
    end
    initializer "jump_back.methods" do |app|
      ApplicationController.send :include, JumpBack
    end
  end
end