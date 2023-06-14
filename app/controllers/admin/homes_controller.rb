class Admin::HomesController < ApplicationController
  def top
    @content = Content.all
  end
end
