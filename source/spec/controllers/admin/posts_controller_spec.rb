require 'spec_helper'

describe Admin::PostsController do
  describe "admin panel" do
    it "#index" do
      get :index
      response.status.should eq 200
    end

    it "#new" do
      get :new
      expect(response).to be_success
      expect(assigns(:post)).to be_a Post
      expect(assigns(:post).id).to be_nil
    end

    context "#create" do
      it "creates a post with valid params" do
        expect {
          post :create, :post => FactoryGirl.attributes_for(:post)
        }.to change { Post.count }.by(1)
        expect(response).to be_redirect
      end

      it "doesn't create a post when params are invalid" do
        expect {
          post :create
        }.not_to change { Post.count }
        expect(response).not_to be_redirect
      end
    end

    context "#edit" do
      it "should find a post from params" do
        post = FactoryGirl.create(:post)
        get :edit, { id: post.id }
        expect(assigns(:post)).to eq Post.find(post.id)
      end
    end

    context "#update" do
      let(:new_post) { FactoryGirl.create(:post) }
      it "updates a post with valid params" do
        expect {
          put :update, id: new_post.id, post: { title: "new title" }
        }.to change { new_post.reload.title }.to("New Title")
        expect(response).to be_redirect
      end

      it "doesn't update a post when params are invalid" do
        put :update, id: new_post.id, post: { title: "" }
        expect(response).to be_success
      end
    end

    it "#destroy" do
      new_post = FactoryGirl.create(:post)
      expect {
        delete :destroy, id: new_post.id
      }.to change { Post.count }.by(-1)
    end
  end
end
