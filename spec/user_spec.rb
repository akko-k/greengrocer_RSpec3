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
    # shared_exampleをここで使うか要確認
    shared_examples '再入力を促すこと' do
      it { expect { user.choose_product(products) }.to output(pronpt_re_enter_msg).to_stdout }
    end
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

    # ▼単体テスト5 異常系(choose_productメソッド)※不正な値の入力に対応できているかどうかを確認
    context "商品一覧の最初のidより１小さい数の文字列を入力したとき" do
      let(:small_wrong_input) { "#{products.first.id - 1}\n" }
      allow(ARGF).to receive(:gets).and_return small_wrong_input, correct_input
      it_behaves_like '再入力を促すこと'
    end

    context "商品一覧の最後のidより１大きい数字を入力したとき" do
      let(:big_wrong_input) { "#{products.last.id + 1}\n" }

      it '再入力を促すこと' do
        allow(ARGF).to receive(:gets).and_return big_wrong_input, correct_input
        expect { user.choose_product(products) }.to output(pronpt_re_enter_msg).to_stdout
      end
    end

    context "数字以外の文字列を入力したとき" do
      let(:string_wrong_input) { "hoge\n" }

      it '再入力を促すこと' do
        allow(ARGF).to receive(:gets).and_return string_wrong_input, correct_input
        expect { user.choose_product(products) }.to output(pronpt_re_enter_msg).to_stdout
      end
    end

  end

  describe ".decide_quantity" do
    let(:user) { User.new }
    let(:pronpt_re_enter_msg) { /１個以上選んでください。/ }
    let(:correct_input) { rand(1..1000) }
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
      let(:zero_wrong_input) { "0" }

      it '再入力を促すこと' do
        allow(ARGF).to receive(:gets).and_return zero_wrong_input, correct_input
        expect { user.decide_quantity }.to output(pronpt_re_enter_msg).to_stdout
      end
    end

    context "負の数字を入力したとき" do
      let(:negative_integer_wrong_input) { rand(-1000...0) }

      it '再入力を促すこと' do
        allow(ARGF).to receive(:gets).and_return negative_integer_wrong_input, correct_input
        expect { user.decide_quantity }.to output(pronpt_re_enter_msg).to_stdout
      end
    end
    
    context "数字以外の文字列を入力したとき" do
      let(:string_wrong_input) { "hoge\n" }

      it '再入力を促すこと' do
        allow(ARGF).to receive(:gets).and_return string_wrong_input, correct_input
        expect { user.decide_quantity }.to output(pronpt_re_enter_msg).to_stdout
      end
    end
  end
end