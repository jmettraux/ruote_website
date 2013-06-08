
$:.unshift(File.dirname(__FILE__))

require 'listen'
begin
  require 'nanoc3/tasks'
rescue LoadError
end

#task :upload => :compile do
#
#  account = 'jmettraux@rubyforge.org'
#  webdir = '/var/www/gforge-projects/ruote/'
#  sh "rsync -azv -e ssh --exclude '*.swp' output/ #{account}:#{webdir}"
#
#  webdir = '/var/www/gforge-projects/openwferu/'
#  sh "rsync -azv -e ssh --exclude '*.swp' output/ #{account}:#{webdir}"
#end

task :compile do

  exec 'bundle exec nanoc co'
end

task :co => :compile

task :aco do

  #exec "nanoc aco" # <--- too slow, can't wait nanoc 3.2
  queue = Queue.new

  Thread.new do
    loop { queue.pop; sh 'bundle exec nanoc co'; queue.clear }
  end
  Thread.new do
    Listen.to('content', :filter => /\.txt$/) do |mod, add, rem|
      queue << :doit
    end
  end

  sh 'bundle exec nanoc view'
end

task :rdoc do

  #sh "./scripts/ep2tex.rb"
  load 'scripts/ep2tex.rb'
end

task :deploy do

  #sh 'bundle exec rake deploy:rsync'
  #sh 'bundle exec rake deploy:rsync config=openwferu'
  #sh 'bundle exec rake deploy:rsync config=lambda'
    #
    # at some point, these ceased to work, so, went manual

  sh 'bundle exec nanoc co'

  out = File.expand_path(File.dirname(__FILE__)) + '/output/'
  opts = '-glPrvz -e ssh --exclude=".hg" --exclude=".svn" --exclude=".git"'

  sh "rsync #{opts} #{out} jmettraux@rubyforge.org:/var/www/gforge-projects/ruote"
  sh "rsync #{opts} #{out} jmettraux@rubyforge.org:/var/www/gforge-projects/openwferu"
end

