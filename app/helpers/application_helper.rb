module ApplicationHelper
  def brand_image(brand, style_selector)
    image_tag(
      image_path("icons/#{brand}.svg"),
      alt: brand,
      class: style_selector
    )
  end
end
