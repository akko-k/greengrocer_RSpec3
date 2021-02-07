RSpec.describe Product do
  # ▼単体テスト1 正常系（Productクラスのインスタンス生成）
  describe ".initialize" do
    context "インスタンスが生成されたとき" do
      let(:product_params) { { name: "トマト", price: 100 } }

      it "@@countが1増加すること" do
        expect { Product.new(product_params) }
          .to change { Product.class_variable_get('@@count') }.by(1)
      end

      it "idが正しく振られること" do
        got_id = Product.class_variable_get('@@count')
        product = Product.new(product_params)
        expect(product.id).to eq got_id + 1
      end 

      it "名前の値が正しいこと" do
        product = Product.new(product_params)
        expect(product.name).to eq "トマト"
      end
      
      it "金額の値が正しいこと" do
        product = Product.new(product_params)
        expect(product.price).to eq 100
      end
    end
  end
end