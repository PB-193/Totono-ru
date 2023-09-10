# require 'rails_helper'

# describe '[STEP2] ユーザログイン後のテスト' do
#   let(:user) { create(:user) }
#   let!(:other_user) { create(:user) }
#   let!(:tag) { create(:tag) }
#   let!(:other_tag) { create(:tag) }
#   let!(:content) { create(:content, user: user, visit_day: Date.today) }
#   let!(:other_content) { create(:content, user: other_user, visit_day: Date.yesterday) }

  
#   before do
#     visit new_user_session_path
#     fill_in 'user[email]', with: user.email
#     fill_in 'user[password]', with: user.password
#     click_button 'ログイン'
#   end

#   describe '投稿一覧画面のテスト' do
      
#         before do
#           visit contents_path
#         end
    
#         context '表示内容の確認' do
#             it 'URLが正しい' do
#               expect(current_path).to eq '/contents'
#             end
            
#             it '自分と他人の投稿の投稿日が表示される' do
#               expect(page).to have_content content.created_at.strftime("%Y年%m月%d日")
#               expect(page).to have_content other_content.created_at.strftime("%Y年%m月%d日")
#             end
            
#             it '自分と他人の投稿のタイトルのリンク先が正しい' do
#               expect(page).to have_link content.title, href: content_path(content)
#               expect(page).to have_link other_content.title, href: content_path(other_content)
#             end
            
#             it '自分と他人の投稿のユーザ名が表示される' do
#               expect(page).to have_content content.user.name
#               expect(page).to have_content other_content.user.name
#             end
            
#             it '自分と他人の投稿のユーザ画像が表示される' do
#               expect(page).to have_css(".user_profile[src*='#{content.user.profile_image.filename}']")
#               expect(page).to have_css(".user_profile[src*='#{other_content.user.profile_image.filename}']")
#             end
            
#             it '自分と他人の投稿の訪問日が表示される' do
#               expect(page).to have_content content.visit_day.strftime("%Y年%m月%d日")
#               expect(page).to have_content other_content.visit_day.strftime("%Y年%m月%d日")
#             end
            
#             # it '自分と他人の投稿のタグが表示される' do
#             #   expect(page).to have_content tag.name
#             #   expect(page).to have_content other_tag.name
#             # end
            
#             it '自分と他人の投稿のサウナ施設が表示される' do
#               expect(page).to have_content content.spot
#               expect(page).to have_content other_content.spot
#             end
            
#             it '自分と他人の投稿のいいね数とコメント数が表示される' do
#               expect(page).to have_content "❤️ #{content.favorites.count} ️💬 #{content.comments.count}"
#               expect(page).to have_content "❤️ #{other_content.favorites.count} ️💬 #{other_content.comments.count}"
#             end
            
#             it '自分と他人のユーザ画像のリンク先が正しい' do
#               expect(page).to have_link(nil, href: myshow_path)
#               expect(page).to have_link(nil, href: user_path(other_content.user))
#             end
#         end
#     end

#     context '投稿成功のテスト' do
#       before do
#         visit new_content_path
#         fill_in 'content[title]', with: Faker::Lorem.characters(number: 5)
#         fill_in 'content[text]', with: Faker::Lorem.characters(number: 20)
#         fill_in 'content[visit_day]', with: Faker::Date.between(from: 1.month.ago, to: Date.today)
#         # fill_in 'content[tag]', with: Faker::Lorem.word
#         # fill_in 'content[rate]', with: rand(1.0..5.0)
#       end

#       it '自分の新しい投稿が正しく保存される' do
#         expect { click_button '投稿する' }.to change(user.contents, :count).by(1)
#       end
#       it 'リダイレクト先が、投稿一覧画面になっている' do
#         click_button '投稿する'
#         expect(current_path).to eq '/contents'
#       end
#     end
    

#   describe '投稿詳細画面のテスト' do
#     before do
#       visit content_path(content)
#     end

#     context '表示内容の確認' do
#       it 'URLが正しい' do
#         expect(current_path).to eq '/contents/' + content.id.to_s
#       end
#       it 'ユーザ名が表示される' do
#         expect(page).to have_content content.user.name
#       end
#       it '投稿の投稿日と訪問日が表示される' do
#         expect(page).to have_content content.created_at.strftime("%Y年%m月%d日")
#         expect(page).to have_content content.visit_day.strftime("%Y年%m月%d日")
#       end
#       it '投稿のtitleが表示される' do
#         expect(page).to have_content content.title
#       end
#       # it '投稿のタグ一覧が表示される' do
#       #   expect(page).to have_content tag.name
#       # end
#       it '投稿のサウナ施設が表示される、またリンク先が表示される' do
#         expect(page).to have_content content.spot
#         expect(page).to have_link content.spot, href: "https://www.google.com/maps/search/?api=1&query=#{CGI.escape(content.spot)}"
#       end
#       # it '投稿のととのい度が表示される' do
#       #   expect(page).to have_content content.rate
#       # end
#       it '投稿の本文が表示される' do
#         expect(page).to have_content content.text
#       end

#       # it '投稿のいいねができるか' do
#       #   find("a[href='#{content_favorites_path(content.id)}']") # いいねボタンをクリック
#       #   visit current_path # ページを再読み込みして変更を反映
#       #   sleep 1 # 一時的な遅延（必要に応じて調整）
#       #   expect(page).to have_content "❤️ #{content.favorites.count}"   
#       # end
      
#       it '投稿のコメント一覧が表示される' do
#         content.comments.each do |comment|
#           expect(page).to have_content comment.text
#         end
#       end
#       it 'コメントフォームが表示される' do
#         expect(page).to have_selector 'textarea[name="comment[comment]"]'
#         expect(page).to have_button 'コメント'
#       end
#       it 'コメントができるか' do
#         comment_text = Faker::Lorem.sentence
#         fill_in 'comment[comment]', with: comment_text
#         click_button 'コメント'
#         expect(page).to have_content comment_text
#       end
#       # it '自分がコメントしたコメントを削除ができるか' do
#       #   comment = create(:comment, user: user, content: content)
#       #   visit content_path(content)
#       #   within "#comment_#{comment.id}" do
#       #   click_link '削除'
#       #   end
#       #   expect(page).not_to have_content comment.comment # 削除されたコメントは表示されないことを確認する処理
#       # end
#     end
  
#     # context '投稿の削除テスト' do
#     #   before do
#     #     visit content_path(content)
#     #   end
#     #   it '投稿の削除リンクが表示される（自分の投稿のみ）' do
#     #     expect(page).to have_link '削除する', href: content_path(content)
#     #   end
      
#     #   before do
#     #     click_link '削除する'
#     #   end
#     #   it '正しく削除される' do
#     #     expect(Content.where(id: content.id).count).to eq 0
#     #   end
#     #   it 'リダイレクト先が、投稿一覧画面になっている' do
#     #     expect(current_path).to eq '/contents'
#     #   end
#     # end

# #     context '編集リンクのテスト' do
# #       it '編集画面に遷移する' do
# #         click_link 'Edit'
# #         expect(current_path).to eq '/books/' + book.id.to_s + '/edit'
# #       end
# #     end

# #     context '削除リンクのテスト' do
# #       before do
# #         click_link 'Destroy'
# #       end

# #       it '正しく削除される' do
# #         expect(Book.where(id: book.id).count).to eq 0
# #       end
# #       it 'リダイレクト先が、投稿一覧画面になっている' do
# #         expect(current_path).to eq '/books'
# #       end
# #     end
#     end

# #   describe '自分の投稿編集画面のテスト' do
# #     before do
# #       visit edit_book_path(book)
# #     end

# #     context '表示の確認' do
# #       it 'URLが正しい' do
# #         expect(current_path).to eq '/books/' + book.id.to_s + '/edit'
# #       end
# #       it '「Editing Book」と表示される' do
# #         expect(page).to have_content 'Editing Book'
# #       end
# #       it 'title編集フォームが表示される' do
# #         expect(page).to have_field 'book[title]', with: book.title
# #       end
# #       it 'opinion編集フォームが表示される' do
# #         expect(page).to have_field 'book[body]', with: book.body
# #       end
# #       it 'Update Bookボタンが表示される' do
# #         expect(page).to have_button 'Update Book'
# #       end
# #       it 'Showリンクが表示される' do
# #         expect(page).to have_link 'Show', href: book_path(book)
# #       end
# #       it 'Backリンクが表示される' do
# #         expect(page).to have_link 'Back', href: books_path
# #       end
# #     end

# #     context '編集成功のテスト' do
# #       before do
# #         @book_old_title = book.title
# #         @book_old_body = book.body
# #         fill_in 'book[title]', with: Faker::Lorem.characters(number: 4)
# #         fill_in 'book[body]', with: Faker::Lorem.characters(number: 19)
# #         click_button 'Update Book'
# #       end

# #       it 'titleが正しく更新される' do
# #         expect(book.reload.title).not_to eq @book_old_title
# #       end
# #       it 'bodyが正しく更新される' do
# #         expect(book.reload.body).not_to eq @book_old_body
# #       end
# #       it 'リダイレクト先が、更新した投稿の詳細画面になっている' do
# #         expect(current_path).to eq '/books/' + book.id.to_s
# #         expect(page).to have_content 'Book detail'
# #       end
# #     end
# #   end

# #   describe 'ユーザ一覧画面のテ��ト' do
# #     before do
# #       visit users_path
# #     end

# #     context '表示内容の確認' do
# #       it 'URLが正しい' do
# #         expect(current_path).to eq '/users'
# #       end
# #       it '自分と他人の画像が表示される: fallbackの画像がサイドバーの1つ＋一覧(2人)の2つの計3つ存在する' do
# #         expect(all('img').size).to eq(3)
# #       end
# #       it '自分と他人の名前がそれぞれ表示される' do
# #         expect(page).to have_content user.name
# #         expect(page).to have_content other_user.name
# #       end
# #       it '自分と他人のshowリンクがそれぞれ表示される' do
# #         expect(page).to have_link 'Show', href: user_path(user)
# #         expect(page).to have_link 'Show', href: user_path(other_user)
# #       end
# #     end

# #   describe '自分のユーザ詳細画面のテスト' do
# #     before do
# #       visit user_path(user)
# #     end

# #     context '表示の確認' do
# #       it 'URLが正しい' do
# #         expect(current_path).to eq '/users/' + user.id.to_s
# #       end
# #       it '投稿一覧のユーザ画像のリンク先が正しい' do
# #         expect(page).to have_link '', href: user_path(user)
# #       end
# #       it '投稿一覧に自分の投稿のtitleが表示され、リンクが正しい' do
# #         expect(page).to have_link book.title, href: book_path(book)
# #       end
# #       it '投稿一覧に自分の投稿のopinionが表示される' do
# #         expect(page).to have_content book.body
# #       end
# #       it '他人の投稿は表示されない' do
# #         expect(page).not_to have_link '', href: user_path(other_user)
# #         expect(page).not_to have_content other_book.title
# #         expect(page).not_to have_content other_book.body
# #       end
# #     end

# #   describe '自分のユーザ情報編集画面のテスト' do
# #     before do
# #       visit edit_user_path(user)
# #     end

# #     context '表示の確認' do
# #       it 'URLが正しい' do
# #         expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
# #       end
# #       it '名前編集フォームに自分の名前が表示される' do
# #         expect(page).to have_field 'user[name]', with: user.name
# #       end
# #       it '画像編集フォームが表示される' do
# #         expect(page).to have_field 'user[profile_image]'
# #       end
# #       it '自己紹介編集フォームに自分の自己紹介文が表示される' do
# #         expect(page).to have_field 'user[introduction]', with: user.introduction
# #       end
# #       it 'Update Userボタンが表示される' do
# #         expect(page).to have_button 'Update User'
# #       end
# #     end

# #     context '更新成功のテスト' do
# #       before do
# #         @user_old_name = user.name
# #         @user_old_intrpduction = user.introduction
# #         fill_in 'user[name]', with: Faker::Lorem.characters(number: 9)
# #         fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 19)
# #         click_button 'Update User'
# #       end

# #       it 'nameが正しく更新される' do
# #         expect(user.reload.name).not_to eq @user_old_name
# #       end
# #       it 'introductionが正しく更新される' do
# #         expect(user.reload.introduction).not_to eq @user_old_intrpduction
# #       end
# #       it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
# #         expect(current_path).to eq '/users/' + user.id.to_s
# #       end
# #     end
# #   end
# end
