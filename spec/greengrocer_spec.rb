RSpec.describe Greengrocer do
  # ▼単体テスト2 正常系（Greengrocerクラスのインスタンス生成）
  describe ".initialize" do
    context "インスタンスが生成されたとき" do
      let(:product_params) do
        [
          { name: "トマト", price: 100 },
          { name: "きゅうり", price: 200 } #不要？
        ]
      end
      let(:greengrocer) { Greengrocer.new(product_params) }
      let(:products) { greengrocer.products }

      it "@productsの数とproduct_paramsの要素の数が同じであること" do
        expect(products.size).to eq 2
      end

      it "@productsとproduct_paramsそれぞれの1つ目の要素の名前が同じであること" do
        expect(products[0].name).to eq "トマト"
      end
      
      it "@productsとproduct_paramsそれぞれの要素の金額が同じであること" do
        expect(products[0].price).to eq 100
      end
    end
  end

  # ▼単体テスト３ 正常系(register_productメソッド)
  describe ".register_product" do
    context "メソッドが実行されたとき" do
      let(:product_params) do
        [
          { name: "トマト", price: 100 },
          { name: "きゅうり", price: 200 }
        ]
      end
      let(:adding_product_params) do
        [
          {name: "ごぼう", price: 250},
          {name: "れんこん", price: 350}
        ]
      end
      let(:greengrocer) { Greengrocer.new(product_params) }
      let(:products) { greengrocer.products }
      
      it "@productsの要素の数と「product_paramsとadding_product_paramsの要素の数の和」が同じであること" do
        greengrocer.register_product(adding_product_params)
        expect(products.size).to eq 4
      end

      it "@productsの最後の要素とadding_product_paramsの最後の要素の名前が同じであること" do
        greengrocer.register_product(adding_product_params)
        expect(products[-1].name).to eq "れんこん"
      end
      
      it "@productsの最後の要素とadding_product_paramsの最後の要素の名前が同じであること" do
        greengrocer.register_product(adding_product_params)
        expect(products[-1].price).to eq 350
      end
    end
  end

  # ▼単体テスト4 正常系(disp_productsメソッド)
  describe ".disp_products" do
    context "メソッドが実行されたとき" do
      let(:product_params) do
        [
          { name: "トマト", price: 100 },
          { name: "きゅうり", price: 200 }
        ]
      end
      let(:greengrocer) { Greengrocer.new(product_params) }
      
      it "出力処理ができていること" do
        id = Product.class_variable_get('@@count')
        hello_msg = "いらっしゃいませ！商品を選んで下さい。"
        product_msg1 = "#{id + 1}.#{ "トマト" }(¥#{100})"
        product_msg2 = "#{id + 2}.#{ "きゅうり" }(¥#{200})"
        expect { greengrocer.disp_products }
          .to output("#{hello_msg}\n#{product_msg1}\n#{product_msg2}\n").to_stdout
      end
    end
  end

  # ▼単体テスト4 正常系(disp_productsメソッド)※直接productsを指定する場合
  describe ".disp_products" do
    context "メソッドが実行されたとき" do
      let(:product_params) do
        [
          { name: "ごぼう", price: 250 }
        ]
      end
      let(:greengrocer) { Greengrocer.new(product_params) }
      let(:products) { [ Product.new({ id: 1, name: "トマト", price: 100 }),Product.new({ id: 2, name: "きゅうり", price: 200 })] }
      
      it "出力処理ができていること" do
        hello_msg = "いらっしゃいませ！商品を選んで下さい。"
        product_msg1 = "1.#{ "トマト" }(¥#{100})"
        product_msg2 = "2.#{ "きゅうり" }(¥#{200})"
        expect { greengrocer.disp_products }
          .to output("#{hello_msg}\n#{product_msg1}\n#{product_msg2}\n").to_stdout
      end
    end
  end
end

# # ▼単体テスト6 正常系(ask_quantityメソッド)
# describe ".ask_quantity" do
#   let(:product_params) do
#     [
#       { name: "トマト", price: 100 },
#       { name: "きゅうり", price: 200 }
#     ]
#   end
#   let(:greengrocer) { Greengrocer.new(product_params) }
#   # let(:products) { greengrocer.products }
#   # let(:user) { User.new }
#   # let(:correct_input) { "#{products.last.id}\n" }
#   let(:chosen_product) { Product.new({name: "トマト", price: 100}) }
#   let(:ask_msg) { "#{chosen_product.name}ですね。何個買いますか？\n" }
#   context "メソッドが実行されたとき" do
#     it "userが選択した商品の名前を含む，期待した表示がされること" do
#       # allow(ARGF).to receive(:gets).and_return correct_input
#       # user.choose_product(products)
#       expect{ greengrocer.ask_quantity(chosen_product)}.to output(ask_msg).to_stdout
#     end
#   end
# end
# # 【単体テスト8 正常系】calculate_chargesメソッドが期待通り動作する
# #  --> 条件分岐が複数あるので，quantity_of_productが4個のときと5個のときだけでなく，chosen_productも2種類ぐらい確認しておいた方が無難。
# describe ".calculate_charges" do
#   # let(:product_params) do
#   #   [
#   #     { name: "トマト", price: 100 },
#   #     { name: "きゅうり", price: 200 }
#   #   ]
#   # end
#   let(:greengrocer) { Greengrocer.new }
#   # let(:products) { greengrocer.products } # 略しているだけ
#   let(:user) { User.new }
#   let(:discount_msg) { "5個以上なので10％割引となります！" }
#   let(:total_price_msg){ "合計金額は#{(chosen_product.price * quantity_of_product).floor }円です。" }
#   let(:discount_total_price_msg){ "合計金額は#{(chosen_product.price * quantity_of_product * 0.9).floor }円です。" }
#   let(:thank_msg) { "お買い上げありがとうございました！" }

#   context "quantity_of_productが4個，chosen_productがトマトのとき" do
#     let(:chosen_product){ Product.new({ name: "トマト", price: 100 }) }
#     let(:quantity_of_product) { 4 }
    
#     it "正しい合計金額を含む，期待した表示がされること" do
#       user.instance_variable_set("@chosen_product", chosen_product)
#       user.instance_variable_set("@quantity_of_product", quantity_of_product)
#       expect{ greengrocer.calculate_charges(user) }.to output("#{total_price_msg}\n#{thank_msg}\n").to_stdout
#     end
#   end

#   context "quantity_of_productが4個，chosen_productがきゅうりのとき" do
#     let(:chosen_product){ Product.new({ name: "きゅうり", price: 200 }) }
#     let(:quantity_of_product) { 4 }
    
#     it "正しい合計金額を含む，期待した表示がされること" do
#       user.instance_variable_set("@chosen_product", chosen_product)
#       user.instance_variable_set("@quantity_of_product", quantity_of_product)
#       expect{ greengrocer.calculate_charges(user) }.to output("#{total_price_msg}\n#{thank_msg}\n").to_stdout
#     end
#   end

#   context "quantity_of_productが5個，chosen_productがトマトのとき" do
#     let(:chosen_product){ Product.new({ name: "トマト", price: 100 }) }
#     let(:quantity_of_product) { 5 }
    
#     it "正しい合計金額を含む，期待した表示がされること" do
#       user.instance_variable_set("@chosen_product", chosen_product)
#       user.instance_variable_set("@quantity_of_product", quantity_of_product)
#       expect{ greengrocer.calculate_charges(user) }.to output("#{discount_msg}\n#{discount_total_price_msg}\n#{thank_msg}\n").to_stdout
#     end
#   end

#   context "quantity_of_productが5個，chosen_productがきゅうりのとき" do
#     let(:chosen_product){ Product.new({ name: "きゅうり", price: 200 }) }
#     let(:quantity_of_product) { 5 }
    
#     it "正しい合計金額を含む，期待した表示がされること" do
#       user.instance_variable_set("@chosen_product", chosen_product)
#       user.instance_variable_set("@quantity_of_product", quantity_of_product)
#       expect{ greengrocer.calculate_charges(user) }.to output("#{discount_msg}\n#{discount_total_price_msg}\n#{thank_msg}\n").to_stdout
#     end
#   end
# end

# # # 総合テストになっている
# # describe ".grenngrocer_program" do #テスト名は仮
# #   let(:product_params) do
# #     [
# #       { name: "トマト", price: 100 },
# #       { name: "きゅうり", price: 200 }
# #     ]
# #   end
# #   let(:greengrocer) { Greengrocer.new(product_params) }
# #   let(:products) { greengrocer.products }
# #   let(:user) { User.new }
# #   let(:chosen_product) { user.chosen_product }
# #   let(:quantity_of_product) { user.quantity_of_product }
# #   let(:thank_msg) { "お買い上げありがとうございました！" }

# #   context "quantity_of_productが4個，chosen_productが最初の要素のとき" do
# #     let(:quantity_of_product_input) { 4 }
# #     let(:select_product_num_input) { "#{products.first.id}\n" }
# #     let(:total_price_msg){ "合計金額は#{(chosen_product.price * quantity_of_product).floor }円です。" }
# #     it "正しい合計金額を含む，期待した表示がされること" do
# #       allow(ARGF).to receive(:gets).and_return select_product_num_input
# #       user.choose_product(products)
# #       allow(ARGF).to receive(:gets).and_return quantity_of_product_input
# #       user.decide_quantity
# #       greengrocer.calculate_charges(user)
# #       expect{ greengrocer.calculate_charges(user) }.to output("#{total_price_msg}\n#{thank_msg}\n").to_stdout
# #     end
# #   end

# #   context "quantity_of_productが4個，chosen_productが最後の要素のとき" do
# #     let(:quantity_of_product_input) { 4 }
# #     let(:select_product_num_input) { "#{products.last.id}\n" }
# #     let(:total_price_msg){ "合計金額は#{(chosen_product.price * quantity_of_product).floor }円です。" }
# #     it "正しい合計金額を含む，期待した表示がされること" do
# #       allow(ARGF).to receive(:gets).and_return select_product_num_input
# #       user.choose_product(products)
# #       allow(ARGF).to receive(:gets).and_return quantity_of_product_input
# #       user.decide_quantity
# #       greengrocer.calculate_charges(user)
# #       expect{ greengrocer.calculate_charges(user) }.to output("#{total_price_msg}\n#{thank_msg}\n").to_stdout
# #     end
# #   end

# #   context "quantity_of_productが5個，chosen_productが最初の要素のとき" do
# #     let(:quantity_of_product_input) { 5 }
# #     let(:select_product_num_input) { "#{products.first.id}\n" }
# #     let(:total_price_msg){ "合計金額は#{(chosen_product.price * quantity_of_product * 0.9).floor }円です。" }
# #     let(:discount_msg) { "5個以上なので10％割引となります！" }
# #     it "正しい合計金額を含む，期待した表示がされること" do
# #       allow(ARGF).to receive(:gets).and_return select_product_num_input
# #       user.choose_product(products)
# #       allow(ARGF).to receive(:gets).and_return quantity_of_product_input
# #       user.decide_quantity
# #       greengrocer.calculate_charges(user)
# #       expect{ greengrocer.calculate_charges(user) }.to output("#{discount_msg}\n#{total_price_msg}\n#{thank_msg}\n").to_stdout
# #     end
# #   end

# #   context "quantity_of_productが5個，chosen_productが最後の要素のとき" do
# #     let(:quantity_of_product_input) { 5 }
# #     let(:select_product_num_input) { "#{products.last.id}\n" }
# #     let(:total_price_msg){ "合計金額は#{(chosen_product.price * quantity_of_product * 0.9).floor }円です。" }
# #     let(:discount_msg) { "5個以上なので10％割引となります！" }
# #     it "正しい合計金額を含む，期待した表示がされること" do
# #       allow(ARGF).to receive(:gets).and_return select_product_num_input
# #       user.choose_product(products)
# #       allow(ARGF).to receive(:gets).and_return quantity_of_product_input
# #       user.decide_quantity
# #       greengrocer.calculate_charges(user)
# #       expect{ greengrocer.calculate_charges(user) }.to output("#{discount_msg}\n#{total_price_msg}\n#{thank_msg}\n").to_stdout
# #     end
# #   end
# # end

# # quantity_of_productが4個のとき,
# # chosen_productがトマトのとき
# #  "合計金額は#{total_price.floor}円です。"と出力される 
# # chosen_productがきゅうりのとき
# #  "合計金額は#{total_price.floor}円です。"と出力される

# # quantity_of_productが5個のとき，
# # chosen_productがトマトのとき
# #  "5個以上なので10％割引となります！""合計金額は#{total_price.floor}円です。"と出力される

# # chosen_productがきゅうりのとき
# #  "5個以上なので10％割引となります！""合計金額は#{total_price.floor}円です。"と出力される