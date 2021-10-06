# OCCSON

Store, manage and deploy configuration securely with Occson.

## Installation

Add this line to your application's Gemfile:

    gem 'occson'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install occson

## Usage

    occson cp [OPTIONS] <(LocalPath|STDIN)|(OccsonUri|Uri)> <(OccsonUri|Uri)|(LocalPath|STDOUT)>

    Options:
        -a OCCSON_ACCESS_TOKEN,             Occson access token
            --access-token
        -p OCCSON_PASSPHRASE,               Occson passphrase
            --passphrase
        -f, --[no-]force                    Overwrite remote documents when uploading


## Example

Download to STDOUT

    occson cp occson://0.1.0/path/to/file.yml -
    occson cp https://api.occson.com/0.1.0/path/to/file.yml -
    occson cp http://host.tld:9292/0.1.0/path/to/file.yml -
    occson cp https://host.tld/0.1.0/path/to/file.yml -

Download to local file

    occson cp occson://0.1.0/path/to/file.yml /local/path/to/file.yml

Upload local file

    occson cp /local/path/to/file.yml occson://0.1.0/path/to/file.yml

Upload local file, overwriting remote document if any'

    occson cp --force /local/path/to/file.yml occson://0.1.0/path/to/file.yml

Upload content from STDIN

    echo "{ a: 1 }" | occson cp  - occson://0.1.0/path/to/file.yml
    cat /local/path/to/file.yml | occson cp - occson://0.1.0/path/to/file.yml

## API

Upload

    require 'occson'

    destination = 'occson://0.1.0/path/to/file.yml'
    access_token = ENV.fetch('OCCSON_ACCESS_TOKEN')
    passphrase = 'MyPassphrase'
    content = 'RAILS_ENV=production'

    Occson::Document.new(destination, access_token, passphrase).upload(content)

Download

    require 'occson'

    source = 'occson://0.1.0/path/to/file.yml'
    access_token = ENV.fetch('OCCSON_ACCESS_TOKEN')
    passphrase = 'MyPassphrase'

    Occson::Document.new(source, access_token, passphrase).download

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bin/rake install`. To release a new version, update the version number in `version.rb`, and then run `bin/rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Documentation

Documentation for the code should be written in YARD format. It can be generated locally into the `doc` directory by running

    bundle exec yard


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/occson/occson.rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

