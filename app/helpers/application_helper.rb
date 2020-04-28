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
      'documents' => DocumentsController,
      'settings'  => HomepageController
    }
  end

  def merge_classes(defaults = '', options = '')
    "#{defaults} #{options}".strip
  end

  def in_currency(value)
    number_to_currency(value, unit: '₦')
  end
end
