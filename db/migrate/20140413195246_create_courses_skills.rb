class CreateCoursesSkills < ActiveRecord::Migration
  def change
    create_table :courses_skills do |t|
      t.belongs_to :course, index: true
      t.belongs_to :skill, index: true
    end
  end
end
