# require 'rails_helper'

# describe '[STEP1] ユーザログイン前のテスト' do
#   describe 'トップ画面のテスト' do
#     before do
#       visit root_path
#     end

#     context '表示内容の確認' do
#       it 'URLが正しい' do
#         expect(current_path).to eq '/'
#       end
#       it 'ゲストログイン,新規登録,ログインする のリンクの内容が正しい' do
#         expect(page).to have_link("ゲストでログインする", href: homes_guest_sign_in_path)
#         expect(page).to have_link("新規登録してはじめる", href: new_user_registration_path)
#         expect(page).to have_link("ログインしてはじめる", href: new_user_session_path)
#       end
#       it 'お問い合わせフォーム,利用規約,プライバシーポリシーのリンクの内容が正しい' do
#         expect(page).to have_link("お問い合わせフォーム", href: "https://forms.gle/odVjkTS2C3XXzyA79")
#         expect(page).to have_link("利用規約", href: terms_of_use_path)
#         expect(page).to have_link("プライバシーポリシー", href: privacy_policy_path)
#       end
#     end
#   end

#   describe 'ユーザ新規登録のテスト' do
#     before do
#       visit new_user_registration_path
#     end

#     context '表示内容の確認' do
#       it 'URLが正しい' do
#         expect(current_path).to eq '/users/sign_up'
#       end
#       it 'nameフォームが表示される' do
#         expect(page).to have_field 'user[name]'
#       end
#       it 'emailフォームが表示される' do
#         expect(page).to have_field 'user[email]'
#       end
#       it 'passwordフォームが表示される' do
#         expect(page).to have_field 'user[password]'
#       end
#       it 'password_confirmationフォームが表示される' do
#         expect(page).to have_field 'user[password_confirmation]'
#       end
#       it '新規登録ボタンが表示される' do
#         expect(page).to have_button '新規登録'
#       end
#     end

#     context '新規登録成功のテスト' do
#       before do
#         fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
#         fill_in 'user[email]', with: Faker::Internet.email
#         fill_in 'user[password]', with: 'password'
#         fill_in 'user[password_confirmation]', with: 'password'
#       end

#       it '正しく新規登録される' do
#         expect { click_button '新規登録' }.to change(User.all, :count).by(1)
#       end
#       it '新規登録後のリダイレクト先が、投稿一覧になっている' do
#         click_button '新規登録'
#         expect(current_path).to eq '/contents'
#       end
#     end
#   end

#   describe 'ユーザログイン' do
#     let(:user) { create(:user) }

#     before do
#       visit new_user_session_path
#     end

#     context '表示内容の確認' do
#       it 'URLが正しい' do
#         expect(current_path).to eq '/users/sign_in'
#       end
#       it 'emailフォームが表示される' do
#         expect(page).to have_field 'user[email]'
#       end
#       it 'passwordフォームが表示される' do
#         expect(page).to have_field 'user[password]'
#       end
#       it 'ログインボタンが表示される' do
#         expect(page).to have_button 'ログイン'
#       end
#     end

#     context 'ログイン成功のテスト' do
#       before do
#         fill_in 'user[email]', with: user.email
#         fill_in 'user[password]', with: user.password
#         click_button 'ログイン'
#       end

#       it 'ログイン後のリダイレクト先が、投稿一覧になっている' do
#         expect(current_path).to eq '/contents'
#       end
#     end

#     context 'ログイン失敗のテスト' do
#       before do
#         fill_in 'user[email]', with: ''
#         fill_in 'user[password]', with: ''
#         click_button 'ログイン'
#       end

#       it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
#         expect(current_path).to eq '/users/sign_in'
#       end
#     end
#   end
  
#   describe 'ユーザログアウトのテスト' do
#     context 'ログアウト機能のテスト' do
#       let(:user) { create(:user) }
  
#       before do
#         visit new_user_session_path
#         fill_in 'user[email]', with: user.email
#         fill_in 'user[password]', with: user.password
#         click_button 'ログイン'
#       end
  
#       it 'ログアウトが正しく行われることのテスト' do
#         # ログアウトボタンをhref 属性が以下のpathに等しい a 要素を指定してクリック処理
#         find("a[href='#{destroy_user_session_path}']").click
#         # ログアウト後にトップページにリダイレクトされていることを確認
#         expect(current_path).to eq(root_path)
#       end
#     end
#   end
  
# end