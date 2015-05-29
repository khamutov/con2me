class Offer < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :category

  self.per_page = 5

  def self.desc_contains(search)
    if search.blank?
      all # scoped
    else
      wildcard_search = "%#{search}%"
      where("offers.desc like ?", wildcard_search)
    end
  end

  def self.category_contains(categories)
    if categories.nil?
      all
    else
      cat_ids = categories.map(&:to_i)
      where(:category_id => cat_ids)
    end
  end
end
