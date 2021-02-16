# 総合テスト
describe ".grenngrocer_program" do
  let(:product_params1) do
    [
      { name: "トマト", price: 100 },
      { name: "きゅうり", price: 200 },
      { name: "玉ねぎ", price: 300 },
      { name: "なす", price: 400 }
    ]
  end
  let(:greengrocer1) { Greengrocer.new(product_params1) }
  let(:adding_product_params1) do
    [
      { name: "ごぼう", price: 250 },
      { name: "れんこん", price: 350 }
    ]
  end
  let(:products) { greengrocer1.products }
  let(:user) { User.new }
  let(:discount_msg) { "5個以上なので10％割引となります！" }
  let(:thank_msg) { "お買い上げありがとうございました！" }

  context "chosen_productが最初の要素，quantity_of_productが4個のとき" do
    let(:correct_product_id_input) { "#{products.first.id}\n" }
    let(:total_price_msg){ "合計金額は400円です。" }

    it "正しい合計金額を含む，期待した表示がされること" do
      # 商品を登録（adding_product_params1 の商品を追加）
      greengrocer1.register_product(adding_product_params1)
      # 商品を表示
      greengrocer1.disp_products
      # 商品を選択
      allow(ARGF).to receive(:gets).and_return correct_product_id_input
      user.choose_product(greengrocer1.products)
      # 個数を質問
      greengrocer1.ask_quantity(user.chosen_product)
      # 個数を決定
      allow(ARGF).to receive(:gets).and_return("4\n")
      user.decide_quantity
      # 金額金額を計算
      expect{ greengrocer1.calculate_charges(user) }.to output("#{total_price_msg}\n#{thank_msg}\n").to_stdout
    end
  end

  context "chosen_productが最後の要素，quantity_of_productが4個のとき" do
    let(:correct_product_id_input) { "#{products.last.id}\n" }
    let(:total_price_msg){ "合計金額は1400円です。" }

    it "正しい合計金額を含む，期待した表示がされること" do
      # 商品を登録（adding_product_params1 の商品を追加）
      greengrocer1.register_product(adding_product_params1)
      # 商品を表示
      greengrocer1.disp_products
      # 商品を選択
      allow(ARGF).to receive(:gets).and_return correct_product_id_input
      user.choose_product(greengrocer1.products)
      # 個数を質問
      greengrocer1.ask_quantity(user.chosen_product)
      # 個数を決定
      allow(ARGF).to receive(:gets).and_return "4\n"
      user.decide_quantity
      # 金額金額を計算
      expect{ greengrocer1.calculate_charges(user) }.to output("#{total_price_msg}\n#{thank_msg}\n").to_stdout
    end
  end

  context "chosen_productが最初の要素，quantity_of_productが5個のとき" do
    let(:correct_product_id_input) { "#{products.first.id}\n" }
    let(:discount_total_price_msg){ "合計金額は450円です。" }

    it "割引した正しい合計金額を含む，期待した表示がされること" do
      # 商品を登録（adding_product_params1 の商品を追加）
      greengrocer1.register_product(adding_product_params1)
      # 商品を表示
      greengrocer1.disp_products
      # 商品を選択
      allow(ARGF).to receive(:gets).and_return correct_product_id_input
      user.choose_product(greengrocer1.products)
      # 個数を質問
      greengrocer1.ask_quantity(user.chosen_product)
      # 個数を決定
      allow(ARGF).to receive(:gets).and_return "5\n"
      user.decide_quantity
      # 金額金額を計算
      expect{ greengrocer1.calculate_charges(user) }.to output("#{discount_msg}\n#{discount_total_price_msg}\n#{thank_msg}\n").to_stdout
    end
  end

  context "chosen_productが最後の要素，quantity_of_productが5個のとき" do
    let(:correct_product_id_input) { "#{products.last.id}\n" }
    let(:discount_total_price_msg){ "合計金額は1575円です。" }
    
    it "割引した正しい合計金額を含む，期待した表示がされること" do
      # 商品を登録（adding_product_params1 の商品を追加）
      greengrocer1.register_product(adding_product_params1)
      # 商品を表示
      greengrocer1.disp_products
      # 商品を選択
      allow(ARGF).to receive(:gets).and_return correct_product_id_input
      user.choose_product(greengrocer1.products)
      # 個数を質問
      greengrocer1.ask_quantity(user.chosen_product)
      # 個数を決定
      allow(ARGF).to receive(:gets).and_return "5\n"
      user.decide_quantity
      # 金額金額を計算
      expect{ greengrocer1.calculate_charges(user) }.to output("#{discount_msg}\n#{discount_total_price_msg}\n#{thank_msg}\n").to_stdout
    end
  end
end