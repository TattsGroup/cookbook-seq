require 'rspec/core/rake_task'
require 'foodcritic'
require 'rubocop/rake_task'

FoodCritic::Rake::LintTask.new
RuboCop::RakeTask.new
RSpec::Core::RakeTask.new(:rspec)

task default: [:rubocop, :foodcritic, :rspec]

desc 'Checks for required dependencies.'
task :check do
  puts 'Nothing to do yet...'
end

desc 'Builds the package.'
task :build do
  puts 'Nothing to do yet...'
end
