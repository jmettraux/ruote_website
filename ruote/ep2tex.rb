#!/usr/bin/env ruby

require 'fileutils'
require File.join(File.dirname(__FILE__), 'rdoc2tex')

RUOTE = '../../ruota'

FileUtils.mkdir('tex') rescue nil

paths = []

src = File.expand_path(File.join(*%w[ ~ w ruota lib ruote exp ]))
paths = paths + Dir.glob(File.join(src, "fe_*.rb"))

src = File.expand_path(File.join(*%w[ ~ w ruota lib ruote part ]))
paths = paths + Dir.glob(File.join(src, "*_participant.rb"))

src = File.expand_path(File.join(*%w[ ~ w ruote-dm lib ruote dm part ]))
paths = paths + Dir.glob(File.join(src, "*_participant.rb"))

src = File.expand_path(File.join(*%w[ ~ w ruote-amqp lib ])) # :(
paths = paths + Dir.glob(File.join(src, "*_participant.rb"))


paths.each do |path|

  puts "..#{path}"

  lines = translate(path, 2)

  fname = File.basename(path)

  type, item = if m = fname.match(/^(.+\_participant)\.rb$/)
    [ '', m[1] ]
  else
    [ 'expression', fname[3..-4] ]
  end

  target = "#{fname[0..-4]}.txt"
  target = target[3..-1] if target.match(/^fe\_/)

  File.open(File.join('tex', target), 'w') do |f|

    f.puts(%{---
title: #{item} #{type}
filter:
  - erb
  - textile
---

h2. #{item}

})

    lines.each do |l|
      f.puts(l)
    end
  end
end

