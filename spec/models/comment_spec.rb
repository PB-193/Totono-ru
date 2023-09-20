require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'commentモデル#how_long_agoメソッドのテスト' do
    let!(:user) { create(:user) }
    let!(:content) { create(:content) }

    it '1時間以内の場合、分単位で表示されること' do
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
    
    it '12ヶ月以内の場合、月単位で表示されること' do
      comment = create(:comment, created_at: 10.months.ago)
      expect(comment.how_long_ago).to eq('10ヶ月前')
    end

    it '12ヶ月以上前の場合、作成日時がそのまま表示されること' do
      comment = create(:comment, created_at: 13.months.ago)
      expect(comment.how_long_ago.to_s(:db)).to eq(comment.created_at.to_s(:db))
    end
    
  end
end