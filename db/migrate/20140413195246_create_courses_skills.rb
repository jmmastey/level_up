class CreateCoursesSkills < ActiveRecord::Migration
  def change
    create_table :courses_skills do |t|
      t.belongs_to :course, index: true, null: false, index: true
      t.belongs_to :skill, index: true, null: false
    end
  end
end
