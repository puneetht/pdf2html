#require 'rubygems'
#require 'rake/packagetask'
#require 'rake/gempackagetask'

spec = Gem::Specification.new do |s|
  s.name = "pdf2html"
  s.version = "0.2"
  s.authors = ["Puneet Paul"]
  s.email = "puneetpaul74@gmail.com"
  s.platform = Gem::Platform::RUBY
  s.description = "Ruby wrapper for pdftohtml"
  s.summary = "Provides binaries for PDFTOHTML  project in an easily accessible package."
  s.files =  ["lib/pdf2html.rb","bin/pdftohtml_linux","bin/pdftohtml_macos"]
  s.test_files = [Dir.glob('test/test*.rb'),Dir.glob('testfiles/*')].flatten  
  s.has_rdoc = false
  s.require_path = ["lib"]
  s.homepage = 'http://rubygems.org/gems/pdf2html'
end
