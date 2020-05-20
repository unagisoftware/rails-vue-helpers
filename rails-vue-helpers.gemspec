require_relative 'lib/rails-vue-helpers/version'

Gem::Specification.new do |spec|
  spec.name     = 'rails-vue-helpers'
  spec.version  = RailsVueHelpers::VERSION
  spec.authors  = ['Lucas Hourquebie']
  spec.email    = ['lucashour1993@gmail.com']
  spec.summary  = 'Rails helpers extension to support Vue.js attributes'
  spec.homepage = 'https://github.com/unagisoftware/rails-vue-helpers'
  spec.license  = 'MIT'

  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['documentation_uri'] = "https://github.com/unagisoftware/rails-vue-helpers/blob/v#{RailsVueHelpers::VERSION}/README.md"
  spec.metadata['source_code_uri'] = "https://github.com/unagisoftware/rails-vue-helpers/tree/v#{RailsVueHelpers::VERSION}"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.required_ruby_version = ">= 2.3.0"
  spec.add_dependency "actionview", ">= 4.2"
  spec.add_dependency "railties", ">= 4.2"

  spec.require_paths = ['lib']
end
