class StudentsController < ApplicationController
  def index
    @students = Student.all.order(created_at: :desc)
    render(template: "students/index")
  end

  def show
    the_id = params.fetch("path_id")
    @match = Student.where({:id => the_id })
    @student= @match.at(0)

    render(template: "students/show")
  rescue ActiveRecord::RecordNotFound
    redirect_to("/students", alert: "Student not found.")
  end

  def create
    @student = Student.new
    @student.email = params.fetch("query_email")
    @student.first_name = params.fetch("query_name")
    @student.last_name = params.fetch("query_last_name")

    if @student.save
      redirect_to("/students", notice: "Student created successfully.")
    else
      redirect_to("/students", alert: "Student failed to create successfully.")
    end
  end

  def update
    the_id = params.fetch("path_id")
    @student = Student.find(the_id)

    if @student.update(student_params)
      redirect_to("/students/#{the_id}", notice: "Student updated successfully.")
    else
      redirect_to("/students/#{the_id}", alert: "Student failed to update successfully.")
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to("/students", alert: "Student not found.")
  end

  def destroy
    the_id = params.fetch("path_id")
    @student = Student.find(the_id)
    @student.destroy
    redirect_to("/students", notice: "Student deleted successfully.")
  rescue ActiveRecord::RecordNotFound
    redirect_to("/students", alert: "Student not found.")
  end

  private

 
end
