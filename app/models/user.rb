class User < ActiveRecord::Base
  include Omniauthable
  include TokenAuthable

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

  scope :older, -> { where("users.created_at < ?", 5.days.ago) }
  scope :by_activity_date, -> { order("users.updated_at desc") }
  scope :by_org, ->(org) { where(organization: org) }
  scope :emailable, -> { where(email_opt_out: nil) }
  scope :with_completions, lambda {
    includes(:completions).where.not(completions: { id: nil })
  }
  scope :without_enrollments, lambda {
    includes(:enrollments).where(enrollments: { id: nil })
  }


  def summary
    @summary ||= UserSummary.new(self)
  end

  def admin?
    has_role? :admin
  rescue
    false
  end

  def signed_in?
    true
  end

  def self.with_recent_activity
    with_completions.by_activity_date
  end
end
