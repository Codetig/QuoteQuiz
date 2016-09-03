require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs = ["tests"]
  t.warning = true
  t.verbose = true
  t.test_files = FileList['tests/test_*.rb']
end

task :default => :test