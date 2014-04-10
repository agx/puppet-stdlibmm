source ENV['GEM_SOURCE'] || 'https://rubygems.org'
puppetversion = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['>= 3.4']

group :development, :test do
  gem 'puppetlabs_spec_helper',  :require => false
  gem 'puppet-lint',             :require => false
  gem 'puppet',                  puppetversion, :require => false
  gem 'rake', '~> 10.1.0',       :require => false
  gem 'rspec-puppet',            :require => false
  gem 'simplecov',               :require => false
end
