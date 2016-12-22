# Capistrano::Scm::None

This is [SCM Plugin](http://capistranorb.com/documentation/advanced-features/custom-scm/)
for [Capistrano 3.7+](http://capistranorb.com/). It allows you define your own 
`deploy:upload` task that gets called to put code on the remote hosts. 

Why? I use Capistrano to deploy a number of Clojure apps. These apps only 
need the compiled JAR file. Maybe one or two support files. Also makes 
sense to compile once on the local machine/build server and deploy to
multiple hosts. I love Capistrano and have been using it for a long time,
but w/ the v3 the copy deploy strategry was removed. I don't really 
disagree with that and this is actually cleaner then how I was doing things
in v2.


## Installation

Add this line to your application's Gemfile:

```ruby
group :development do
  gem "capistrano-scm-none", "~> 0.1"
end
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-scm-none


## Usage

In your `Capfile` require the gem and install the plugin. Comment out
any current SCM plugin.

```ruby
require 'capistrano/scm/none'
install_plugin Capistrano::Scm::None::Plugin
```

In a rake file in `/lib/capistrano/tasks` add a `deploy:upload` task that
uploads whatever files you need.

Here's an example.

```ruby
namespace :deploy do
  desc "upload jar"
  task :upload do
    on release_roles :all do
      upload! "target/standalone.jar", 
        "#{release_path}/standalone.jar"

      upload! "target/run.sh", "#{release_path}/run.sh"
      
      within release_path do
        execute :chmod, '+x', 'run.sh'
      end
    end
  end
end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, 
run `rake test` to run the tests. You can also run `bin/console` for an 
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 


## Todo

* Better tests.
* Get SCM revision number from local repo.


## Contributing

Bug reports and pull requests are welcome on GitHub at 
<https://github.com/candland/capistrano-scm-none>.


## License

The gem is available as open source under the terms of 
the [MIT License](http://opensource.org/licenses/MIT).


