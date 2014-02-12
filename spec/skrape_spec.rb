require 'spec_helper'

describe Skrape do

  describe Skrape::Page do

    let(:url){ "http://example.com" }
    let(:example_response){ File.new('spec/test_data/example_com_raw_response') }

    before(:each) do
      stub_request(:get, url).to_return(example_response)
    end

    it "returns the text of the element identifed by the CSS selector" do
      results = Skrape::Page.new(url).extract do
        extract_title with: 'h1'
      end
      expect(results[:title]).to eq "Example Domain"
    end

    it "accepts a block so you can do more sophisticated things" do
      results = Skrape::Page.new(url).extract do
        extract_link_href with: 'a', and_run: proc {|link| link.attr('href').value }
      end
      expect(results[:link_href]).to eq "http://www.iana.org/domains/example"
    end

    it "raises a helpful error when the CSS selector returns nothing" do
      expect{
        Skrape::Page.new(url).extract do
          extract_nothing with: 'foo'
        end
      }.to raise_error Skrape::NoElementsFoundError
    end

  end

end

