require "skrape/version"
require 'nokogiri'
require 'open-uri'
require 'pry'

module Skrape

  class NoElementsFoundError < StandardError; end

  class Page

    def initialize url
      @fail_loudly = false
      @extracted_info = {}
      agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/32.0.1700.102 Chrome/32.0.1700.102 Safari/537.36"
      @document = Nokogiri::HTML(open(url, "User-Agent" => agent))
    end

    def extract
      block = Proc.new
      instance_eval &block
      @extracted_info
    end

    def error_when_selector_returns_nothing value
      @fail_loudly = value
    end

    def method_missing name, args
      feature_name = name.to_s.gsub('extract_', '').to_sym
      element = @document.css args[:with]
      if @fail_loudly
        raise NoElementsFoundError, "the css selector for '#{feature_name}' did not return anything" if element.empty?
      end
      if args[:and_run]
        @extracted_info[feature_name] = args[:and_run].call(element)
      else
        @extracted_info[feature_name] = element.text
      end
    end

  end

end
