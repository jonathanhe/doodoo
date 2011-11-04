class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email

  validates :first_name, :presence => true
  validates :last_name,  :presence => true
  validates :email,      :presence => true
end

# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

