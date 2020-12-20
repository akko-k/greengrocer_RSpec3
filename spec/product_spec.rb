RSpec.describe Product do
  # ▼単体テスト1 正常系（Productクラスのインスタンス生成）
  describe ".initialize" do
    context "インスタンスが生成されたとき" do
      let(:params) { { name: "トマト", price: 100 } }

      it "@@countが1増加すること" do
        expect { Product.new(params) }
          .to change { Product.class_variable_get('@@count') }.by(1)
      end

      it "idが正しく振られること" do
        count = Product.class_variable_get('@@count')
        product = Product.new(params)
        expect(product.id).to eq count + 1
      end 

      it "名前の値が正しいこと" do
        product = Product.new(params)
        expect(product.name).to eq params[:name]
      end
      
      it "金額の値が正しいこと" do
        product = Product.new(params)
        expect(product.price).to eq params[:price]
      end
    end
  end
end