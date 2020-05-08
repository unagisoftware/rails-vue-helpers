module RailsVueHelpers
  module TagHelpers
    def link_to(name = nil, options = nil, html_options = nil, &block)
      options = html_options unless block_given?

      rails_tag_with_vue_data(super, options, :a)
    end

    def content_tag(name, content_or_options_with_block = nil, options = nil, escape = true, &block)
      options = [content_or_options_with_block, options].find do |argument|
        argument.is_a?(Hash)
      end

      rails_tag_with_vue_data(super, options)
    end

    def check_box_tag(name, value = '1', checked = false, options = {})
      rails_tag_with_vue_data(super, options, :input)
    end

    private

    def rails_tag_with_vue_data(rails_tag, options, tag_name = nil)
      regex = rails_tag[/<#{tag_name}.+?>/][/(?:(?!>).)*/]

      rails_tag.gsub(regex, "\\0 #{vue_data(options)}").html_safe
    end

    def vue_data(options)
      options  ||= {}
      attributes = (options[:vue] || options['vue'] || {}).stringify_keys
      options    = {}

      (attributes['bind'] || {}).each do |key, value|
        options[":#{key}"] = value
      end

      (attributes['on'] || {}).each do |key, value|
        options["@#{key}"] = value
      end

      (attributes['directives'] || {}).each do |key, value|
        options["v-#{key}"] = value
      end

      (attributes['props'] || {}).each do |key, value|
        options[key] = value.to_s
      end

      if attributes['model']
        options['v-model'] = attributes['model']
      end

      tag_builder.tag_options(options)
    end
  end
end
