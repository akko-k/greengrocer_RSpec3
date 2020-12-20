RSpec.describe Greengrocer do
    # ▼単体テスト2 正常系（Greengrocerクラスのインスタンス生成）
    describe ".initialize" do
      context "インスタンスが生成されたとき" do
        let(:product_params) { [{ name: "トマト", price: 100 },{ name: "きゅうり", price: 200 }] }

        it "@productsの数とproduct_paramsの要素の数が同じであること" do
          greengrocer = Greengrocer.new(product_params)
          expect(greengrocer.products.size).to eq product_params.size
        end

        it "@productsとproduct_paramsの名前が同じであること" do
          greengrocer = Greengrocer.new(product_params)
          expect(greengrocer.products.first.name).to eq product_params[0][:name]
        end

        it "@productsとproduct_paramsの金額が同じであること" do
          greengrocer = Greengrocer.new(product_params)
          expect(greengrocer.products.first.price).to eq product_params[0][:price]
        end
      end
    end
  end