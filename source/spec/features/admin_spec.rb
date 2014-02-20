require 'spec_helper'

feature 'Admin panel', js: true do
  context "on admin homepage" do
    let!(:post1) { FactoryGirl.create(:post) }
    let!(:post2) { FactoryGirl.create(:post) }

    it "can see a list of recent posts" do
      visit admin_posts_path
      expect(page).to have_content post1.title
      expect(page).to have_content post2.title
    end

    it "can edit a post by clicking the edit link next to a post" do
      visit admin_posts_path
      first(:link, 'Edit').click
      expect(page).to have_content post1.title
    end

    it "can delete a post by clicking the delete link next to a post" do
      visit admin_posts_path
      expect {
        first(:link, 'Delete').click
      }.to change { Post.count }.by(0)
    end

    it "can create a new post and view it" do
       visit new_admin_post_path
       expect {
         fill_in 'post_title',   with: "Hello world!"
         fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
         page.check('post_is_published')
         click_button "Save"
       }.to change(Post, :count).by(1)

       page.should have_content "Published: true"
       page.should have_content "Post was successfully saved."
     end
  end

  context "editing post" do
    let!(:post1) { FactoryGirl.create(:post) }
    before(:each) do
      visit edit_admin_post_path(post1)
      check 'post_is_published'
      click_button "Save"
    end
    it "can mark an existing post as published" do
      page.should have_content "Published: true"
    end

    it "can mark an existing post as unpublished" do
      visit edit_admin_post_path(post1)
      uncheck 'post_is_published'
      click_button "Save"
      page.should have_content "Published: false"
    end
  end

  context "on post show page" do
    let!(:post1) { FactoryGirl.create(:post) }
    before(:each) do
      visit admin_posts_path
      click_link post1.title
    end

    it "can visit a post show page by clicking the title" do
      expect(page).to have_content(post1.title)
    end

    it "can see an edit link that takes you to the edit post path" do
      click_link "Edit post"
      expect(page).to have_content "Edit #{post1.title}"
    end

    it "can go to the admin homepage by clicking the Admin welcome page link" do
      click_link "Admin welcome page"
      expect(page).to have_content "Welcome to the admin panel!"
    end
  end
end
