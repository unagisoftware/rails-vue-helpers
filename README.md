# Rails::Vue::Helpers

**VueHelpers** is a small gem developed by [Unagi](https://unagi.com.ar/) for Ruby on Rails applications. It has built-in helpers with [Vue.js](https://vuejs.org/) compatibility in order to use some of the most common Rails helpers with Vue.js directives.

The gem extends the implementation of Rails' `link_to`, `content_tag` and `check_box_tag` in order to support Vue.js directives.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails-vue-helpers'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rails-vue-helpers

## Usage

This gem extends some of the most commons Rails helpers, so the original helpers can be used in the same way as before without any modification.

However, if you'd like to add some Vue directives, you should consider this gem syntax. The following options apply for all the helpers the gem provides, which at the present time are: `link_to`, `content_tag` and `check_box_tag`.

All the options are received as values of the `vue` key. This key is another option such as `class` or `id`, which are officially supported by Rails helpers. So, a full example could be the next one:

```ruby
<%= link_to users_path,
  class: 'btn btn-primary',
  vue: {
    bind: {class: "disabledUsersLink && 'disabled'"},
    on:   {click: "handleExportCookie('#{request.uuid}')"}
  },
  title: 'This action will redirect you to users list' do
%>
  Go to users list
<% end %>
```

### v-bind
`v-bind` is used for one-way data binding. Whenever you need to add one or more `v-bind` directives on a tag, you could use the `binding` key inside the `vue` hash. Its value must be a hash: each key is an attribute binding, whereas its value is the associated binding evaluation.

```ruby
<%= link_to 'Users list', users_path,
  class: 'btn btn-primary',
  vue: {
    bind: {
      class: "disabledUsersLink && 'disabled'",
      title: 'usersLinkTitle'
    }
  }
%>
```

### v-on
`v-bind` is used for events handling. If you need to use one or more `v-on` directives on a tag, you must use the `on` key inside the `vue` hash. Its value must be a hash: each key is an event name, whereas its value is the action it will perform when the event is listened.

```ruby
<%= link_to 'Users list', users_path,
  class: 'btn btn-primary',
  vue: {
    on: {
      click:     "handleExportCookie('#{request.uuid}')"},
      mouseover: 'displayHint'
    }
  }
%>
```

### v-model
`v-model` directive is used for two-way data binding. This feature is available using the `model` key of the `vue` hash. Its value must be a string, which represents the evaluation of the `v-model`.

```ruby
<%= check_box_tag "customers_id[]",
  customer.id,
  false,
  class: 'customers_id',
  vue: {
    model: 'selectedUsers'
  }
%>
```

### Directives
Vue has a lot of directives, so the gem implements the `directives` key to support all of them. Directives like `v-show`, `v-if` or `v-for`, and even custom components directives can be used with this. In order to use it, you must set the `directives` key inside the `vue` hash. Its value must be a hash: each key is a directive, whereas its value is the associated data.

```ruby
<%= content_tag :span, '10% discount',
  class: 'text-bold',
  vue: {
    directives: {
      show: 'showCouponsForm'
    }
  }
%>
```

### Props
Components properties are available through the `props` key of the `vue` hash. Its value must be a hash: each key is a prop, and its value is property data.

```ruby
<%= content_tag :select2, '',
  vue: {
    props: {
      ajax:              '/users/autocomplete',
      placeholder:       'Search...',
      name:              'filter[user_id]'
    }
  }
%>
```

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/unagisoftware/rails-vue-helpers.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
