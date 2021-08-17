class PagesController < ApplicationController
  
  layout 'admin'
  before_action :confirm_logged_in  
  before_action :find_subjects, :only => [:new, :update, :edit, :create, :new_modal]
  before_action :set_page_count, :only => [:new, :create, :edit, :update, :new_modal]

  def index
    @pages = Page.sorted
  end

  def show
    @page = Page.find(params[:id])
    @subject = @page.subject
    @owner = params[:owner]
  end

  def new
    @page = Page.new(:subject_id => params[:subject_id])
    @subject = Subject.find(params[:subject_id]) rescue nil
  end

  def create
    @page = Page.new(page_params)
    if(@page.save)
      flash[:notice] = "Page '#{@page.name}' created"
      redirect_to subject_path(@page.subject)
    else
      render "new"
    end
  end

  def edit
    @page = Page.find(params[:id])
    @page_count = Page.count
    @subject = @page.subject
    @owner = params[:owner]
  end

  def update
    @page = Page.find(params[:id])
    if(@page.update_attributes(page_params))
      flash[:notice] = "Page '#{@page.name}' updated"
      redirect_to page_path(@page, :owner => params[:owner])
    else
      puts @page.errors.full_messages
      @page_count = Page.count
      render "edit"
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Page '#{@page.name}' destroyed"
    redirect_to subject_path(@page.subject_id)
  end

  def new_modal
    @subject = Subject.find(params[:owner_id])
    @page = Page.new(:subject_id => @subject.id)
    # respond_to do |format|
    #   format.html
    #   format.js
    # end
    @hide_logout = true
    render 'new_modal'
  end

  private 

    def find_subjects
      @subjects = Subject.sorted
    end

    def set_page_count
      @page_count = Page.count
      if params[:action] == 'new' || params[:action] == 'create'
        @page_count += 1
      end
    end
  
    def page_params
      params.require(:page).permit(:item_attribute, :image, :name, :description, :subject_id, :pic_url, :permalink, :position, :visible)
    end
end
