# encoding: utf-8
require "rails_helper"

describe "Page APIs"  do
  describe "GET #show" do

    context "when success" do
      before(:each) do
        @page = create :page
      end

      after do
        expect(json_response[:meta][:code]).to eql RESPONSE_CODE[:success]
      end

      it "render page json" do
        get "/api/pages/#{@page.id}", params: {}, headers: request_headers

        json_data = json_response[:data]

        expect(json_data[:uid]).to eql @page.id
        expect(json_data[:url]).to eql @page.url
      end
    end

    context "when error" do
      it "returns not_found error when page id is not found" do
        get "/api/pages/1111", params: {}, headers: request_headers

        json_data = json_response[:data]

        expect(json_data.blank?).to eql true
        expect(json_response[:meta][:code]).to eql RESPONSE_CODE[:not_found]
        expect(json_response[:meta][:message]).to eql I18n.t("errors.page.not_found")
      end
    end
  end
end

