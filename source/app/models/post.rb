class Post < ActiveRecord::Base
  attr_accessible :title, :content, :is_published

  validates_presence_of :is_published, default: false

  scope :recent, order: "created_at DESC", limit: 5

  after_initialize :titleize_title

  validates_presence_of :title, :content
  after_save :slug

  private

  def set_default_slug
    self.slug ||= 'new-post'
  end

  def titleize_title
    return if self.title.nil?
    self.title = self.title.titleize
  end
end