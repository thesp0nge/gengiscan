# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gengiscan/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Paolo Perego"]
  gem.email         = ["thesp0nge@gmail.com"]
  gem.description   = %q{gengiscan is a CMS fingerprinting tool using Generator meta tag and Server HTTP response header to fingerpring a CMS used by a website}
  gem.summary       = %q{gengiscan is a CMS fingerprinting tool using Generator meta tag and Server HTTP response header to fingerpring a CMS used by a website}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "gengiscan"
  gem.require_paths = ["lib"]
  gem.version       = Gengiscan::VERSION
end
