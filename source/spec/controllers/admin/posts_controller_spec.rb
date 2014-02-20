require 'spec_helper'

describe Admin::PostsController do
  describe "admin panel" do
    it "#index" do
      get :index
      response.status.should eq 200
    end

    it "#new" do
      get :new
      response.status.should eq 200
    end

    context "#create" do
      it "creates a post with valid params" do
        expect {
          post :create, :post => {:title => "title", :content => "content"}
        }.to change { Post.count }.by(1)
      end
      it "doesn't create a post when params are invalid" do
        expect {
          post :create, :post => {:title => "title" }
        }.to change { Post.count }.by(0)
      end
    end

    context "#edit" do
      let!(:post) { Post.create :title => "title", :content => "content" }
      it "updates a post with valid params" do
        post.update_attributes(title: "new title", content: "new content")
        expect(post.title).to eq "New Title"
      end
      it "doesn't update a post when params are invalid" do
        post.update_attributes(title: "")
        expect(post.valid?).to eq false
      end
    end

    it "#destroy" do
      post = Post.create :title => "title", :content => "content"
      expect {
        delete :destroy, :id => post.id
      }.to change{ Post.count }.by(-1)
    end
  end
end
