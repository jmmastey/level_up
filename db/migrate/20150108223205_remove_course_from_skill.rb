class RemoveCourseFromSkill < ActiveRecord::Migration[4.2]
  def change
    drop_table :courses_skills
  end
end
