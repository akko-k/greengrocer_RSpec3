RSpec.describe User do
  let(:user) { User.new }
  # 不要 ▼単体テスト 正常系（Userクラスのインスタンス生成）
  # ▼単体テスト5
  describe ".choose_product" do   
    let(:product_params) do
      [
        { name: "トマト", price: 100 },
        { name: "きゅうり", price: 200 }
      ]
    end
    let(:greengrocer) { Greengrocer.new(product_params) }
    let(:products) { greengrocer.products }
    let(:correct_input) { "#{products.first.id}\n" }
    let(:pronpt_re_enter_msg) { /#{products.first.id}から#{products.last.id}の番号から選んでください。/ }

    shared_examples '再入力を促すこと' do
      it do
        allow(ARGF).to receive(:gets).and_return wrong_input, correct_input
        expect { user.choose_product(products) }.to output(pronpt_re_enter_msg).to_stdout
      end
    end

    # ▼単体テスト5 正常系(choose_productメソッド)
    context "存在するidを入力したとき" do
      
      it '@chosen_productとproduct_paramsの名前と同じであること' do
        allow(ARGF).to receive(:gets).and_return correct_input
        user.choose_product(products)
        expect(user.chosen_product.name).to eq "トマト"
      end

      it '@chosen_productとproduct_paramsの金額が同じであること' do
        allow(ARGF).to receive(:gets).and_return correct_input
        user.choose_product(products)
        expect(user.chosen_product.price).to eq 100
      end
    end

    # ▼単体テスト5 異常系(choose_productメソッド)※不正な値の入力に対応できているかどうかを確認
    context "商品一覧の最初のidより１小さい数の文字列を入力したとき" do
      let(:wrong_input) { "#{products.first.id - 1}\n" }
      it_behaves_like '再入力を促すこと'
    end

    context "商品一覧の最後のidより１大きい数の文字列を入力したとき" do
      let(:wrong_input) { "#{products.last.id + 1}\n" }
      it_behaves_like '再入力を促すこと'
    end
    
    context "数値以外の文字列を入力したとき" do
      let(:wrong_input) { "hoge\n" }
      it_behaves_like '再入力を促すこと'
    end
  end
  
  # ▼単体テスト7
  describe ".decide_quantity" do
    let(:correct_input) { "#{rand(1..100)}\n" }
    let(:pronpt_re_enter_msg) { /１個以上選んでください。/ }

    shared_examples "再入力を促すこと" do
      it do
        allow(ARGF).to receive(:gets).and_return wrong_input, correct_input
        expect { user.decide_quantity }.to output(pronpt_re_enter_msg).to_stdout
      end
    end

    # ▼単体テスト7 正常系(decide_quantityメソッド)
    context "1以上の数字を入力したとき" do
      
      it '@quantity_of_productと入力値が等しいこと' do
        allow(ARGF).to receive(:gets).and_return correct_input
        user.decide_quantity
        expect(user.quantity_of_product).to eq correct_input.to_i
      end
    end

    # ▼単体テスト7 異常系(decide_quantityメソッド)※不正な値の入力に対応できているかどうかを確認
    context "0を入力したとき" do
      let(:wrong_input) { "0\n" }
      it_behaves_like "再入力を促すこと"
    end

    context "負の数字を入力したとき" do
      let(:wrong_input) { "#{rand(-100..-1)}\n" }
      it_behaves_like "再入力を促すこと"
    end
    
    context "数字以外の文字列を入力したとき" do
      let(:wrong_input) { "hoge\n" }
      it_behaves_like "再入力を促すこと"
    end
  end
end