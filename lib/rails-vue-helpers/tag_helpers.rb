module RailsVueHelpers
  module TagHelpers
    def link_to(name = nil, options = nil, html_options = nil, &block)
      rails_tag_with_vue_data(super, block_given? ? options : html_options, :a)
    end

    def content_tag(name, content_or_options_with_block = nil, options = nil, escape = true, &block)
      _options = [content_or_options_with_block, options].find do |argument|
        argument.is_a?(Hash)
      end

      rails_tag_with_vue_data(super, _options)
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
        options["v-#{key}"] = value.to_s
      end

      (attributes['props'] || {}).each do |key, value|
        options[key] = value.to_s
      end

      if attributes['model']
        options['v-model'] = attributes['model']
      end

      remove_quotation_marks(options)
      tag_builder.tag_options(options)
    end

    def remove_quotation_marks(options)
      options.each do |key, value|
        return unless value
        next if value[0] != "\""
        next if value[-1] != "\""

        value[0] = ''
        value[-1] = ''
      end
    end
  end
end
