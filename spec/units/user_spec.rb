RSpec.describe User do
  let(:user) { User.new }
  # 不要 ▼単体テスト 正常系（Userクラスのインスタンス生成）
  # ▼単体テスト5
  describe ".choose_product" do
    let(:products) do
      [
        Product.new({ name: "トマト", price: 100 }),
        Product.new({ name: "きゅうり", price: 200 })
      ]
    end
    let(:correct_product_id_input) { "#{products.first.id}\n" }
    let(:pronpt_re_enter_msg) { /#{products.first.id}から#{products.last.id}の番号から選んでください。/ }

    shared_examples "再入力を促すこと" do
      it do
        allow(ARGF).to receive(:gets).and_return wrong_product_id_input, correct_product_id_input
        expect { user.choose_product(products) }.to output(pronpt_re_enter_msg).to_stdout
      end
    end

    # ▼単体テスト5 正常系(choose_productメソッド)
    context "存在するid（productsの最初の要素のid）を入力したとき" do
      before do
        allow(ARGF).to receive(:gets).and_return correct_product_id_input
        user.choose_product(products)
      end
      it "@chosen_productのidとproductsの最初の要素のidが同じであること" do
        expect(user.chosen_product.id).to eq correct_product_id_input.to_i
      end
      it "@chosen_productの名前とproductsの最初の要素の名前が同じであること" do
        expect(user.chosen_product.name).to eq "トマト"
      end
      it "@chosen_productの金額とproductsの最初の要素の金額が同じであること" do
        expect(user.chosen_product.price).to eq 100
      end
    end

    # ▼単体テスト5 異常系(choose_productメソッド)※不正な値の入力に対応できているかどうかを確認
    context "商品一覧の最初のidより１小さい数の文字列を入力したとき" do
      let(:wrong_product_id_input) { "#{products.first.id - 1}\n" }
      it_behaves_like "再入力を促すこと"
    end

    context "商品一覧の最後のidより１大きい数の文字列を入力したとき" do
      let(:wrong_product_id_input) { "#{products.last.id + 1}\n" }
      it_behaves_like "再入力を促すこと"
    end

    context "数値以外の文字列を入力したとき" do
      let(:wrong_product_id_input) { "hoge\n" }
      it_behaves_like "再入力を促すこと"
    end
  end

  # ▼単体テスト7
  describe ".decide_quantity" do
    let(:correct_quantity_input) { "#{rand(1..100)}\n" }
    let(:pronpt_re_enter_msg) { /１個以上選んでください。/ }

    shared_examples "再入力を促すこと" do
      it do
        allow(ARGF).to receive(:gets).and_return wrong_quantity_input, correct_quantity_input
        expect { user.decide_quantity }.to output(pronpt_re_enter_msg).to_stdout
      end
    end

    # ▼単体テスト7 正常系(decide_quantityメソッド)
    context "1以上の数字を入力したとき" do
      it "@quantity_of_productと入力値が等しいこと" do
        allow(ARGF).to receive(:gets).and_return correct_quantity_input
        user.decide_quantity
        expect(user.quantity_of_product).to eq correct_quantity_input.to_i
      end
    end

    # ▼単体テスト7 異常系(decide_quantityメソッド)※不正な値の入力に対応できているかどうかを確認
    context "0を入力したとき" do
      let(:wrong_quantity_input) { "0\n" }
      it_behaves_like "再入力を促すこと"
    end

    context "負の数字を入力したとき" do
      let(:wrong_quantity_input) { "#{rand(-100..-1)}\n" }
      it_behaves_like "再入力を促すこと"
    end

    context "数字以外の文字列を入力したとき" do
      let(:wrong_quantity_input) { "hoge\n" }
      it_behaves_like "再入力を促すこと"
    end
  end
end