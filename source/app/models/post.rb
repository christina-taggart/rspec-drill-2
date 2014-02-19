class Post < ActiveRecord::Base
  attr_accessible :title, :content, :is_published

  scope :recent, order: "created_at DESC", limit: 5

  before_save :assign_slug

  validates_presence_of :title, :content

  private

  def assign_slug
    self.slug = slugify(self.title)
  end

  def slugify(title)
    title.downcase!
    title.gsub!(/\s/, "-")
    title.gsub!(/[!@#^&*]/, "")
  end
end