class Blog < ApplicationRecord
  belongs_to :author

  validates :title, :content, presence: true 
end
