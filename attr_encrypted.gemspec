# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'attr_encrypted/version'
require 'date'

Gem::Specification.new do |s|
  s.name    = 'attr_encrypted'
  s.version = AttrEncrypted::Version.string
  s.date    = Date.today

  s.summary     = 'Encrypt and decrypt attributes'
  s.description = 'Generates attr_accessors that encrypt and decrypt attributes transparently'

  s.authors   = ['Sean Huber', 'S. Brent Faulkner', 'William Monk']
  s.email    = ['shuber@huberry.com', 'sbfaulkner@gmail.com', 'billy.monk@gmail.com']
  s.homepage = 'http://github.com/attr-encrypted/attr_encrypted'

  s.has_rdoc = false
  s.rdoc_options = ['--line-numbers', '--inline-source', '--main', 'README.rdoc']

  s.require_paths = ['lib']

  s.files      = Dir['{bin,lib}/**/*'] + %w(MIT-LICENSE Rakefile README.rdoc)
  s.test_files = Dir['test/**/*']

  s.add_dependency('encryptor', ['>= 1.3.0'])
  # support for testing with specific active record version
  activerecord_version = if ENV.key?('ACTIVERECORD')
    "~> #{ENV['ACTIVERECORD']}"
  else
    ['>= 2.0.0'].tap do |version|
      if RUBY_VERSION < '1.9.3'
        # For Ruby 1.8.7 CI builds, we must force a dependency on the latest Ruby
        # 1.8.7-compatible version of ActiveSupport (i.e. pre-4.0.0).
        version.push('< 4.0.0')
      end
    end
  end
  s.add_development_dependency('activerecord', activerecord_version)
  s.add_development_dependency('actionpack', activerecord_version)
  s.add_development_dependency('datamapper')
  s.add_development_dependency('mocha', '~> 1.0.0')
  s.add_development_dependency('sequel')
  s.add_development_dependency('sqlite3')
  s.add_development_dependency('dm-sqlite-adapter')
  # Lock to "rake" version 0.9.2.2 in order to use deprecated "rake/rdoctask".
  # Once we drop official support for Ruby 1.8.7, we can loosen this constraint
  # and allow our dependencies to "float" to the latest version of "rake".
  s.add_development_dependency('rake', '0.9.2.2')
  if RUBY_VERSION < '1.9.3'
    s.add_development_dependency('rcov')
  else
    s.add_development_dependency('simplecov')
    s.add_development_dependency('simplecov-rcov')
  end
end
