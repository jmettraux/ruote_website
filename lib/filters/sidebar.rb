
#
# Re-opening the item class to add some methods.
#
class Nanoc3::Item

  def path

    path = self.identifier.split('/')
    path.delete('')

    path
  end
end


class SidebarFilter < Nanoc3::Filter
  identifier :sidebar

  def run (content, params)

    items = @items.reject { |i|
      ([ nil ] + %w[ css js ja images rel exp part ]).include?(i.path[0])
    }.sort_by { |e| e[:title] }

    content.gsub('SIDEBAR', render('sidebar', :items => items))
  end
end

