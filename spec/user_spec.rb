RSpec.describe User do
  # 不要 ▼単体テスト 正常系（Userクラスのインスタンス生成）

  # ▼単体テスト5 異常系(choose_productメソッド)※入力ミスに対応できているかどうかを確認（大きい整数，0，負の整数，文字列）
  # ▼単体テスト5 正常系(choose_productメソッド)
  describe ".choose_product" do
    context "商品を選ぶとき" do
      let(:user) { User.new }
      let(:product_params) do
        [
          { name: "トマト", price: 100},
          { name: "きゅうり", price: 200}
        ]
      end
      let(:greengrocer) {Greengrocer.new(product_params)}
      let(:products) { greengrocer.products }
      

      it "入力値が大きい整数の場合（かつ入力値のidが存在しない場合）、再入力を促すこと" do
        # user.stub(:gets) { 100 }
        # expect { user.choose_product(products) }
        #   .to output( "#{products.first.id}から#{products.last.id}の番号から選んでください。").to_stdout
        #   user.choose_product(products) if $0 == __FILE__
      end

      it "入力値が0の場合（かつ入力値のidが存在しない場合）、再入力を促すこと" do
      end

      it "入力値が負の整数の場合（かつ入力値のidが存在しない場合）、再入力を促すこと" do
      end

      it "入力値が文字列の場合、再入力を促すこと" do
      end

      it "入力値のidがが存在する場合、@chosen_productの@idが一致すること" do
      end

      it "入力値のidがが存在する場合、@chosen_productの@nameが一致すること" do
      end

      it "入力値のidがが存在する場合、@chosen_productの@priceが一致すること" do
      end
    end
  end
end
