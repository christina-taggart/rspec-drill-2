require 'spec_helper'

feature 'Admin panel' do
  context "on admin homepage" do
    let!(:post) { FactoryGirl.create :post }
    it "can see a list of recent posts" do
      visit admin_posts_path
      expect(page).to have_content(post.title)
    end

    it "can edit a post by clicking the edit link next to a post" do
      visit admin_posts_path
      expect{
        click_link "Edit"
        fill_in 'post_title', with: "terminator"
        page.check('post_is_published')
        click_button "Save"
      }.to change { post.reload.title }.to("terminator")
    end

    it "can delete a post by clicking the delete link next to a post" do
      visit admin_posts_path
      expect{
        click_link "Delete"
      }.to change{ Post.count}.by(-1)
    end

    it "can create a new post and view it" do
       visit new_admin_post_url

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
    let!(:post) { FactoryGirl.create :post }
    it "can mark an existing post as unpublished" do
      visit admin_posts_path
      click_link "Edit"
      fill_in 'post_title', with: "terminator"
      click_button "Save"
      page.should have_content "Published: false"
    end
  end

  context "on post show page" do
    let!(:post) { FactoryGirl.create :post }
    it "can visit a post show page by clicking the title" do
      visit admin_posts_path
      click_link post.title
      expect(page).to have_content(post.content)
    end

    it "can see an edit link that takes you to the edit post path"

    it "can go to the admin homepage by clicking the Admin welcome page link"
  end
end
