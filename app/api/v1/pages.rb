module V1
  class Pages < Grape::API
    include V1Base
    # include AuthenticateRequest

    helpers do
      def get_page(id)
        @page = Page.find(id)

        unless @page
          raise ApiException.new(
            http_status: RESPONSE_CODE[:not_found], 
            code: RESPONSE_CODE[:not_found], 
            message: I18n.t('errors.page.not_found')
          )
        end
      end
    end

    resource :pages do

      desc 'Indexes new page', http_codes: [
        { code: 200, message: 'success' },
        { code: RESPONSE_CODE[:unprocessable_entity], message: 'Detail error messages' }
      ]
      params do
        requires :url, type: String, desc: "Page's url"
      end
      post do
        page_s = PageService.new(params[:url])
        result = page_s.create!

        if result[:success]
          serialization = PageSerializer.new(result[:page])
          render_success(serialization.as_json)
        else
          render_error(RESPONSE_CODE[:unprocessable_entity], result[:error])
        end
      end

      desc 'Get page', headers: HEADERS_DOCS, http_codes: [
        { code: 200, message: 'success' },
        { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.page.not_found') }
      ]
      params do
        requires :id, type: String, desc: 'page id'
      end
      get ':id' do
        # authenticate!
        get_page(params[:id])

        serialization = PageSerializer.new(@page)
        render_success(serialization.as_json)
      end


      desc 'Get pages', headers: HEADERS_DOCS, http_codes: [
        { code: 200, message: 'success' },
        { code: RESPONSE_CODE[:forbidden], message: I18n.t('errors.forbidden') }
      ]
      params do
        optional :page, type: Integer, desc: 'page'
        optional :per_page, type: Integer, desc: 'per_page'
      end
      get do
        # authenticate!

        page = (params[:page] || 1).to_i
        per_page = (params[:per_page] || PER_PAGE).to_i 
        pages = Page.order("created_at DESC").page(page).per(per_page)

        serialization = ActiveModel::Serializer::CollectionSerializer.new(pages, each_serializer: PageSerializer)

        render_success({pages: serialization.as_json}, pagination_dict(pages))
      end
    end
  end
end