class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  def tag_list
    tags.join(", ")
  end

  def tag_list=(tags_strings)
    t = tags_strings.split(",").collect{|s| s.strip.downcase}.uniq
    real_tags = t.collect{|s| Tag.find_or_create_by(name: s)}
    self.tags = real_tags
  end
end
