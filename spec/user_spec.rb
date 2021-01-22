RSpec.describe User do
  # 不要 ▼単体テスト 正常系（Userクラスのインスタンス生成）

  describe ".choose_product" do
    let(:product_params) do
      [
        { name: "トマト", price: 100 },
        { name: "きゅうり", price: 200 }
      ]
    end
    let(:greengrocer) { Greengrocer.new(product_params) }
    let(:products) { greengrocer.products }
    let(:user) { User.new }
    let(:correct_input) { "#{products.first.id}\n" }
    let(:pronpt_re_enter_msg) { /#{products.first.id}から#{products.last.id}の番号から選んでください。/ }
    # ▼単体テスト5 正常系(choose_productメソッド)
    context "存在するidを入力したとき" do
      
      it '@chosen_productとproduct_paramsの名前と同じであること' do
        allow(ARGF).to receive(:gets).and_return correct_input
        user.choose_product(products)
        expect(user.chosen_product.name).to eq product_params[0][:name]
      end

      it '@chosen_productとproduct_paramsの金額が同じであること' do
        allow(ARGF).to receive(:gets).and_return correct_input
        user.choose_product(products)
        expect(user.chosen_product.price).to eq product_params[0][:price]
      end
    end

    # ▼単体テスト5 異常系(choose_productメソッド)※入力ミスに対応できているかどうかを確認（大きい整数，0，負の整数，文字列）
    context "idとして存在しない大きい整数を入力したとき" do
      let(:wrong_input) { "100\n" }
      it '再入力を促すこと' do
        allow(ARGF).to receive(:gets).and_return wrong_input, correct_input
        expect { user.choose_product(products) }.to output(pronpt_re_enter_msg).to_stdout
      end
    end

    context "idとして存在しない0を入力したとき" do
      let(:wrong_input) { "0\n" }
      it '再入力を促すこと' do
        allow(ARGF).to receive(:gets).and_return wrong_input, correct_input
        expect { user.choose_product(products) }.to output(pronpt_re_enter_msg).to_stdout
      end
    end

    context "idとして存在しない負の整数を入力したとき" do
      let(:wrong_input) { "-1\n" }
      it '再入力を促すこと' do
        allow(ARGF).to receive(:gets).and_return wrong_input, correct_input
        expect { user.choose_product(products) }.to output(pronpt_re_enter_msg).to_stdout
      end
    end

    context "文字列を入力したとき" do
      let(:wrong_input) { "hoge\n" }
      it '再入力を促すこと' do
        allow(ARGF).to receive(:gets).and_return wrong_input, correct_input
        expect { user.choose_product(products) }.to output(pronpt_re_enter_msg).to_stdout
      end
    end

  end
end