# encoding: utf-8
require "rails_helper"

describe "Page APIs"  do
  
  before(:each) {
    @page = create :page
  }

  describe "GET #index" do

    context "when success" do
      after do
        expect(json_response[:meta][:code]).to eql RESPONSE_CODE[:success]
      end

      it "render empty array if has no Page" do
        @page.destroy
        get "/api/pages", params: {}, headers: request_headers

        json_data = json_response[:data]

        expect(json_data[:pages].blank?).to eql true

        expect(json_response[:meta][:current_page]).to eql 1
        expect(json_response[:meta][:next_page]).to eql -1
        expect(json_response[:meta][:prev_page]).to eql -1
        expect(json_response[:meta][:total_pages]).to eql 0
        expect(json_response[:meta][:total_count]).to eql 0
      end

      it "render array with one Page if has only one Page" do
        get "/api/pages", params: {}, headers: request_headers

        json_data = json_response[:data]

        expect(json_data[:pages].length).to eql 1

        json_page = json_data[:pages][0]

        expect(json_page[:uid]).to eql @page.id
        expect(json_page[:url]).to eql @page.url

        expect(json_response[:meta][:current_page]).to eql 1
        expect(json_response[:meta][:next_page]).to eql -1
        expect(json_response[:meta][:prev_page]).to eql -1
        expect(json_response[:meta][:total_pages]).to eql 1
        expect(json_response[:meta][:total_count]).to eql 1
      end

      it "render the Pages json in page = 1 & per_page = 20" do
        sleep 2
        @page1 = create :page

        get "/api/pages", params: {page: 1, per_page: 20}, headers: request_headers

        json_data = json_response[:data]

        expect(json_data[:pages].length).to eql 2

        json_page = json_data[:pages][0]

        expect(json_page[:uid]).to eql @page1.id
        expect(json_page[:url]).to eql @page1.url

        json_page = json_data[:pages][1]

        expect(json_page[:uid]).to eql @page.id
        expect(json_page[:url]).to eql @page.url

        expect(json_response[:meta][:current_page]).to eql 1
        expect(json_response[:meta][:next_page]).to eql -1
        expect(json_response[:meta][:prev_page]).to eql -1
        expect(json_response[:meta][:total_pages]).to eql 1
        expect(json_response[:meta][:total_count]).to eql 2
      end

      it "render the Pages json in page = 1 & per_page = 1" do
        sleep 2
        @page1 = create :page

        get "/api/pages", params: {page: 1, per_page: 1}, headers: request_headers

        json_data = json_response[:data]

        expect(json_data[:pages].length).to eql 1

        json_page = json_data[:pages][0]

        expect(json_page[:uid]).to eql @page1.id
        expect(json_page[:url]).to eql @page1.url

        expect(json_response[:meta][:current_page]).to eql 1
        expect(json_response[:meta][:next_page]).to eql 2
        expect(json_response[:meta][:prev_page]).to eql -1
        expect(json_response[:meta][:total_pages]).to eql 2
        expect(json_response[:meta][:total_count]).to eql 2
      end

      it "render the Pages json in page = 2 & per_page = 1" do
        sleep 2
        @page1 = create :page

        get "/api/pages", params: {page: 2, per_page: 1}, headers: request_headers

        json_data = json_response[:data]

        expect(json_data[:pages].length).to eql 1

        json_page = json_data[:pages][0]

        expect(json_page[:uid]).to eql @page.id
        expect(json_page[:url]).to eql @page.url

        expect(json_response[:meta][:current_page]).to eql 2
        expect(json_response[:meta][:next_page]).to eql -1
        expect(json_response[:meta][:prev_page]).to eql 1
        expect(json_response[:meta][:total_pages]).to eql 2
        expect(json_response[:meta][:total_count]).to eql 2
      end
    end

    # context "when has error" do
    #   before(:each) do
    #   end
    # end
  end
end