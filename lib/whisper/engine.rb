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

  end
end
