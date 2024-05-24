# frozen_string_literal: true

require_relative 'lib/coco_auth/version'

Gem::Specification.new do |spec|
  spec.name        = 'coco_auth'
  spec.version     = CocoAuth::VERSION
  spec.authors     = ['Denis Sellu']
  spec.email       = ['denis.sellu@ably.com']
  spec.summary     = 'A Rails engine for SSO IdP'
  spec.description = 'A Rails engine to provide SSO IdP functionality, including user creation, field mapping, and app management.'
  spec.homepage    = 'https://ably.com'
  spec.license     = 'MIT'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'rails', '~> 6.1.7', '>= 6.1.7.7'
end
