class DemoController < ApplicationController
	
	layout false 
  before_action :confirm_logged_in
  def index
    
  end

  def hello
  	@id = params['id']
  	@page = params[:page]
  end

  def other_hello
  end


end
