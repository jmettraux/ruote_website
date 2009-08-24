#!/usr/bin/env ruby

require 'fileutils'
require File.join(File.dirname(__FILE__), 'rdoc2tex')

RUOTE = '../../ruota'

FileUtils.mkdir('tex') rescue nil

paths = []

src = File.expand_path(File.join(*%w[ ~ ruota lib ruote exp ]))
paths = paths + Dir.glob(File.join(src, "fe_*.rb"))

src = File.expand_path(File.join(*%w[ ~ ruota lib ruote part ]))
paths = paths + Dir.glob(File.join(src, "*_participant.rb"))

src = File.expand_path(File.join(*%w[ ~ ruote-dm lib ruote dm part ]))
paths = paths + Dir.glob(File.join(src, "*_participant.rb"))

src = File.expand_path(File.join(*%w[ ~ ruote-amqp lib ])) # :(
paths = paths + Dir.glob(File.join(src, "*_participant.rb"))


paths.each do |path|

  lines = translate(path, 2)

  File.open(File.join('tex', "#{File.basename(path)}.txt"), 'w') do |f|
    lines.each do |l|
      f.puts(l)
    end
  end
end

