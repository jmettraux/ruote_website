
#
# Re-opening the item class to add some methods.
#
class Nanoc3::Item

  def path

    path = self.identifier.split('/')
    path.delete('')

    path
  end

  def title

    t = self[:title]

    return t.match(/^(.*) expression$/)[1] if self.path[0] == 'exp'

    t
  end
end


class SidebarFilter < Nanoc3::Filter
  identifier :sidebar

  def run (content, params)

    items = if @item.path[0] == 'exp'

      @items.select { |i| i.path[0] == 'exp' }

    elsif @item.path[0] == 'part'

      @items.select { |i| i.path[0] == 'part' }

    else

      @items.reject { |i|
        i[:title].nil? ||
        (
          [ nil ] + %w[
            css js ja images rel exp part
            lists users download source resources presentations
            documentation
          ]
        ).include?(i.path[0])
      }
    end

    items = items.sort_by { |i| i[:title] }

    head_item = if @item.path[0] == 'exp'
      @items.find { |i| i.path.join('/') == 'expressions' }
    elsif @item.path[0] == 'part'
      @items.find { |i| i.path.join('/') == 'participants' }
    else
      nil
    end

    content.gsub(
      'SIDEBAR',
      render('sidebar', :items => items, :head_item => head_item))
  end
end

