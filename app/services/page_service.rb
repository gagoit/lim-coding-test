require 'mechanize'

class PageService < ApplicationService
  def initialize(url)
    @url = url
  end

  def create!
    begin
      @page = Page.new(url: @url)

      return {success: false, error: @page.errors.full_messages.join(", ")} unless @page.valid?

      success = Page.transaction do
                  @page.save
                  crawl_content!

                  true
                end
     
      {success: success, page: @page.reload, error: I18n.t('errors.page.is_invalid')}
    rescue Exception => e
      {success: false, error: e.message}  
    end
  end

  def crawl_content!
    mechanize = Mechanize.new

    mechanize.get(@url) do |mechanize_page|
      HtmlElement.names.keys.each do |ele_name|
        eles = HtmlElementService.instance.get_elements(mechanize_page, name: ele_name)

        eles.each do |ele|
          @page.html_elements.create({name: ele_name, value: ele})
        end
      end
    end
  end
end