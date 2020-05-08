require 'rails-vue-helpers/tag_helpers'

module RailsVueHelpers
  class Railtie < Rails::Railtie
    initializer 'rails-vue-helpers.view_helper' do
      ActiveSupport.on_load :action_view do
        include RailsVueHelpers::TagHelpers
      end
    end
  end
end
