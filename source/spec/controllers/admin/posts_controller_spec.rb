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

    context "#edit" do
      it "updates a post with valid params" do
        pending
      end
      it "doesn't update a post when params are invalid" do
        pending
      end
    end

    it "#destroy" do
      pending
    end
  end
end
