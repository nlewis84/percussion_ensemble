require_relative 'lib/percussion_ensembles/version'

Gem::Specification.new do |spec|
  spec.name          = "percussion_ensembles"
  spec.version       = PercussionEnsembles::VERSION
  spec.authors       = ["nllew"]
  spec.email         = ["n.lewis.perc@gmail.com"]

  spec.summary       = %q{Search Tapspace.com for percussion ensembles.}
  spec.description   = %q{Search Tapspace.com for percussion ensembles.}
  spec.homepage      = "https://github.com/nlewis84/percussion_ensemble"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "http://www.google.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://www.google.com"
  spec.metadata["changelog_uri"] = "http://www.google.com"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_dependency "nokogiri"
  spec.add_dependency "open-uri"

end
