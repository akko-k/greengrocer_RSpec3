RSpec.describe Greengrocer do
  let(:product_params) do
    [
      { name: "トマト", price: 100 },
      { name: "きゅうり", price: 200 }, #不要？
    ]
  end
  let(:greengrocer) { Greengrocer.new(product_params) }
  let(:products) { greengrocer.products }
  # ▼単体テスト2 正常系（Greengrocerクラスのインスタンス生成）
  describe ".initialize" do
    context "インスタンスが生成されたとき" do
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
      let(:adding_product_params) do
        [
          { name: "ごぼう", price: 250 },
          { name: "れんこん", price: 350 },
        ]
      end
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
      it "出力処理ができていること" do
        base_id = Product.class_variable_get("@@count")
        hello_msg = "いらっしゃいませ！商品を選んで下さい。"
        product_msg1 = "#{base_id + 1}.トマト(¥100)"
        product_msg2 = "#{base_id + 2}.きゅうり(¥200)"
        msg = "#{hello_msg}\n#{product_msg1}\n#{product_msg2}\n"
        expect { greengrocer.disp_products }.to output(msg).to_stdout
      end
    end
  end

  # ▼単体テスト6 正常系(ask_quantityメソッド)
  describe ".ask_quantity" do
    let(:chosen_product) { Product.new({ name: "玉ねぎ", price: 300 }) }
    let(:ask_msg) { "玉ねぎですね。何個買いますか？\n" }
    context "メソッドが実行されたとき" do
      it "userが選択した商品の名前を含む，期待した表示がされること" do
        expect { greengrocer.ask_quantity(chosen_product) }.to output(ask_msg).to_stdout
      end
    end
  end

  # 【単体テスト8 正常系】calculate_chargesメソッドが期待通り動作する
  #  --> 条件分岐が複数あるので，quantity_of_productが4個のときと5個のときだけでなく，chosen_productも2種類ぐらい確認しておいた方が無難。
  describe ".calculate_charges" do
    let(:user) { User.new }
    let(:discount_msg) { "5個以上なので10％割引となります！" }
    let(:thank_msg) { "お買い上げありがとうございました！" }

    shared_examples "正しい合計金額を含む，期待した表示がされること" do
      it "正しい合計金額を含む，期待した表示がされること" do
        user.instance_variable_set("@chosen_product", chosen_product)
        user.instance_variable_set("@quantity_of_product", quantity_of_product)
        expect{ greengrocer.calculate_charges(user) }.to output("#{total_price_msg}\n#{thank_msg}\n").to_stdout
      end
    end

    shared_examples "割引した正しい合計金額を含む，期待した表示がされること" do
      it do
        user.instance_variable_set("@chosen_product", chosen_product)
        user.instance_variable_set("@quantity_of_product", quantity_of_product)
        expect{ greengrocer.calculate_charges(user) }.to output("#{discount_msg}\n#{discount_total_price_msg}\n#{thank_msg}\n").to_stdout
      end
    end

    context "quantity_of_productが4個，chosen_productが玉ねぎのとき" do
      let(:chosen_product){ Product.new({ name: "玉ねぎ", price: 300 }) }
      let(:quantity_of_product) { 4 }
      let(:total_price_msg){ "合計金額は1200円です。" }
      it_behaves_like "正しい合計金額を含む，期待した表示がされること"
    end

    context "quantity_of_productが4個，chosen_productがなすのとき" do
      let(:chosen_product){ Product.new({ name: "なす", price: 400 }) }
      let(:quantity_of_product) { 4 }
      let(:total_price_msg){ "合計金額は1600円です。" }
      it_behaves_like "正しい合計金額を含む，期待した表示がされること"
    end

    context "quantity_of_productが5個，chosen_productが玉ねぎのとき" do
      let(:chosen_product){ Product.new({ name: "玉ねぎ", price: 300 }) }
      let(:quantity_of_product) { 5 }
      let(:discount_total_price_msg){ "合計金額は1350円です。" }
      it_behaves_like "割引した正しい合計金額を含む，期待した表示がされること"
    end

    context "quantity_of_productが5個，chosen_productがなすのとき" do
      let(:chosen_product){ Product.new({ name: "なす", price: 400 }) }
      let(:quantity_of_product) { 5 }
      let(:discount_total_price_msg){ "合計金額は1800円です。" }
      it_behaves_like "割引した正しい合計金額を含む，期待した表示がされること"
    end
  end
end
