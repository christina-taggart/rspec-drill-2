require 'spec_helper'

feature 'User browsing the website', js: true do
  context "on homepage" do
    let!(:post){ Post.create title: 'new title', content: 'tapirs' }
    it "sees a list of recent posts titles" do
      visit posts_path
      expect(page).to have_content post.title
    end

    it "can click on titles of recent posts and should be on the post show page" do
      visit posts_path
      click_link(post.title)
      expect(current_path).to eq post_path id: post.id
    end
  end

  context "post show page" do
    let!(:post){ Post.create title: 'new title', content: 'tapirs' }
    it "sees title and body of the post" do
      visit post_path id: post.id
      expect(page).to have_content post.title
      expect(page).to have_content post.content

    end
  end
end
