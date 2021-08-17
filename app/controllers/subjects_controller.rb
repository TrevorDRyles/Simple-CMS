class SubjectsController < ApplicationController
  
  layout 'admin'
  
  before_action :confirm_logged_in
  before_action :set_subject_count, :only => [:new, :create, :edit, :update]

  def new_modal
    @subject = Subject.new
    # respond_to do |format|
    #   format.html
    #   format.js
    # end
    @hide_logout = true
    render "new_modal"
  end

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
    @pages = @subject.pages
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      flash[:notice] = "Subject created successfully"
      redirect_to subjects_path
    else
      render "new"
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def delete
    @subject = Subject.find(params[:id])        
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    flash[:notice] = "Subject '#{@subject.subject}' deleted successfully"    
    redirect_to subjects_path
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update_attributes(subject_params)
      flash[:notice] = "Subject updated successfully"      
      redirect_to subject_path(@subject)
    else
      render "edit"
    end
  end


  private 

  def set_subject_count
    @subject_count = Subject.count
    if params[:action] == 'new' || params[:action] == 'create'
      @subject_count += 1
    end
  end

  def subject_params
    params.require(:subject).permit(:subject, :position, :visible, :crated_at, :category, :description, :attribute_text)
  end
end
