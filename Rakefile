
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

  exec "bundle exec nanoc co"
end

task :co => :compile

task :aco do

  #exec "nanoc aco" # <--- too slow, can't wait nanoc 3.2

  t = Thread.new do
    loop { `bundle exec nanoc co 2>&1`; sleep 0.5 }
  end

  sh 'open http://127.0.0.1:3000/'

  sh 'bundle exec nanoc view'

  t.join
end

task :rdoc do

  #sh "./scripts/ep2tex.rb"
  load 'scripts/ep2tex.rb'
end

task :deploy do

  #sh 'bundle exec rake deploy:rsync'
  #sh 'bundle exec rake deploy:rsync config=openwferu'

  sh 'rsync -glPrvz -e ssh --exclude=".hg" --exclude=".svn" --exclude=".git" /Users/jmettraux/w/ruote_website/output/ jmettraux@rubyforge.org:/var/www/gforge-projects/ruote'
  sh 'rsync -glPrvz -e ssh --exclude=".hg" --exclude=".svn" --exclude=".git" /Users/jmettraux/w/ruote_website/output/ jmettraux@rubyforge.org:/var/www/gforge-projects/openwferu'
  #sh 'bundle exec rake deploy:rsync config=lambda'
end

