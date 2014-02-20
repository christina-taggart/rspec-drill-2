require 'spec_helper'

describe Admin::PostsController do
  describe "admin panel" do
    it "#index" do
      get :index
      response.status.should eq 200
    end

    it "#new" do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end

    context "#create" do
      it "creates a post with valid params" do
        expect {
          post :create, post: FactoryGirl.attributes_for(:post)
        }.to change { Post.count }.by(1)
      end
      it "doesn't create a post when params are invalid" do
        expect {
          post :create
        }.not_to change { Post.count }
      end
    end

    context "#updates" do
      let!(:post) { FactoryGirl.create :post}
      it "updates a post with valid params" do
        expect {
          put :update, id: post.id, post: { title: "terminator" }
        }.to change { post.reload.title }.to("terminator")
      end
      it "doesn't update a post when params are invalid" do
        expect {
          put :update, id: post.id
        }.not_to change { post.reload.title }
      end
    end

    context "#destroy" do
      let!(:post) { FactoryGirl.create :post}
      it "destroys the post" do
        expect {
          puts "*" * 50
          p post
          delete :destroy, id: post.id
          }.to change { Post.count }.by(-1)
      end
    end
  end
end
