require 'rubygems'
require 'rake'


require File.dirname(__FILE__) + "/lib/rblip.rb"

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.version = RBlipInfo::VERSION
    gemspec.name = "rblip"
    gemspec.summary = "Blip Api for Ruby"
    gemspec.description = "I've got big Ballz!!!"
    gemspec.email = "jakub.oboza@gmail.com"
    gemspec.homepage = "http://github.com/JakubOboza/rblip"
    gemspec.authors = ["Jakub Oboza"]
    gemspec.add_dependency "json", ">= 1.1.9"
    gemspec.files.include %w( lib/rblip.rb )
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end