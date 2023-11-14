class EnrollmentsController < ApplicationController
  def create
    enrollment_params = params.permit(:query_course_id, :query_student_id)
    @enrollment = Enrollment.new(enrollment_params)

    if @enrollment.save
      redirect_to("/students/#{enrollment_params[:query_student_id]}", notice: "Enrollment created successfully.")
    else
      redirect_to("/students/#{enrollment_params[:query_student_id]}", alert: "Enrollment failed to create successfully.")
    end
  end
end
