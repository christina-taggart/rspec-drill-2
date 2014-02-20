require 'spec_helper'

feature 'User browsing the website' do
  context "on homepage" do
    let(:title) {"hello"}
    let(:content) {"roy"}
    let!(:post) { Post.create title: title, content: content }
    it "sees a list of recent posts titles" do
      visit root_path
      expect(page).to have_content(post.title)
    end

    it "can click on titles of recent posts and should be on the post show page" do
      visit root_path
      click_link('Hello')
      expect(current_path).to eq post_path id: post.id
    end
  end

  context "post show page" do
    let(:title) {"roy's"}
    let(:content) {"middle name"}
    let!(:post) { Post.create title: title, content: content }
    it "sees title and body of the post" do
      visit post_path id: post.id
      expect(page).to have_content post.title
      expect(page).to have_content post.content
    end
  end
end
