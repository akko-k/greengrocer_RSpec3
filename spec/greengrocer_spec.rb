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
      let(:adding_products) do
        [
          {name: "ごぼう", price: 250},
          {name: "れんこん", price: 350}
        ]
      end
      let(:greengrocer) { Greengrocer.new(product_params) }
      let(:products) { greengrocer.products }
      
      it "@productsの要素の数と「product_paramsとadding_productsの要素の数の和」が同じであること" do
        greengrocer.register_product(adding_products)
        expect(products.size).to eq (product_params + adding_products).size
      end

      it "@productsの指定する要素とadding_productsの指定する要素の名前が同じであること" do
        greengrocer.register_product(adding_products)
        expect(products[product_params.size].name).to eq adding_products[0][:name]
      end
      
      it "@productsの指定する要素とadding_productsの指定する要素の名前が同じであること" do
        greengrocer.register_product(adding_products)
        expect(products[product_params.size].price).to eq adding_products[0][:price]
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
        expect { greengrocer.disp_products }
          .to output( "いらっしゃいませ！商品を選んで下さい。\n#{id + 1}.#{product_params[0][:name]}(¥#{product_params[0][:price]})\n#{id + 2}.#{product_params[1][:name]}(¥#{product_params[1][:price]})\n" ).to_stdout
      end
    end
  end
end