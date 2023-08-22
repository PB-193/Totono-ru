# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Content, type: :model do
  describe '#send_message_to_favorited_users のテスト' do
    let(:user) { create(:user) }
    let(:content) { create(:content, user: user) }
    let(:send_message_service) { SendMessageService.new(content) }
    
    it 'いいねされたユーザにメールを送信すること' do
      # テスト用のいいねしたユーザと投稿を作成
      favorited_user = create(:user)
      create(:favorite, user: favorited_user, content: content)
      
      # FavoritedUserMailer が適切に呼び出されることをモックする
      # テストの中で実際にはメールを送信せずに、そのメール送信処理が正しく呼び出されたことを確認するための手法
      mailer_instance = double('FavoritedUserMailer')
      expect(FavoritedUserMailer).to receive(:new_content_message_email).with(favorited_user, content).and_return(mailer_instance)
      expect(mailer_instance).to receive(:deliver_now)
      # テスト内で実際にメールを送信する代わりに、モックオブジェクトを使用して制御している
      
      # テスト対象のメソッドを呼び出す
      send_message_service.send_message_to_favorited_users
    end
    
    it '投稿者にはメールを送信しないこと' do
      # 投稿者にいいねがある状態を作成
      create(:favorite, user: user, content: content)
      
      # FavoritedUserMailer が呼び出されないことを確認する
      expect(FavoritedUserMailer).not_to receive(:new_content_message_email)
      
      # テスト対象のメソッドを呼び出す
      send_message_service.send_message_to_favorited_users
    end
  end
end
