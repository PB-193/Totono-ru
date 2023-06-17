class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @contents = Content.all
  end
  
end
