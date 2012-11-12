require 'net/http'
require 'net/https'
require 'nokogiri'

module Gengiscan
  class Engine


    attr_reader :res
    attr_reader :body



    def initialize      
    end


    def detect(url)
      uri = URI(url)
      begin 
        res = Net::HTTP.get_response(uri) if uri.scheme == "http"

        body = check_for_phpinfo(uri)
        {:status=>:OK, :message=> nil, :code=>res.code, :server=>res['Server'], :powered=>res['X-Powered-By'], :generator=>get_generator_signature(res), :php_info=>! body.empty?} 
      rescue => e
        {:status=>:KO, :message=>e.message, :code=>nil, :server=>nil, :powered=>nil, :generator=>nil, :php_info=>nil}
      end
    end

    private 

    def get_generator_signature(res)
      generator = ""
      doc=Nokogiri::HTML(res.body)
      doc.xpath("//meta[@name='generator']/@content").each do |value|
        generator = value.value
      end

      generator
    end

    def check_for_phpinfo(uri)
      body = ""
      r = Net::HTTP.get_response(URI("#{uri.scheme}://#{uri.host}:#{uri.port}/phpinfo.php"))
      filename = "#{uri.host}_phpinfo.html"
      body = r.body if r.code == "200"
      r = Net::HTTP.get_response(URI("#{uri.scheme}://#{uri.host}:#{uri.port}/info.php")) if body.nil?
      filename = "#{uri.host}_info.html" if body.nil?
      body = r.body if r.code == "200" 

      f= File.new(filename, "w")
      f.puts(body)
      f.close


      body
    end


  end
end
