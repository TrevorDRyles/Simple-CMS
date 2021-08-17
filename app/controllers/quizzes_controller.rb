class QuizzesController < ApplicationController
  
  layout 'admin'
  before_action :confirm_logged_in
  
  def index
    @quizzes = Quiz.all.sort {|a,b| a.score_percent <=> b.score_percent}.reverse
  end

  def show
    @quiz = Quiz.find(params[:id])
    @support_tickets = Quiz.support_tickets.map { |k,v| k }
    @experience = Quiz.experience.map { |k,v| k }
    @languages = Quiz.languages.map { |k,v| k }
    @css_response = Quiz.css_response.map { |k,v| k }
  end

  def new
    @quiz = Quiz.new
    @support_tickets = Quiz.support_tickets.map { |k,v| k }
    @experience = Quiz.experience.map { |k,v| k }
    @languages = Quiz.languages.map { |k,v| k }
    @css_response = Quiz.css_response.map { |k,v| k }
  end

  def create
    @quiz = Quiz.new(quiz_params)  
    if @quiz.save
      flash[:notice] = "Quiz created successfully"
      redirect_to quiz_path(@quiz)
    else
      render "new"
    end
  end

  def edit
    
    @quiz = Quiz.find(params[:id])
    @support_tickets = Quiz.support_tickets.map { |k,v| k }
    @experience = Quiz.experience.map { |k,v| k }
    @languages = Quiz.languages.map { |k,v| k }
    @css_response = Quiz.css_response.map { |k,v| k }
  end

  def delete
    @quiz = Quiz.find(params[:id])        
  end

  def update
    @quiz = Quiz.find(params[:id])
    if @quiz.update_attributes(quiz_params)
      flash[:notice] = "Quiz updated successfully"      
      redirect_to quiz_path(@quiz)
    else
      render "edit"
    end
  end

  def destroy
    @quiz = Quiz.find(params[:id])
    @quiz.destroy
    flash[:notice] = "Quiz '#{@quiz.id}' deleted successfully"    
    redirect_to quizzes_path
  end

  def new_modal
    respond_to do |format|
      format.html
      format.js
    end
  end

  private 

  def quiz_params
    params.require(:quiz).permit(:support_tickets, :name,:image,:experience, :css_response, languages: [])
  end
end
