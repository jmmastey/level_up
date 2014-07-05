require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :name => "Example User",
      :email => "user@example.com",
      :password => "changeme",
      :password_confirmation => "changeme"
    }
  end

  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end

  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do

    before(:each) do
      @user = User.new(@attr)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end

  end

  describe "courses" do
    let(:user) { create(:user) }
    let!(:course) { create(:course) }
    let!(:published_course) { create(:course, :published) }
    let!(:hidden_course) { create(:course, :created) }


    it "should retrieve enrolled courses" do
      user.courses.to_a.should include(published_course)

      course.enroll!(user)
      user.courses.should include(course)
    end

    it "should show all courses to admins, but not to other users" do
      user.courses.should eq([published_course])

      user.add_role(:admin)
      user.courses.should eq([course, published_course, hidden_course])
    end

  end

  describe "skills" do
    let(:user)      { create(:user) }
    let(:skill)     { create(:skill, category: category) }
    let(:category)  { create(:category) }

    it "should find skills that have been completed" do
      user.skills.should be_empty

      create(:completion, user: user, skill: skill)
      user.skills.length.should == 1
      user.skills.should include(skill)

      other_completion = create(:completion, user: user)
      user.reload.skills.length.should == 2
      user.skills.should include(skill)
    end

    it "should find skills by category" do
      create(:completion, user: user, skill: skill)
      other_completion = create(:completion, user: user)

      # scope down on category
      user.skills.for_category(category).length.should == 1
      user.skills.for_category(category).should_not include(other_completion.skill)
    end

    it "should check completion of a skill" do
      user.should_not have_completed(skill)
      create(:completion, user: user, skill: skill)
      user.should have_completed(skill)
    end
  end


  describe "categories" do
    let(:user)    { create(:user) }
    let(:course)  { create(:course) }
    let!(:skill)  { create(:skill, courses: [course]) }

    it "should retrieve categories for enrolled courses" do
      course.enroll!(user)
      user.categories.should eq([skill.category])
    end

    it "should only retrieve unique categories" do
      create(:skill, category: skill.category, courses: [course]) # do it again!

      course.enroll!(user)
      user.categories.should eq([skill.category])
    end
  end

end
