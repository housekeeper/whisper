$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "whisper/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "whisper"
  s.version     = Whisper::VERSION
  s.authors     = ["Carl Burton, David Alphen"]
  s.email       = ["carl@house-keeping.com, david.alphen@gmail.com"]
  s.homepage    = ""
  s.summary     = "Whisper allows you to chat with users within an existing application."
  s.description = "Whisper allows you to chat with users within an existing application."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "private_pub"
  s.add_dependency "jquery-rails"

end
