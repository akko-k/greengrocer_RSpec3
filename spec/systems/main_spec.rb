# 総合テスト
describe ".grenngrocer_program" do
  let(:product_params) do
    [
      { name: "トマト", price: 100 },
      { name: "きゅうり", price: 200 },
      { name: "玉ねぎ", price: 300 },
      { name: "なす", price: 400 }
    ]
  end
  let(:greengrocer1) { Greengrocer.new(product_params) }
  let(:adding_product_params1) do
    [
      { name: "ごぼう", price: 250 },
      { name: "れんこん", price: 350 }
    ]
  end
  let(:products) { greengrocer1.products }
  let(:user) { User.new }
  let(:chosen_product) { user.chosen_product }

  context "chosen_productが最初の要素，quantity_of_productが4個のとき" do
    let(:correct_product_num_input) { "#{products.first.id}\n" }
    let(:quantity_of_product) { user.quantity_of_product }
    it "プログラムが最後まで動くこと" do
      # 商品を登録（adding_product_params1 の商品を追加）
      greengrocer1.register_product(adding_product_params1)
      # 商品を表示
      greengrocer1.disp_products
      # 商品を選択
      allow(ARGF).to receive(:gets).and_return correct_product_num_input
      user.choose_product(greengrocer1.products)
      # 個数を質問
      greengrocer1.ask_quantity(user.chosen_product)
      # 個数を決定
      allow(ARGF).to receive(:gets).and_return("4\n")
      user.decide_quantity
      # 金額金額を計算
      greengrocer1.calculate_charges(user)
      # expect(total_price.floor).to eq 400
    end
  end

  context "chosen_productが最後の要素，quantity_of_productが4個のとき" do
    let(:correct_product_num_input) { "#{products.last.id}\n" }
    let(:quantity_of_product) { user.quantity_of_product }
    it "プログラムが最後まで動くこと" do
      # 商品を登録（adding_product_params1 の商品を追加）
      greengrocer1.register_product(adding_product_params1)
      # 商品を表示
      greengrocer1.disp_products
      # 商品を選択
      allow(ARGF).to receive(:gets).and_return correct_product_num_input
      user.choose_product(greengrocer1.products)
      # 個数を質問
      greengrocer1.ask_quantity(user.chosen_product)
      # 個数を決定
      allow(ARGF).to receive(:gets).and_return "4\n"
      user.decide_quantity
      # 金額金額を計算
      greengrocer1.calculate_charges(user)
    end
  end

  context "chosen_productが最初の要素，quantity_of_productが5個のとき" do
    let(:correct_product_num_input) { "#{products.first.id}\n" }
    let(:quantity_of_product) { user.quantity_of_product }
    it "プログラムが最後まで動くこと" do
      # 商品を登録（adding_product_params1 の商品を追加）
      greengrocer1.register_product(adding_product_params1)
      # 商品を表示
      greengrocer1.disp_products
      # 商品を選択
      allow(ARGF).to receive(:gets).and_return correct_product_num_input
      user.choose_product(greengrocer1.products)
      # 個数を質問
      greengrocer1.ask_quantity(user.chosen_product)
      # 個数を決定
      allow(ARGF).to receive(:gets).and_return "5\n"
      user.decide_quantity
      # 金額金額を計算
      greengrocer1.calculate_charges(user)
    end
  end

  context "chosen_productが最後の要素，quantity_of_productが5個のとき" do
    let(:correct_product_num_input) { "#{products.last.id}\n" }
    let(:quantity_of_product) { user.quantity_of_product }
    it "プログラムが最後まで動くこと" do
      # 商品を登録（adding_product_params1 の商品を追加）
      greengrocer1.register_product(adding_product_params1)
      # 商品を表示
      greengrocer1.disp_products
      # 商品を選択
      allow(ARGF).to receive(:gets).and_return correct_product_num_input
      user.choose_product(greengrocer1.products)
      # 個数を質問
      greengrocer1.ask_quantity(user.chosen_product)
      # 個数を決定
      allow(ARGF).to receive(:gets).and_return "5\n"
      user.decide_quantity
      # 金額金額を計算
      greengrocer1.calculate_charges(user)
    end
  end
end