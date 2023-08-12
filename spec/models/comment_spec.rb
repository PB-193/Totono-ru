require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'commentモデル#how_long_agoメソッドのテスト' do
    it '1時間以内の場合、分単位で表示されること' do
      user = create(:user)
      content = create(:content)
      comment = create(:comment, user: user, content: content, created_at: Time.now - 30.minutes)
      result = comment.how_long_ago
      expect(result).to eq('30分前')
    end

    it '24時間以内の場合、時間単位で表示されること' do
      comment = create(:comment, created_at: Time.now - 6.hours)
      expect(comment.how_long_ago).to eq('6時間前')
    end

    it '30日以内の場合、日単位で表示されること' do
      comment = create(:comment, created_at: 2.days.ago)
      expect(comment.how_long_ago).to eq('2日前')
    end

    it '30日以上前の場合、作成日時がそのまま表示されること' do
      comment = create(:comment, created_at: 31.days.ago)
      expect(comment.how_long_ago.to_s(:db)).to eq(comment.created_at.to_s(:db))
    end

  end
end
