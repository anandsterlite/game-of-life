require 'rake'
require 'rake/testtask'

task :default => :play

desc "Run all test cases"
Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.pattern = 'test/unit/*.rb'
  t.verbose = true
end


desc "Start Game"
task "play" do
  ruby 'lib/player.rb'
end