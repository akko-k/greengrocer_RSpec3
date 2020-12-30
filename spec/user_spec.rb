RSpec.describe User do
  # 不要 ▼単体テスト 正常系（Userクラスのインスタンス生成）

  # ▼単体テスト5 異常系(choose_productメソッド)※入力ミスに対応できているかどうかを確認（大きい整数，0，負の整数，文字列）
  describe ".choose_product" do
    context "商品を選ぶとき" do
      let(:user) { User.new }
      let(:products) do
        [
          { name: "トマト", price: 100},
          { name: "きゅうり", price: 200}
        ]
      end
      let(:select_product_num) { gets.to_i }
    end
  end
end