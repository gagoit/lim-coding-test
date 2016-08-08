require 'singleton'
require 'mechanize'

class HtmlElementService < ApplicationService
  include Singleton

  def initialize

  end

  def get_elements(mechanize_page, name: :h1)
    @mechanize_page = mechanize_page

    cate = HtmlElement::CATEGORIES[name.to_sym]

    send("get_#{cate}", name)
  end

  def get_header_tags(name)
    eles = @mechanize_page.search(name.to_s)
    
    eles.map {|e| e.to_s}
  end

  def get_links(name)
    @mechanize_page.links.map do |link|
      begin
        link.node.to_s.gsub("href=\"#{link.href}\"", "href=\"#{link.resolved_uri.to_s}\"")
      rescue Mechanize::UnsupportedSchemeError => e
        link.node.to_s
      end
    end
  end
end