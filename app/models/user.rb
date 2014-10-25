class User < ActiveRecord::Base
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
  scope :by_auth, ->(auth) { where(provider: auth.provider, uid: auth.uid) }
  scope :with_completions, lambda {
    includes(:completions).where.not(completions: { id: nil })
  }

  def has_completed?(skill)
    skills.include? skill
  end

  def admin?
    has_role?(:admin)
  end

  def signed_in?
    true
  end

  def self.from_omniauth(auth)
    by_auth(auth).first ||
      existing_user_from_omniauth(auth) ||
      new_user_from_omniauth(auth)
  end

  def self.existing_user_from_omniauth(auth)
    user = find_by(email: auth.info.email)
    return unless user

    user.tap do |new_user|
      new_user.provider = auth.provider
      new_user.uid = auth.uid
      new_user.save!
    end
  end
  private_class_method :existing_user_from_omniauth

  def self.new_user_from_omniauth(auth)
    create(email: auth.info.email,
           password: Devise.friendly_token[0, 20],
           name: auth.info.name,
           provider: auth.provider,
           uid: auth.uid,
          )
  end
  private_class_method :new_user_from_omniauth
end
