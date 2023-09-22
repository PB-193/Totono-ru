require 'rails_helper'

describe '[STEP3] ユーザログイン後のマイページのテスト' do
    
    let(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end
  
    describe 'マイページのテスト' do
        before do
          visit myshow_path
        end
    
        context '表示内容の確認' do
          it 'URLが正しい' do
            expect(current_path).to eq '/user/myshow'
          end
          it '自分のプロフィール画像が表示される' do
            expect(all('img').size)
          end
          it '自分のユーザ名が表示される' do
            expect(page).to have_content user.name
          end
          it '編集ボタンとパスワード変更/退会ボタンが表示される' do
            expect(page).to have_link('プロフィールの編集', href: edit_information_path)
            expect(page).to have_link('パスワードの変更/退会', href: edit_user_registration_path)
          end
        end
    
        describe '自分のユーザ情報編集画面のテスト' do
          before do
            visit  edit_information_path
          end
      
          context '表示の確認' do
            it 'URLが正しい' do
              expect(current_path).to eq '/user/information/edit'
            end
            it 'ユーザ名編集フォームに自分のユーザ名が表示される' do
              expect(page).to have_field 'user[name]', with: user.name
            end
            it 'メールアドレス編集フォームに自分のメールアドレスが表示される' do
              expect(page).to have_field 'user[email]', with: user.email
            end
            it 'ホームサウナ編集フォームに自分のホームサウナが表示される' do
              expect(page).to have_field 'user[spot]', with: user.spot
            end
            it '画像編集フォームが表示される' do
              expect(page).to have_field 'user[profile_image]'
            end
            it '編集保存ボタン,戻るボタン,アカウント停止ボタンが表示される' do
              expect(page).to have_link("マイページに戻る", href: myshow_path)
              expect(page).to have_link("アカウントを停止する", href: finalcheck_path)
              expect(page).to have_button '編集内容を保存する'
            end
          end
      
          context '更新成功のテスト' do
            before do
              @user_old_name = user.name
              @user_old_email = user.email
              @uset_old_spot = uset.spot
              fill_in 'user[name]', with: Faker::Lorem.characters(number: 9)
              fill_in 'user[email]', with: Faker::Internet.email
              fill_in 'user[spot]', with: Faker::Lorem.characters(number: 20)
              click_button '編集内容を保存する'
            end
      
            it 'ユーザ名が正しく更新される' do
              expect(user.reload.name).not_to eq @user_old_name
            end
            it 'メールアドレスが正しく更新される' do
              expect(user.reload.email).not_to eq @user_old_email
            end
            it 'ホームサウナが正しく更新される' do
              expect(user.reload.spot).not_to eq @user_old_spot
            end
            it 'リダイレクト先が、マイページ画面になっている' do
              expect(current_path).to eq '/user/myshow'
            end
          end
          
        end
     end
  
end