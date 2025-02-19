lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'osctl/exporter/version'

Gem::Specification.new do |s|
  s.name        = 'osctl-exporter'

  if ENV['OS_BUILD_ID']
    s.version   = "#{OsCtl::Exporter::VERSION}.build#{ENV['OS_BUILD_ID']}"
  else
    s.version   = OsCtl::Exporter::VERSION
  end

  s.summary     =
  s.description = 'Export osctl metrics to prometheus'
  s.authors     = 'Jakub Skokan'
  s.email       = 'jakub.skokan@vpsfree.cz'
  s.files       = `git ls-files -z`.split("\x0")
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.license     = 'Apache-2.0'

  s.required_ruby_version = '>= 2.0.0'

  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'libosctl', s.version
  s.add_runtime_dependency 'osctl', s.version
  s.add_runtime_dependency 'osctl-exportfs', s.version
  s.add_runtime_dependency 'prometheus-client', '~> 4.0.0'
  s.add_runtime_dependency 'require_all', '~> 2.0.0'
  s.add_runtime_dependency 'thin', '~> 1.8.1'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'yard'
end
