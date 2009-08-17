#!/usr/bin/env ruby

H_OFFSET = 1

def print_usage
  puts
  puts "#{$0} [-l 2] {path_to_file}"
  puts
  puts "  extracts all the comments at a given level of identation"
  puts "  and turn them from rdoc to textile"
  puts
end

def translate (path, indent=2)

  lines = File.readlines(path)
  lines = lines.select { |l| l.match /^#{ ' ' * indent}#/ }
  lines = lines.collect { |l| l[indent + 2..-1] }

  in_code = false

  result = lines.inject([]) do |a, l|

    if in_code == false && l.match(/^  [^ ]/)

      in_code = true
      a << "<% coderay(:lang => 'ruby', :line_numbers => 'inline') do -%>"
      a << l

    elsif in_code == true && l.match(/^[^ ]/)

      in_code = false
      if a.last.match(/^$/)
        a[-1] = "<% end %>"
        a << ""
      else
        a << "<% end %>"
      end
      a << l

    elsif m = l.match(/^(=+) (.+)$/)

      a << "h#{m[1].length + H_OFFSET}. #{m[2]}"

    else

      a << l

    end

    a
  end

  if in_code
    if result[-1] == ''
      result[-1] = "<% end %>"
    else
      result << "<% end %>"
    end
  end

  result
end

if $0 == __FILE__

  if ARGV.length < 1
    print_usage
    exit 1
  end

  file = nil
  indent = 2

  pos = 0
  while a = ARGV[pos]
    if a == '-l' || a == '--level'
      indent = ARGV[pos].to_i
      pos = pos + 1
    else
      file = a
    end
    pos = pos + 1
  end

  translate(file, indent).each { |l| puts l }
end

