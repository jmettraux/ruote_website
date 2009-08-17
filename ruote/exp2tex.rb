#!/usr/bin/env ruby

require 'fileutils'
require File.join(File.dirname(__FILE__), 'rdoc2tex')

RUOTE = '../../ruota'

FileUtils.mkdir('exptex') rescue nil

exp_path = File.expand_path(File.join(*%w[ ~ ruota lib ruote exp ]))
exps_path = Dir.glob(File.join(exp_path, "fe_*.rb"))

exps_path.each do |path|

  lines = translate(path, 2)

  File.open(File.join('exptex', "#{File.basename(path)}.txt"), 'w') do |f|
    lines.each do |l|
      f.puts(l)
    end
  end
end

