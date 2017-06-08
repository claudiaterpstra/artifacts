class PagesController < ApplicationController

  before_action :set_current_user, only: [:dashboard, :account, :manage_courses, :studio, :give_feedback]

  skip_before_action :authenticate_user!, only: [ :home ]
  skip_after_action :verify_authorized, only: [ :home, :studentdashboard, :dashboard ]

  def home
  end

  def dashboard
    @courses = current_user.courses_participated
    @artworks = Artwork.all.where(user: @user)
  end

  def account
  end

  def studio
    @feedback = Feedback.new
    @courses = @user.courses_participated
    @lectures = @user.courses_participated.collect(&:lectures).flatten
    @artworks_count = current_user.artworks.count

    if params[:lecture]
      @artworks = current_user.artworks.where(lecture: Lecture.find(params[:lecture]))
    elsif params[:course]
      @artworks = Course.find(params[:course]).artworks.where(user: current_user)
    else
      @artworks = current_user.artworks
    end
  end

  def manage_courses
    @courses = current_user.courses
    @artworks = []
    @courses.each do |course|
      course.lectures.each do |lecture|
        lecture.artworks.each do |artwork|
          @artworks << artwork
        end
      end
    end
  end

  def studentdashboard
    @courses = current_user.courses_participated
  end

  def artistdashboard
    authorize current_user
  end

  def give_feedback
    @feedback = Feedback.new

    @courses = @user.courses
    @lectures = @user.lectures
    @artworks = @user.student_artworks

    @students = @user.students

    if params[:course]
      @artworks = @user.student_artworks.where(lectures: { course_id: params[:course] } )
    elsif params[:lecture]
      @artworks = @user.student_artworks.where(lecture_id: params[:lecture] )
    elsif params[:student]
      @artworks = @user.student_artworks.where(user_id: params[:student])
    end

  end

  private

  def set_current_user
    @user = current_user
  end

end
