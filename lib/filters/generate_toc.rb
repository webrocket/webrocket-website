require 'nokogiri'

module Nanoc3::Filters
  # This filter generate table of contents from section headers.
  class GenerateToc < Nanoc3::Filter
    identifiers :generate_toc

    def run(content, arguments={})
      current_level = nil
      doc = Nokogiri::HTML(content)
      toc_items = Nokogiri::XML::Node.new('ul', doc)
      doc.css('h3').each { |section|
        id = section['id']
        title = section.content
        next if id.nil?
        item = Nokogiri::XML::Node.new('li', doc)
        item.inner_html = "<a href='##{id}'>#{title}</a>"
        toc_items.add_child(item)
      }
      if toc_items.children.size > 0 
        toc = Nokogiri::XML::Node.new('aside', doc)
        toc['id'] = 'toc'
        toc.inner_html = "<h2>In this section</h2>"
        toc.add_child(toc_items)
        toc.to_s + doc.to_s
      else
        doc.to_s
      end
    end
  end
end
