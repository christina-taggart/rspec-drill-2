require 'spec_helper'

describe Admin::PostsController do
  describe "admin panel" do
    it "#index" do
      get :index
      response.status.should eq 200
    end

    it "#new" do
      get :new
      expect(response.status).to eq(200)
    end

    context "#create" do
      it "creates a post with valid params" do
        expect {
          Post.create(title: "A day at the beach", content: "I went to the beach the other day.")
        }.to change(Post, :count).by(1)
      end
      it "doesn't create a post when params are invalid" do
        expect {
          Post.create(content: "I went to the beach the other day.")
        }.not_to change(Post, :count)
      end
    end

    context "#update" do
      let(:post) { Post.create(title: "This is a title", content: "This is some content.")}
      it "updates a post with valid params" do
        expect {
          post.update_attributes(title: "This is an awesome title")
        }.to change{post.title}
      end
      it "doesn't update a post when params are invalid" do
        pending
        expect {
          post.update_attributes(title: nil)
        }.not_to change{post.title}
      end
    end

    let(:post) { Post.create(title: "Blob", content: "Blob") }
    it "#destroy" do
      expect {
        delete :destroy, id: post.id
      }.to change(Post, :count)
    end
  end
end
