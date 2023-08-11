class User::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def find
    @tags = Tag.all
  end

  def index
    @tag = Tag.find_by(id: params[:tag_id])
    @start_date = Date.parse(params[:start_date]) if params[:start_date].present?
    @end_date = Date.parse(params[:end_date]) if params[:end_date].present?
    @search_field = params[:search_field]

    query = Content.all

    # 検索フィールドに基づいてクエリを絞り込む
    if @search_field == 'visit_day'
      query = query.where(visit_day: @start_date..@end_date) if @start_date.present? && @end_date.present?
    elsif @search_field == 'created_at'
      query = query.where(created_at: @start_date.beginning_of_day..@end_date.end_of_day) if @start_date.present? && @end_date.present?
    end

    # タグが指定されている場合はタグで絞り込み
    if @tag.present?
      query = query.joins(:tags).where(tags: { id: @tag.id })
    end
    
    # タグが選択していないとき、または開始日と終了日を選択しないときにエラーメッセージを表示する処理
    if @tag.present? || (@start_date.present? && @end_date.present?)
      @contents = query.order(created_at: :asc).page(params[:page])
      render "user/searches/index"
    else
      flash[:alert] = "日付けの「開始日」と「終了日」を指定してください。"
      redirect_back fallback_location: root_path
    end
    
  end
end

