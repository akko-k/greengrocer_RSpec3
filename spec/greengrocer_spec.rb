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

      it "@productsとproduct_paramsの1つ目の要素の名前が同じであること" do
        expect(products[0].name).to eq product_params[0][:name]
      end
      
      it "@productsとproduct_paramsの1つ目の要素の金額が同じであること" do
        expect(products[0].price).to eq product_params[0][:price]
      end
    end
  end

  # ▼単体テスト３ 正常系(register_productメソッド) ※インスタンス生成時と同様になってしまっている
  describe ".register_product" do
    context "メソッドが実行されたとき" do
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

      it "@productsとproduct_paramsの1つ目の要素の名前が同じであること" do
        expect(products[0].name).to eq product_params[0][:name]
      end
      
      it "@productsとproduct_paramsの1つ目の要素の金額が同じであること" do
        expect(products[0].price).to eq product_params[0][:price]
      end
    end
  end

  # ▼単体テスト4 正常系(disp_productsメソッド)　※戻り値がnil
  describe ".disp_products" do
    context "メソッドが実行されたとき" do
      
    end
  end
end