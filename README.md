# Skrape

Skrape provides a cute DSL for extracting information from pages on the
web. You give it a url and a block and it gives you back a hash.

## Installation

Add this line to your application's Gemfile:

    gem 'skrape'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install skrape

## Usage

Lets say you have a page like this:

    <html><body><h1>I am a title</h1></body></html>

And you want a hash like this:

    {title: "I am a title"}

You can run Skrape like this:

    results = Skrape::Page.new("http://example.com").extract do
      extract_title with: 'h1'
    end

Skrape will give you the elements text by default, but in cases where
you are after something else, or need to do some massaging of the data,
you can pass a block:

    results = Skrape::Page.new(url).extract do
      extract_link_href with: 'a', and_run: proc {|link| link.attr('href').value }
    end

The element(s) will be passed into the block as a
Nokogiri::XML::NodeSet for you to play with. Whatever text you return
will be added to the hash of things to return.


## Contributing

1. Fork it ( http://github.com/sleepycat/skrape/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
