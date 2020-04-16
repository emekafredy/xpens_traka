module ApplicationHelper
  def image_icon(brand, style_selector)
    image_tag(
      image_path("icons/#{brand}.svg"),
      alt: brand,
      class: style_selector
    )
  end

  def active_tab?(controller_class, action)
    controller.class == tab_names[controller_class] && controller.action_name == action
  end

  def tab_names
    {
      'dashboard' => HomepageController,
      'budget'    => HomepageController,
      'incomes'   => IncomesController,
      'expenses'  => ExpensesController,
      'documents' => HomepageController,
      'reports'   => HomepageController,
      'settings'  => HomepageController,
    }
  end
end
