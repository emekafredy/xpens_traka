module Components::ModalHelper
  def modal(options: {}, html_options: {}, &block)
    html_options[:class] = merge_classes(html_options[:class])

    content = capture(&block) if block_given?

    content_tag(:div, html_options) do
      render partial: 'components/modal', locals: {
        content: content,
        modal_title: options[:modal_title]
      }
    end
  end
end
