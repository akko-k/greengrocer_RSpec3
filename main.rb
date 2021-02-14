require_relative "product.rb"
require_relative "greengrocer.rb"
require_relative "user.rb"
require "pry"

# 商品データ
product_params1 = [
  {name: "トマト", price: 100},
  {name: "きゅうり", price: 200},
  {name: "玉ねぎ", price: 300},
  {name: "なす", price: 400}
]

# product_params1の商品を持つ八百屋の開店
greengrocer1 = Greengrocer.new(product_params1)
# 追加商品データ
adding_product_params1 = [
  {name: "ごぼう", price: 250},
  {name: "れんこん", price: 350}
]

# 商品を登録（adding_product_params1 の商品を追加）
greengrocer1.register_product(adding_product_params1)

# お客さんの来店
user = User.new

# 商品を表示
greengrocer1.disp_products
# 商品を選択
user.choose_product(greengrocer1.products)
# 個数を質問
greengrocer1.ask_quantity(user.chosen_product)
# 個数を決定
user.decide_quantity
# 金額金額を計算
greengrocer1.calculate_charges(user)
