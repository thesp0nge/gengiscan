require 'net/http'
require 'nokogiri'

module Gengiscan
  class Engine


    attr_reader :res



    def initialize(url)
      @uri = URI(url)

    end

    def detect
      @res = Net::HTTP.get_response(@uri)

      {:code=>@res.code, :server=>@res['Server'], :generator=>get_generator_signature} #if res == Net::HTTPOK 
    end

    private 
    def get_generator_signature

      generator = ""
      doc=Nokogiri::HTML(@res.body)
      doc.xpath("//meta[@name='generator']/@content").each do |value|
        generator = value.value
      end

      generator
    end

  end
end
