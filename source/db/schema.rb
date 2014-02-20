
ActiveRecord::Schema.define(:version => 20130423183943) do

  create_table "posts", :force => true do |t|
    t.string   "slug"
    t.string   "title"
    t.text     "content"
    t.boolean  "is_published", :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

end
