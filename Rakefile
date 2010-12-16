
#
# TO THE WEB

task :upload => :build do

  account = 'jmettraux@rubyforge.org'
  webdir = '/var/www/gforge-projects/ruote/'
  sh "rsync -azv -e ssh --exclude '*.swp' output/ #{account}:#{webdir}"

  webdir = '/var/www/gforge-projects/openwferu/'
  sh "rsync -azv -e ssh --exclude '*.swp' output/ #{account}:#{webdir}"
end

task :build do

  sh "webby build"
end

task :autobuild do

  sh "webby autobuild"
end

task :rdoc do

  #sh "./scripts/ep2tex.rb"
  load 'scripts/ep2tex.rb'
end

