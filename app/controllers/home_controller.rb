class HomeController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: {} }
    end
  end
end
