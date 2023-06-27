class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @contents = Content.page(params[:page]).order(created_at: :asc)
  end
  
end
