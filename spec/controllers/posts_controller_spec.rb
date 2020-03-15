require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:valid_attributes) {
    {"title" =>"First Post", "description" => "Description of first post" }
  }

  let(:invalid_attributes) {
    {"title" =>"", "description" => "" }
  }
   let(:current_user) do
    User.create(
      email: 'vinu1@gmail.com',
      name: 'vinu',
      password: '12345'
    )
  end
  let(:valid_session) { {"user_id" => current_user.id} }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PostsController. Be sure to keep this updated too.
   #let(:valid_session) { {} }

  let(:my_post) do
    Post.create(
      title: 'my post',
      description: 'this is my first and last post',
      user_id: current_user.id)
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: {id: my_post.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: {id: my_post.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Post" do
        expect {
          post :create, params: {post: valid_attributes}, session: valid_session
        }.to change(Post, :count).by(1)
      end

      it "redirects to the created post" do
        post :create, params: {post: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Post.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {post: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "GET #index" do
    it "returns a success response" do
       post :create, params: {post: valid_attributes},session: valid_session 
       get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end 

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {title: 'updated post'}
      }

      it "updates the requested post" do
        put :update, params: {id: my_post.to_param, post: new_attributes}, session: valid_session
        my_post.reload
        expect(my_post.title).to eq('updated post')
      end

      it "redirects to the post" do
        put :update, params: {id: my_post.to_param, post: valid_attributes}, session: valid_session
        expect(response).to redirect_to(my_post)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: {id: my_post.to_param, post: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

 describe "DELETE #destroy" do
    it "destroys the requested post" do
      expect {
        delete :destroy, params: {id: my_post.id}, session: valid_session
      }.to change(Post, :count).by(1)
    end

    it "redirects to the posts list" do
      delete :destroy, params: {id: my_post.to_param}, session: valid_session
      expect(response).to redirect_to(posts_url)
    end
  end

end
