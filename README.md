# CCS

Configuration control system

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ccs'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ccs

## Usage

    ccs cp [OPTIONS] <(LocalPath|STDIN)|(CCSUri|Uri)> <(CCSUri|Uri)|(LocalPath|STDOUT)>

    Options:
        -a CCS_ACCESS_TOKEN,             CCS Access Token
            --access-token
        -p CCS_PASSPHRASE,               CCS Passphrase
            --passphrase
        -f, --[no-]force                 Overwrite remote documents when uploading


## Example

Download to STDOUT

    ccs cp ccs://workspace-name/0.1.0/path/to/file.yml -
    ccs cp http://host.tld:9292/workspace-name/0.1.0/path/to/file.yml -
    ccs cp https://host.tld/workspace-name/0.1.0/path/to/file.yml -

Download to local file

    ccs cp ccs://workspace-name/0.1.0/path/to/file.yml /local/path/to/file.yml

Upload local file

    ccs cp /local/path/to/file.yml ccs://workspace-name/0.1.0/path/to/file.yml

Upload local file, overwriting remote document if any'

    ccs cp --force /local/path/to/file.yml ccs://workspace-name/0.1.0/path/to/file.yml

Upload content from STDIN

    echo "{ a: 1 }" | ccs cp  - ccs://workspace-name/0.1.0/path/to/file.yml
    cat /local/path/to/file.yml | ccs cp - ccs://workspace-name/0.1.0/path/to/file.yml

## API

Upload

    require 'ccs'

    destination = 'ccs://workspace-name/0.1.0/path/to/file.yml'
    access_token = ENV.fetch('CCS_ACCESS_TOKEN')
    passphrase = 'MyPassphrase'
    content = 'RAILS_ENV=production'

    Ccs::Document.new(destination, access_token, passphrase).upload(content)

Download

    require 'ccs'

    source = 'ccs://workspace-name/0.1.0/path/to/file.yml'
    access_token = ENV.fetch('CCS_ACCESS_TOKEN')
    passphrase = 'MyPassphrase'

    Ccs::Document.new(source, access_token, passphrase).download

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bin/rake install`. To release a new version, update the version number in `version.rb`, and then run `bin/rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/occson/ccs. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

