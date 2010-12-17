
require 'nanoc3/tasks' rescue nil

task :install_dependencies do

  sh "gem install nanoc haml rack RedCloth mime-types"
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

  sh "nanoc co"
end

task :aco do

  sh "nanoc aco"
end

task :rdoc do

  #sh "./scripts/ep2tex.rb"
  load 'scripts/ep2tex.rb'
end

