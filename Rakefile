
begin
  require 'nanoc3/tasks'
rescue LoadError
end

task :install_dependencies do

  sh 'gem install nanoc haml rack RedCloth mime-types adsf'
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

  exec "nanoc co"
end

task :co => :compile

task :aco do

  #exec "nanoc aco" # <--- too slow, can't wait nanoc 3.2

  t = Thread.new do
    loop { `nanoc co > /dev/null 2>&1`; sleep 0.5 }
  end

  sh 'nanoc view'

  t.join
end

task :rdoc do

  #sh "./scripts/ep2tex.rb"
  load 'scripts/ep2tex.rb'
end

task :deploy do

  sh 'rake deploy:rsync'
  sh 'rake deploy:rsync config=openwferu'
end

