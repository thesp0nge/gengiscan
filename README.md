# Gengiscan

Gengiscan is a CMS fingerprinting tool using Generator meta tag and Seerver HTTP response header to tell the technology behind a CMS serving a target website.
No intrusive attacks are performed, just a plain GET using Net::HTTP standard ruby library

## Installation

To install gengiscan gem

    $ gem install gengiscan

## Usage

Using gengiscan it's easy:

  require 'gengiscan'

  puts Gengiscan.new.detect("http://www.targetcms.com")[:generator]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
