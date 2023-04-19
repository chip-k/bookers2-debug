class Group < ApplicationRecord
  
  has_many :group_users
  has_many :users, through: :group_users
  
  validates :name, presence: true
  
  has_one_attached :group_image
  
  
  def get_group_image
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      group_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    group_image
  end
  
end
