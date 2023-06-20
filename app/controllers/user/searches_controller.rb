class User::SearchesController < ApplicationController
  
  def find
    @tags = Tag.all
  end

  def index
    @tag = Tag.find(params[:tag_id])
    @contents = @tag.contents
  end

end
