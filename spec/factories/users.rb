FactoryBot.define do #宣言文でありデータの定義を行う際に記述します。
  factory :user do #どのモデルに対してデータ定義を行うのか記します。factory :モデル名 do ~ end
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    
    after(:build) do |user|
      user.profile_image.attach(io: File.open('spec/images/profile_image.jpeg'), filename: 'profile_image.jpeg')
    end
  end
end
