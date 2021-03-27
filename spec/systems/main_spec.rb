# 総合テスト
describe ".grenngrocer_program" do
  let(:product_params1) do
    [
      { name: "トマト", price: 100 },
      { name: "きゅうり", price: 200 },
      { name: "玉ねぎ", price: 300 },
      { name: "なす", price: 400 },
    ]
  end
  let(:greengrocer1) { Greengrocer.new(product_params1) }
  let(:adding_product_params1) do
    [
      { name: "ごぼう", price: 250 },
      { name: "れんこん", price: 350 },
    ]
  end
  let(:products) { greengrocer1.products }
  let(:user) { User.new }
  let(:thank_msg) { "お買い上げありがとうございました！" }

  shared_examples "正しい合計金額を含む，期待した表示がされること" do
    it "正しい合計金額を含む，期待した表示がされること" do
      # 商品を登録（adding_product_params1 の商品を追加）
      greengrocer1.register_product(adding_product_params1)
      # 商品を表示
      greengrocer1.disp_products
      # 商品を選択
      allow(ARGF).to receive(:gets).and_return correct_product_id_input
      user.choose_product(products)
      # 個数を質問
      greengrocer1.ask_quantity(user.chosen_product)
      # 個数を決定
      allow(ARGF).to receive(:gets).and_return correct_quantity_input
      user.decide_quantity
      # 合計金額を計算すると期待する結果になること
      expect { greengrocer1.calculate_charges(user) }.to output("#{total_price_msg}\n#{thank_msg}\n").to_stdout
    end
  end

  shared_examples "割引した正しい合計金額を含む，期待した表示がされること" do
    it do
      # 商品を登録（adding_product_params1 の商品を追加）
      greengrocer1.register_product(adding_product_params1)
      # 商品を表示
      greengrocer1.disp_products
      # 商品を選択
      allow(ARGF).to receive(:gets).and_return correct_product_id_input
      user.choose_product(products)
      # 個数を質問
      greengrocer1.ask_quantity(user.chosen_product)
      # 個数を決定
      allow(ARGF).to receive(:gets).and_return correct_quantity_input
      user.decide_quantity
      # 合計金額を計算すると期待する結果になること
      expect { greengrocer1.calculate_charges(user) }.to output("#{discount_msg}\n#{discount_total_price_msg}\n#{thank_msg}\n").to_stdout
    end
  end

  context "最初の番号の商品を4個買うとき" do
    let(:correct_product_id_input) { "#{products.first.id}\n" }
    let(:correct_quantity_input) { "4\n" }
    let(:total_price_msg) { "合計金額は400円です。" }
    it_behaves_like "正しい合計金額を含む，期待した表示がされること"
  end

  context "最後の番号の商品を4個買うとき" do
    let(:correct_product_id_input) { "#{products.last.id}\n" }
    let(:correct_quantity_input) { "4\n" }
    let(:total_price_msg) { "合計金額は1400円です。" }
    it_behaves_like "正しい合計金額を含む，期待した表示がされること"
  end

  context "最初の番号の商品を5個買うとき" do
    let(:correct_product_id_input) { "#{products.first.id}\n" }
    let(:correct_quantity_input) { "5\n" }
    let(:discount_msg) { "5個以上なので10％割引となります！" }
    let(:discount_total_price_msg) { "合計金額は450円です。" }
    it_behaves_like "割引した正しい合計金額を含む，期待した表示がされること"
  end

  context "最後の番号の商品を5個買うとき" do
    let(:correct_product_id_input) { "#{products.last.id}\n" }
    let(:correct_quantity_input) { "5\n" }
    let(:discount_msg) { "5個以上なので10％割引となります！" }
    let(:discount_total_price_msg) { "合計金額は1575円です。" }
    it_behaves_like "割引した正しい合計金額を含む，期待した表示がされること"
  end
end
