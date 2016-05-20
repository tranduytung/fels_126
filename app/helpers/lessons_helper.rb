module LessonsHelper
  def find_lesson lesson_id
    Lesson.find_by id: lesson_id
  end
end
