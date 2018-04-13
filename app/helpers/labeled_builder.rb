class LabeledBuilder < ActionView::Helpers::FormBuilder

  def self.create_labeled_field(method_name)
    define_method(method_name) do |label, *args|
      @template.content_tag(
        'p',
        @template.content_tag(
          'label',
          label.to_s.humanize,
          :for => "#{@object_name}_#{label}"
        ) + '<br/>' + super
      )
    end
  end

  field_helpers.concat(['date_select', 'datetime_select']).each do |name|
    create_labeled_field(name)
  end

end
