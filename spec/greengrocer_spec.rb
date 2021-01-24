RSpec.describe Greengrocer do
  # ▼単体テスト2 正常系（Greengrocerクラスのインスタンス生成）
  describe ".initialize" do
    context "インスタンスが生成されたとき" do
      let(:product_params) do
        [
          { name: "トマト", price: 100 },
          { name: "きゅうり", price: 200 }
        ]
      end
      let(:greengrocer) { Greengrocer.new(product_params) }
      let(:products) { greengrocer.products }

      it "@productsの数とproduct_paramsの要素の数が同じであること" do
        expect(products.size).to eq product_params.size
      end

      it "@productsとproduct_paramsそれぞれの1つ目の要素の名前が同じであること" do
        expect(products[0].name).to eq product_params[0][:name]
      end
      
      it "@productsとproduct_paramsそれぞれの要素の金額が同じであること" do
        expect(products[0].price).to eq product_params[0][:price]
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
        expect(products.size).to eq (product_params + adding_product_params).size
      end

      it "@productsの最後の要素とadding_product_paramsの最後の要素の名前が同じであること" do
        greengrocer.register_product(adding_product_params)
        expect(products[-1].name).to eq adding_product_params[-1][:name]
      end
      
      it "@productsの最後の要素とadding_product_paramsの最後の要素の名前が同じであること" do
        greengrocer.register_product(adding_product_params)
        expect(products[-1].price).to eq adding_product_params[-1][:price]
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
        product_msg1 = "#{id + 1}.#{product_params[0][:name]}(¥#{product_params[0][:price]})"
        product_msg2 = "#{id + 2}.#{product_params[1][:name]}(¥#{product_params[1][:price]})"
        expect { greengrocer.disp_products }
          .to output("#{hello_msg}\n#{product_msg1}\n#{product_msg2}\n").to_stdout
      end
    end
  end
end

# ▼単体テスト6 正常系(ask_quantityメソッド)
describe ".ask_quantity" do
  let(:product_params) do
    [
      { name: "トマト", price: 100 },
      { name: "きゅうり", price: 200 }
    ]
  end
  let(:greengrocer) { Greengrocer.new(product_params) }
  let(:products) { greengrocer.products }
  let(:user) { User.new }
  let(:correct_input) { "#{products.last.id}\n" }
  let(:chosen_product) { user.chosen_product }
  let(:ask_msg) { "#{chosen_product.name}ですね。何個買いますか？\n" }
  context "メソッドが実行されたとき" do
    it "userが選択した商品の名前を含む，期待した表示がされること" do
      allow(ARGF).to receive(:gets).and_return correct_input
      user.choose_product(products)
      expect{ greengrocer.ask_quantity(chosen_product)}.to output(ask_msg).to_stdout
    end
  end
end