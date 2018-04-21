class AddCourseToCategory < ActiveRecord::Migration[4.2]
  def up
    add_column :categories, :course_id, :integer
    Category.connection.execute "update categories c set course_id =
      (select max(course_id) from courses_skills cs, skills s
              where s.category_id = c.id and cs.skill_id = s.id)
      where course_id is null"
  end

  def down
    remove_column :categories, :course_id
  end
end
