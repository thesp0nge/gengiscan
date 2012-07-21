require 'spec_helper'
include WebMock::API

describe 'gengiscan' do
  let(:g) {Gengiscan::Engine.new}

  describe 'when the server is up and running' do
    it 'returns a status saying OK' do
      stub_request(:get, "http://www.test.com/index.html").
         with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
         to_return(:status=>200, :body=>"<!DOCTYPE html><html><head><meta name=\"generator\" content=\"WordPress 2.3\" /></head><body>A test cms powered</body></html>", :headers=>{})
    hash = g.detect('http://www.test.com/index.html')
    hash[:status].should == :OK


    end

  it 'detect generator meta tag' do
    stub_request(:get, "http://www.test.com/index.html").
         with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
         to_return(:status=>200, :body=>"<!DOCTYPE html><html><head><meta name=\"generator\" content=\"WordPress 2.3\" /></head><body>A test cms powered</body></html>", :headers=>{})

    hash = g.detect('http://www.test.com/index.html')
    hash[:generator].should == "WordPress 2.3"
  end

  it 'detect server header' do
    stub_request(:get, "http://www.test.com/index.html").
         with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
         to_return(:status=>200, :body=>"<!DOCTYPE html><html><head><meta name=\"generator\" content=\"WordPress 2.3\" /></head><body>A test cms powered</body></html>", :headers=>{'Server' => 'Apache'})
    hash = g.detect('http://www.test.com/index.html')
    hash[:server].should == "Apache"
  end


  it 'detect x-powered-by header' do
    stub_request(:get, "http://www.test.com/index.html").
         with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
         to_return(:status=>200, :body=>"<!DOCTYPE html><html><head><meta name=\"generator\" content=\"WordPress 2.3\" /></head><body>A test cms powered</body></html>", :headers=>{'X-Powered-By' => 'Linux'})
    hash = g.detect('http://www.test.com/index.html')
    hash[:powered].should == "Linux"
  end

  end
  describe 'when the server does not exist' do
    it 'returns a status saying KO' do
      hash = g.detect('http://i-dont-exist.it')
      hash[:status].should == :KO
    end
  end
end
