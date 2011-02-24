#!/usr/bin/env ruby

require 'fileutils'
require File.join(File.dirname(__FILE__), 'rdoc2tex')

FileUtils.mkdir('tex') rescue nil

RUOTE_PATH = "#{ENV['HOME']}/w/ruote/lib/ruote"

paths = []

src = File.expand_path(File.join(RUOTE_PATH, 'exp'))
paths = paths + Dir.glob(File.join(src, 'fe_*.rb'))

src = File.expand_path(File.join(RUOTE_PATH, 'part'))
paths = paths + Dir.glob(File.join(src, '*_participant.rb'))

src = File.expand_path(File.join(RUOTE_PATH, 'receiver'))
paths = paths + Dir.glob(File.join(src, '*_receiver.rb'))

#src = File.expand_path(File.join(*%w[ ~ w ruote-dm lib ruote dm part ]))
#paths = paths + Dir.glob(File.join(src, "*_participant.rb"))
#src = File.expand_path(File.join(*%w[ ~ w ruote-amqp lib ])) # :(
#paths = paths + Dir.glob(File.join(src, "*_participant.rb"))

paths <<
  "#{ENV['HOME']}/w/rufus/rufus-decision/lib/rufus/decision/participant.rb"


paths.each do |path|

  puts "..#{path}"

  lines = translate(path, 2)

  fname = File.basename(path)

  type, item = if path.match(/decision/)
    [ '', 'decision_participant' ]
  elsif fname.match(/fe_participant.rb$/)
    [ 'expression', 'participant' ]
  elsif m = fname.match(/^(.+\_participant)\.rb$/)
    [ '', m[1] ]
  else
    [ 'expression', fname[3..-4] ]
  end

  target = "#{fname[0..-4]}.txt"
  target = target[3..-1] if target.match(/^fe\_/)
  target = 'decision_participant.txt' if path.match(/decision/)

  target = type == 'expression' ?
    File.join('content', 'exp', target) :
    File.join('content', 'part', target)

  puts "   --> #{target}"

  File.open(target, 'w') do |f|

    f.puts(%{---
title: #{item} #{type}
---

h2. #{item}

})

    lines.each do |l|
      f.puts(l)
    end
  end
end

