# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'reddalert/version'

Gem::Specification.new do |spec|
  spec.name          = "reddalert"
  spec.version       = Reddalert::VERSION
  spec.authors       = ["JayK31"]
  spec.email         = ["jay.kaye31@gmail.com"]
  spec.summary       = %q{Receive notifications when there's a new post in a subreddit.}
  spec.description   = %q{Receive notifications when there's a new post in a subreddit.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_dependency "httparty", "~> 0.13.3"
  spec.add_dependency "whenever", "~> 0.9.4"
  spec.post_install_message = "Thanks for installing reddalert! After installation, all you need to do is type 
    'whenever --update-crontab' in the console to set the crontab schedule, and you'll start getting notifications."
end
