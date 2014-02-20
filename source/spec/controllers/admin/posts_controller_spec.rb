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
        expect{post :create, post: {title: 'another title', content: "ashadsjlfdsfjiojfq dsafojgo"}}.to change{Post.count}.by(1)
      end
      it "doesn't create a post when params are invalid" do
        post :create, post: {title: 'another title'}
        expect(response).to render_template :new
      end
    end

    context "#edit" do
      let(:post){Post.create title: 'new title', content: "dfddfdfd"}
      it "updates a post with valid params" do
        expect {
          put :update, id: post.id, post: {title: "another title"}
          }.to change { post.reload.title }.to("Another Title")
        expect(response).to be_redirect
      end
      it "doesn't update a post when params are invalid" do
        expect {
          put :update, id: post.id, post: {title: ""}
          }.to_not change { post.reload.title }
        expect(response).to render_template :edit
      end
    end
    context "#destroy" do
      let!(:post){Post.create title: 'new title', content: "dfddfdfd"}
      it "#destroy" do
        expect { delete :destroy, id: post.id }.to change { Post.count }.by(-1)
      end
    end
  end
end
