# FactoryBot::Sorbet

TODO: Delete this and the text below, and describe your gem

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/factory_bot/sorbet`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add factory_bot-sorbet
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install factory_bot-sorbet
```

## Usage

This gems adds the module `FactoryBot::Sorbet` which contains
methods for using all your factories in a type-safe way.

### The problem

Given a factory

```rb
FactoryBot.define do
  factory :foo, class_name: "Foo" do
    bar { "BAR!" }
  end
end
```

Using regular FactoryBot you'd use it like so:

```rb
FactoryBot.create(:foo, baz: 1) #=> #<Foo:0x0000000106021fc8 @bar="BAR!" @baz=1>
FactoryBot.build(:foo, baz: 2) #=> #<Foo:0x0000000106021fc8 @bar="BAR!" @baz=2>
FactoryBot.build_stubbed(:foo, baz: 3) #=> #<Foo:0x0000000106021fc8 @bar="BAR!" @baz=3>
```

This DSL has one problem when used with sorbet. It is impossible to create
a static signature for `create`, `build`, `build_stubbed` because they
return a different type each time based on the first argument.

### The solution

This gem defines unique methods for each factory and defines
static sorbet signatures for them using a Tapioca compiler.

```rb
FactoryBot::Sorbet.foo(:create, baz: 1) #=> #<Foo:0x0000000106021fc8 @bar="BAR!" @baz=1>
FactoryBot::Sorbet.foo(:build, baz: 2) #=> #<Foo:0x0000000106021fc8 @bar="BAR!" @baz=2>
FactoryBot::Sorbet.foo(:build_stubbed, baz: 3) #=> #<Foo:0x0000000106021fc8 @bar="BAR!" @baz=3>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Verseth/ruby-factory_bot-sorbet.
