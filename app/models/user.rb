class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :church_app, inverse_of: :user, autosave: true
  accepts_nested_attributes_for :church_app, allow_destroy: true

  has_one :picture, class_name: 'Picture', as: :imageable, dependent: :destroy

  require 'securerandom'
  before_create :set_auth_token

  def full_name
    self.first_name + " " + self.last_name
  end

  # after_create :send_admin_mail
  # def send_admin_mail
  #   AdminMailer.new_user_waiting_for_approval(self).deliver
  # end

  # def active_for_authentication? 
  #   super && approved? 
  # end 
  
  # def inactive_message 
  #   if !approved? 
  #     :not_approved 
  #   else 
  #     super # Use whatever other message 
  #   end 
  # end

  
  private
  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    SecureRandom.uuid.gsub(/\-/,'')
  end

end
