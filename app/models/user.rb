class User < ActiveRecord::Base
  include Omniauthable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable
  devise :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:github]

  rolify

  has_many :completions
  has_many :enrollments
  has_many :skills, through: :completions
  has_many :courses, through: :enrollments

  validates_presence_of :name
  validates_uniqueness_of :email

  scope :by_activity_date, -> { order("users.updated_at desc") }
  scope :with_completions, lambda {
    includes(:completions).where.not(completions: { id: nil })
  }

  def admin?
    has_role? :admin
  end

  def signed_in?
    true
  end

  def self.with_recent_activity
    with_completions.by_activity_date
  end
end
