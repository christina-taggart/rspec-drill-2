class Post < ActiveRecord::Base
  attr_accessible :title, :content, :is_published

  scope :recent, order: "created_at DESC", limit: 5

  before_save :titleize_title
  before_create :create_slug
  validates_presence_of :title, :content

  def create_slug
    self.slug = self.title.downcase.gsub(/[^a-z0-9\s]/,'').gsub(/\s/, '-')
  end

  private

  def titleize_title
    self.title = title.titleize
  end
end

