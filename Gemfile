source 'https://rubygems.org'

# Specify your gem's dependencies in rawk_log.gemspec
gemspec

gem "bundler", (RUBY_VERSION >= '2.3.0' ? '> 1.3' : '~> 1.3')
gem 'rake', RUBY_VERSION < '1.9' ? '< 11.0' : '>= 11.0'

if RUBY_VERSION >= '2.2' # work around missing ruby_26 platform error
  gem 'test-unit'
  gem 'minitest'
end

# mime-types 2.0 requires Ruby version >= 1.9.2
# mime-types 3.0 requires Ruby version >= 2.0
gem 'mime-types', RUBY_VERSION < '1.9.2' ? '< 2.0' : (defined?(JRUBY_VERSION) || RUBY_VERSION < '2.0' ? '< 3.0' : '>= 3.0')

platforms :ruby_18, :ruby_19 do
  gem 'json', '< 2.0' 
end

gem 'coveralls', :require => false, :group => :development
