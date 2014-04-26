class Course < ActiveRecord::Base
  resourcify
  has_and_belongs_to_many :skills

  validates_presence_of :name, :handle
  validates_uniqueness_of :handle

  scope :published, -> { where(status: :published) }

  state_machine :status, initial: :created do
    event :approve do
      transition :created => :approved
    end

    event :publish do
      transition [:created, :approved] => :published
    end

    event :deprecate do
      transition :published => :deprecated
    end
  end

  def enroll!(user)
    user.add_role(:enrolled, self)
  end

  def users
    Course.with_role(:enrolled, self)
  end

end
