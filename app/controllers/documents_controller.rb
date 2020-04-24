class DocumentsController < ApplicationController
  def index
    @document = Document.new

    @documents = Document.where(user_id: current_user.id)
  end
  
  def create
    @document = current_user.documents.build(permitted_params)

    upload_file(@document)

    if @document.save
      flash[:success] = 'Document was successfully uploaded.'
      redirect_to documents_path
    end
  end

  private

  def upload_file(document)
    return unless params[:document][:file].present?

    @value = Cloudinary::Uploader.upload(params[:document][:file])
    document.file = @value['secure_url']
  end

  def permitted_params
    params.require(:document).permit(:file, :name)
  end
end
