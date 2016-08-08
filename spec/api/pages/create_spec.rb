# encoding: utf-8
require "rails_helper"

describe "Page APIs"  do
  before(:each) {
    @page_attributes = FactoryGirl.attributes_for :page
  }

  describe "POST #create" do

    context "when is created successfully" do
      after do
        expect(json_response[:meta][:code]).to eql RESPONSE_CODE[:success]
      end

      it "render created page" do
        @page_attributes[:url] = "http://api.rubyonrails.org/v4.1/classes/ActiveRecord/Enum.html"
        post "/api/pages", params: @page_attributes.to_json, headers: request_headers

        json_data = json_response[:data]

        expect(json_data[:url]).to eql @page_attributes[:url]

        expect(json_data[:html_elements]).not_to be_empty

        expect(json_data[:html_elements][0][:name]).to eq "h1"
        expect(json_data[:html_elements][0][:value]).to include "ActiveRecord::Enum"

        expect(json_data[:html_elements][1][:name]).to eq "a"
        expect(json_data[:html_elements][1][:value]).to include "http://api.rubyonrails.org/v4.1/files/activerecord/lib/active_record/enum_rb.html"
      end
    end

    context "when has error" do
      before(:each) do
      end

      it "render unprocessable_entity error when email is missing" do
        @page_attributes[:url] = ""
        post "/api/pages", params: @page_attributes.to_json, headers: request_headers

        json_data = json_response[:data]

        expect(json_data.blank?).to eql true

        expect(json_response[:meta][:code]).to eql RESPONSE_CODE[:unprocessable_entity]
        expect(json_response[:meta][:message].downcase).to include "url"
      end
    end
  end
end