require 'spec_helper'

feature 'User browsing the website', js: true do
  let!(:post1) { FactoryGirl.create(:post) }
  let!(:post2) { FactoryGirl.create(:post) }

  context "on homepage" do
    it "sees a list of recent posts titles" do
      visit root_path
      expect(page).to have_content post1.title
      expect(page).to have_content post2.title
    end

    it "can click on titles of recent posts and should be on the post show page" do
      visit root_path
      click_link post1.title
      expect(page).to have_content post1.title
    end
  end

  context "post show page" do
    it "sees title and body of the post" do
      visit post_path(post1)
      expect(page).to have_content post1.title
      expect(page).to have_content post1.content
    end
  end
end
