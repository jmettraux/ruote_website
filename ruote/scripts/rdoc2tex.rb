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

class Translation

  def initialize (lines)

    @a = []
    @in_code = false

    lines.each { |l| self.ingest(l) }
  end

  def to_a

    if @in_code
      if @a[-1] == ''
        @a[-1] = "<% end %>"
      else
        @a << "<% end %>"
      end
    end

    @a
  end

  protected

  def ingest (l)

    if @in_code == false && l.match(/^  [^ ]/)

      @in_code = true
      @a << '<pre class="brush: ruby">'
      @a << l

    elsif @in_code == true && l.match(/^[^ ]/)

      @in_code = false
      if @a.last.match(/^$/)
        @a[-1] = '</pre>'
        @a << ""
      else
        @a << '</pre>'
      end
      #@a << l
      ingest(l)

    elsif m = l.match(/^(=+) (.+)$/)

      @a << "h#{m[1].length + H_OFFSET}. #{m[2]}"

    elsif m = l.match(/^(http:\/\/.+)$/) # links

      @a << "\"#{m[1]}\":#{m[1]}"

    else

      @a << l

      #if l != '' && @a[-1] && @a[-1] != ''
      #  @a[-1] = "#{@a[-1]} #{l}"
      #else
      #  @a << l
      #end
    end
  end
end

def translate (path, indent=2)

  lines = File.readlines(path)
  lines = lines.select { |l| l.match /^#{ ' ' * indent}#/ }
  lines = lines.collect { |l| l[indent + 2..-1] }

  Translation.new(lines).to_a
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

