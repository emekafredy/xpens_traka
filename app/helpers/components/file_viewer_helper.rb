module Components::FileViewerHelper
  def file_viewer(options: {})
    if File.extname(options[:url]) == '.pdf'
      pdf_viewer(options[:url])
    else
      image_viewer(options[:url])
    end
  end

  def pdf_viewer(url)
    content_tag(:div) do
      content_tag(:iframe, nil, src: "https://docs.google.com/gview?url=#{url}&embedded=true", class: 'pdf--iframe') +
      content_tag(:a, 'View in full', href: url, target: '_blank')
    end
  end

  def image_viewer(url)
    cl_image_tag(url, options = { class: 'incomes--payslip' })
  end
end
