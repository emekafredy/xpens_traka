module DocumentsHelper
  def file_icon(document)
    if File.extname(document.file) == '.pdf'
      'pdf'
    else
      'image'
    end
  end
end
