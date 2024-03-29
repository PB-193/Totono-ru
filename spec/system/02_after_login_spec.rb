require 'rails_helper'

describe '[STEP2] ユーザログイン後の投稿のテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:tag) { create(:tag) }
  let!(:other_tag) { create(:tag) }
  let!(:content) { create(:content, user: user, visit_day: Date.today) }
  let!(:other_content) { create(:content, user: other_user, visit_day: Date.yesterday) }

  
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe '投稿一覧画面のテスト' do
      
    before do
      visit contents_path
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/contents'
      end
      
      it '自分と他人の投稿の投稿日が表示される' do
        expect(page).to have_content content.created_at.strftime("%Y年%m月%d日")
        expect(page).to have_content other_content.created_at.strftime("%Y年%m月%d日")
      end
      
      it '自分と他人の投稿のタイトルのリンク先が正しい' do
        expect(page).to have_link content.title, href: content_path(content)
        expect(page).to have_link other_content.title, href: content_path(other_content)
      end
      
      it '自分と他人の投稿のユーザ名が表示される' do
        expect(page).to have_content content.user.name
        expect(page).to have_content other_content.user.name
      end
      
      it '自分と他人の投稿のユーザ画像が表示される' do
        expect(page).to have_css(".user_profile[src*='#{content.user.profile_image.filename}']")
        expect(page).to have_css(".user_profile[src*='#{other_content.user.profile_image.filename}']")
      end
      
      it '自分と他人の投稿の訪問日が表示される' do
        expect(page).to have_content content.visit_day.strftime("%Y年%m月%d日")
        expect(page).to have_content other_content.visit_day.strftime("%Y年%m月%d日")
      end
      
      # it '自分と他人の投稿のタグが表示される' do
      #   expect(page).to have_content tag.name
      #   expect(page).to have_content other_tag.name
      # end
      
      it '自分と他人の投稿のサウナ施設が表示される' do
        expect(page).to have_content content.spot
        expect(page).to have_content other_content.spot
      end
      
      it '自分と他人のレビューの閲覧数が表示される' do
        expect(page).to have_content content.impressionist_count
        expect(page).to have_content other_content.impressionist_count
      end
      
      it '自分と他人の投稿のいいね数とコメント数が表示される' do
        expect(page).to have_content "❤️ #{content.favorites.count} ️💬 #{content.comments.count}"
        expect(page).to have_content "❤️ #{other_content.favorites.count} ️💬 #{other_content.comments.count}"
      end
      
      it '自分と他人のユーザ画像のリンク先が正しい' do
        expect(page).to have_link(nil, href: myshow_path)
        expect(page).to have_link(nil, href: user_path(other_content.user))
      end
    end

    context '投稿成功のテスト' do
      before do
        visit new_content_path
        fill_in 'content[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'content[text]', with: Faker::Lorem.characters(number: 20)
        fill_in 'content[visit_day]', with: Faker::Date.between(from: 1.month.ago, to: Date.today)
        # fill_in 'content[tag]', with: Faker::Lorem.word
        # fill_in 'content[rate]', with: rand(1.0..5.0)
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '投稿する' }.to change(user.contents, :count).by(1)
      end
      it 'リダイレクト先が、投稿一覧画面になっている' do
        click_button '投稿する'
        expect(current_path).to eq '/contents'
      end
    end
    
  end


  describe '投稿詳細画面のテスト' do
    before do
      visit content_path(content)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/contents/' + content.id.to_s
      end
      it 'ユーザ名が表示される' do
        expect(page).to have_content content.user.name
      end
      it '投稿の投稿日と訪問日が表示される' do
        expect(page).to have_content content.created_at.strftime("%Y年%m月%d日")
        expect(page).to have_content content.visit_day.strftime("%Y年%m月%d日")
      end
      it '投稿のtitleが表示される' do
        expect(page).to have_content content.title
      end
      # it '投稿のタグ一覧が表示される' do
      #   expect(page).to have_content tag.name
      # end
      it '投稿のサウナ施設が表示される、またリンク先が表示される' do
        expect(page).to have_content content.spot
        expect(page).to have_link content.spot, href: "https://www.google.com/maps/search/?api=1&query=#{CGI.escape(content.spot)}"
      end
      # it '投稿のととのい度が表示される' do
      #   expect(page).to have_content content.rate
      # end
      it '投稿の閲覧数が表示される' do
        expect(page).to have_content content.impressionist_count
      end
      it '投稿の本文が表示される' do
        expect(page).to have_content content.text
      end

      # it '投稿のいいねができるか' do
      #   find("a[href='#{content_favorites_path(content.id)}']")
      #   visit current_path
      #   sleep 1 # 一時的な遅延（必要に応じて調整）
      #   expect(page).to have_content "❤️ #{content.favorites.count}"   
      # end
      
      it '投稿のコメント一覧が表示される' do
        content.comments.each do |comment|
          expect(page).to have_content comment.text
        end
      end
      it 'コメントフォームが表示される' do
        expect(page).to have_selector 'textarea[name="comment[comment]"]'
        expect(page).to have_button 'コメント'
      end
      it 'コメントができるか' do
        comment_text = Faker::Lorem.sentence
        fill_in 'comment[comment]', with: comment_text
        click_button 'コメント'
        expect(page).to have_content comment_text
      end
      # it '自分がコメントしたコメントを削除ができるか' do
      #   comment = create(:comment, user: user, content: content)
      #   visit content_path(content)
      #   within "comment_#{comment.id}" do
      #     click_link '削除'
      #   end
      #   expect(page).not_to have_content comment.comment # 削除されたコメントは表示されないことを確認する処理
      # end
    end
  
    context '投稿の削除テスト' do
      before do
        click_link '削除する'
      end
      it '正しく削除される' do
        expect(Content.where(id: content.id).count).to eq 0
      end
      it 'リダイレクト先が、投稿一覧画面になっている' do
        expect(current_path).to eq '/contents'
      end
    end

    context '編集リンクのテスト' do
      it '編集画面に遷移する' do
        click_link '編集する'
        expect(current_path).to eq '/contents/' + content.id.to_s + '/edit'
      end
    end

  end

  describe '投稿編集画面のテスト' do
    before do
      visit edit_content_path(content)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/contents/' + content.id.to_s + '/edit'
      end
      it 'レビュータイトルの編集フォームが表示される' do
        expect(page).to have_field 'content[title]', with: content.title
      end
      it '本文の編集フォームが表示される' do
        expect(page).to have_field 'content[text]', with: content.text
      end
      it '訪問した日の編集フォームが表示される' do
        expect(page).to have_field 'content[visit_day]', with: content.visit_day
      end
      # it 'タグの編集フォームが表示される' do
      #   expect(page).to have_field 'content[text]', with: content.text
      # end
      it 'サウナ施設の編集フォームが表示される' do
        expect(page).to have_field 'content[spot]', with: content.spot
      end
      # it 'ととのい度の編集フォームが表示される' do
      #   expect(page).to have_field 'content[rate]', with: content.rate
      # end
      it '編集ボタンが表示される' do
        expect(page).to have_button '変更を保存する'
      end
    end

    context '編集成功のテスト' do
      before do
        @content_old_title = content.title
        @content_old_text = content.text
        fill_in 'content[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'content[text]', with: Faker::Lorem.characters(number: 20)
        fill_in 'content[visit_day]', with: Faker::Date.between(from: 1.month.ago, to: Date.today)
        # fill_in 'content[tag]', with: Faker::Lorem.word
        # fill_in 'content[rate]', with: rand(1.0..5.0)
      end

      it 'タイトルが正しく更新される' do
        click_button '変更を保存する'
        expect(content.reload.title).not_to eq @content_old_title
      end
      it '本文が正しく更新される' do
        click_button '変更を保存する'
        expect(content.reload.text).not_to eq @content_old_text
      end
      it 'リダイレクト先が、投稿詳細画面になっている' do
        click_button '変更を保存する'
        expect(current_path).to eq '/contents/' + content.id.to_s
      end
      
    end
    
  end
end
