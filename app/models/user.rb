class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum role: [:admin, :member]
  before_create :set_default_role
  validates :name, presence: true

  private

  def set_default_role
    self.role = self.role || "member"
  end
end
