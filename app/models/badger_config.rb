require 'digest'

# == Schema Information
# Schema version: 20101231013352
#
# Table name: badger_configs
#
#  id                    :integer         not null, primary key
#  login                 :string(255)
#  hashed_password       :string(255)
#  admin_login           :string(255)
#  hashed_admin_password :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#

class BadgerConfig < ActiveRecord::Base
  attr_accessor :password, :admin_password
  attr_accessible :login, :password, :password_confirmation,
    :admin_login, :admin_password, :admin_password_confirmation
  validates :password, :confirmation => true
  validates :admin_password, :confirmation => true
  before_update :hash_passwords

  def viewer?(login, password)
    login == self.login && hash_password(password) == hashed_password
  end

  def admin?(login, password)
    login == self.admin_login && hash_password(password) == hashed_admin_password
  end

  private

  def hash_passwords
    self.hashed_password = hash_password(password, hashed_password)
    self.hashed_admin_password = hash_password(admin_password, hashed_admin_password)
  end

  def hash_password(password, default_password = "")
    password.blank? ? default_password : Digest::SHA2.hexdigest(password)
  end
end

