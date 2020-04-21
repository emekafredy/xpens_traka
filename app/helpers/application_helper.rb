module ApplicationHelper
  def image_icon(brand, style_selector)
    image_tag(
      image_path("icons/#{brand}.svg"),
      alt: brand,
      class: style_selector
    )
  end

  def active_tab?(controller_class, actions)
    controller.class == tab_names[controller_class] && actions.include?(controller.action_name)
  end

  def tab_names
    {
      'dashboard' => HomepageController,
      'budget'    => BudgetsController,
      'incomes'   => IncomesController,
      'expenses'  => ExpensesController,
      'documents' => HomepageController,
      'reports'   => HomepageController,
      'settings'  => HomepageController
    }
  end

  def merge_classes(defaults = '', options = '')
    "#{defaults} #{options}".strip
  end

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
