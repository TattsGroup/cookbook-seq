require 'rspec/core/rake_task'
require 'foodcritic'
require 'rubocop/rake_task'
require 'kitchen/rake_tasks'

FoodCritic::Rake::LintTask.new
RuboCop::RakeTask.new
RSpec::Core::RakeTask.new(:rspec)
Kitchen::RakeTasks.new

task default: [:rubocop, :foodcritic, :rspec]
