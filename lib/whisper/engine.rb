module Whisper

  class Engine < ::Rails::Engine
    engine_name 'whisper'
    isolate_namespace Whisper

    initializer "app.helpers.whisper.application_helper" do |app|
      ActionView::Base.send :include, Whisper::ApplicationHelper
    end

    config.before_initialize do
      config.action_view.javascript_expansions[:defaults] = %w(jquery rails jquery-ui jquery-ujs whisper)
    end

    config.generators do |g|
      g.test_framework  :rspec, :view_specs => false
      g.template_engine :haml
      g.orm             :active_record
    end

  end
end
