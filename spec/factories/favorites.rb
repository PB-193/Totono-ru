FactoryBot.define do #宣言文でありデータの定義を行う際に記述します。
  factory :favorite do #どのモデルに対してデータ定義を行うのか記します。factory :モデル名 do ~ end
    association :user
    association :content
  end
end