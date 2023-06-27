class User::SearchesController < ApplicationController
  def find
    @tags = Tag.all
  end

  def index
    @tag = Tag.find_by(id: params[:tag_id])
    @start_date = params[:start_date]
    @end_date = params[:end_date]

    # 絞り込み条件に基づいてデータを取得するクエリを作成
    query = Content.all

    if @start_date.present? && @end_date.present?
      query = query.where("created_at >= ? AND created_at <= ?", @start_date, @end_date)
                .or(query.where("visit_day >= ? AND visit_day <= ?", @start_date, @end_date))
    end

    # タグが指定されている場合はタグに基づいて絞り込み
    if @tag.present?
      query = query.joins(:tags).where(tags: { id: @tag.id })
    end

    # クエリを実行して結果を取得
    @contents = query.order(created_at: :asc).page(params[:page])

    render "user/searches/index"
  end
end
