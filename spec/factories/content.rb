FactoryBot.define do #宣言文でありデータの定義を行う際に記述します。
  factory :content do #どのモデルに対してデータ定義を行うのか記します。factory :モデル名 do ~ end
    user # この行で関連する User レコードを生成
    visit_day { Date.today }
    spot { Faker::Lorem.word }
    title { Faker::Lorem.sentence }
    text { Faker::Lorem.paragraph }
    rate { rand(1.0..5.0) }
    created_at { Time.now }
    updated_at { Time.now }
  end
end
