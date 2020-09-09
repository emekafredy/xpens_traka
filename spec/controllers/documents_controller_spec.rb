require 'rails_helper'

RSpec.describe DocumentsController, type: :controller do
  before(:each) { login_user }

  let(:document_attributes) { { file: 'my-doc.jpg' } }
  let(:secure_url) { 'secure-doc.jpg' }
  
  describe 'GET #index' do
    let!(:documents) { create_list(:document, 1, user_id: subject.current_user.id) }
    
    context 'when user is logged in' do
      it 'renders the index page for documents' do
        get :index

        expect(response).to render_template('index')
        expect(response).to be_successful
      end

      it 'gets the list of user\'s documents' do
        get :index

        expect(response).to be_successful
        expect(documents.length).to eq 1
      end
    end
  end

  describe 'POST #create' do
    before do
      allow(Cloudinary::Uploader).to receive(:upload).with('my-doc.jpg') { secure_url }
    end

    context 'with valid attributes' do
      it 'saves a new expense' do
        expect(Document.count).to eq 0

        post :create, params: { document: document_attributes }
      end
    end
  end
end
