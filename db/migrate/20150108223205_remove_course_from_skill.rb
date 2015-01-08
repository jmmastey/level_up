class RemoveCourseFromSkill < ActiveRecord::Migration
  def change
    drop_table :courses_skills
  end
end
