RSpec.describe Product do
  # ▼単体テスト1 正常系（Productクラスのインスタンス生成）
  describe ".initialize" do
    context "インスタンスが生成されたとき" do
      let(:product_params) { { name: "トマト", price: 100 } }
      let(:product) { Product.new(product_params) }
      let!(:base_id) { Product.class_variable_get("@@count") }

      it "@@countが1増加すること" do
        expect { Product.new(product_params) }
          .to change { Product.class_variable_get("@@count") }.by(1)
      end

      it "@idがインスタンス生成前の@@count+1の値に等しいこと" do
        expect(product.id).to eq base_id + 1
      end

      it "@nameがproduct_paramsの名前と等しいこと" do
        expect(product.name).to eq "トマト"
      end

      it "@priceがproduct_paramsの金額と等しいこと" do
        expect(product.price).to eq 100
      end
    end
  end
end
