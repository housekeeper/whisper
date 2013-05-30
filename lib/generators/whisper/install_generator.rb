require 'rails/generators'
module Whisper
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option "user-class", :type => :string
      class_option "no-migrate", :type => :boolean
      class_option "current-user-helper", :type => :string

      source_root File.expand_path("../install/templates", __FILE__)
      desc "Used to install whisper"

      def install_migrations
        puts "Copying over whisper migrations..."
        Dir.chdir(Rails.root) do
          `rake whisper:install:migrations`
        end
      end

      def determine_user_class
        @user_class = options["user-class"].presence ||
                      ask("What is your user class called? [User]").presence ||
                      'User'
      end

      def determine_current_user_helper
        current_user_helper = options["current-user-helper"].presence ||
                              ask("What is the current_user helper called in your app? [current_user]").presence ||
                              :current_user

        puts "Defining whisper_user method inside ApplicationController..."

        whisper_user_method = %Q{
  def whisper_user
    #{current_user_helper}
  end
  helper_method :whisper_user

}

        inject_into_file("#{Rails.root}/app/controllers/application_controller.rb",
                         whisper_user_method,
                         :after => "ActionController::Base\n")

      end

      def add_whisper_initializer
        path = "#{Rails.root}/config/initializers/whisper.rb"
        if File.exists?(path)
          puts "Skipping config/initializers/whisper.rb creation, as file already exists!"
        else
          puts "Adding whisper initializer (config/initializers/whisper.rb)..."
          template "initializer.rb", path
        end
      end

      def run_migrations
        unless options["no-migrate"]
          puts "Running rake db:migrate"
          `rake db:migrate`
        end
      end

      def seed_database
        load "#{Rails.root}/config/initializers/whisper.rb"
        unless options["no-migrate"]
          puts "Loading data"
          Whisper::Engine.load_seed
        end
      end

      def mount_engine
        puts "Mounting whisper::Engine at \"/whisper\" in config/routes.rb..."
        insert_into_file("#{Rails.root}/config/routes.rb", :after => /routes.draw.do\n/) do
          %Q{  mount Whisper::Engine, :at => "/whisper"\n}
        end
      end

      def finished
        output = "\n\n" + ("*" * 53)
        output += %Q{\nDone! whisper has been successfully installed. Yaaaaay!

Here's what happened:\n\n}

        output += step("whisper's migrations were copied over into db/migrate.\n")
        output += step("A new method called `whisper_user` was inserted into your ApplicationController.
   This lets whisper know what the current user of your application is.\n")
        output += step("A new file was created at config/initializers/whisper.rb
   This is where you put whisper's configuration settings.\n")

        unless options["no-migrate"]
output += step("`rake db:migrate` was run, running all the migrations against your database.\n")
        # output += step("Seed data loaded into your database.\n")
        end
        output += step("The engine was mounted in your config/routes.rb file using this line:

   mount Whisper::Engine, :at => \"/whisper\"

   If you want to change where the whisper is located, just change the \"/whisper\" path at the end of this line to whatever you want.")
        output += %Q{\nAnd finally:

#{step("We told you that whisper has been successfully installed and walked you through the steps.")}}
        unless defined?(Devise)
          output += %Q{We have detected you're not using Devise (which is OK with us, really!), so there's one extra step you'll need to do.

   You'll need to define a "sign_in_path" method for whisper to use that points to the sign in path for your application. You can set Whisper.sign_in_path to a String inside config/initializers/whisper.rb to do this, or you can define it in your config/routes.rb file with a line like this:

          get '/users/sign_in', :to => "users#sign_in"

          Either way, whisper needs one of these two things in order to work properly. Please define them!}
        end
        # output += "\nIf you have any questions, comments or issues, please post them on our issues page: http://github.com/radar/whisper/issues.\n\n"
        output += "Thanks for using whisper!"
        puts output
      end

      private

      def step(words)
        @step ||= 0
        @step += 1
        "#{@step}) #{words}\n"
      end

      def user_class
        @user_class
      end

      def next_migration_number
        last_migration = Dir[Rails.root + "db/migrate/*.rb"].sort.last.split("/").last
        current_migration_number = /^(\d+)_/.match(last_migration)[1]
        current_migration_number.to_i + 1
      end
    end
  end
end