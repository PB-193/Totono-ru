class User::SearchesController < ApplicationController
  
  def find
    # 検索フォームを表示するアクション
  end

  def index
    start_year = params[:start_year]
    end_year = params[:end_year]
  
    # start_year から end_year の範囲でコンテンツを絞り込む
    @contents = Content.where(visit_day: start_year..end_year)
  
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @contents = @contents.joins(:tags).where(tags: { id: @tag.id })
    end
  end

  # 検索結果を表示するアクション
end
