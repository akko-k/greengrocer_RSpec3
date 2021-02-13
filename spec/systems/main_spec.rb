# # 総合テスト
# describe ".grenngrocer_program" do
#   let(:product_params) do
#     [
#       { name: "トマト", price: 100 },
#       { name: "きゅうり", price: 200 }
#     ]
#   end
#   let(:greengrocer) { Greengrocer.new(product_params) }
#   let(:products) { greengrocer.products }
#   let(:user) { User.new }
#   let(:chosen_product) { user.chosen_product }
#   let(:quantity_of_product) { user.quantity_of_product }
#   let(:thank_msg) { "お買い上げありがとうございました！" }

#   context "quantity_of_productが4個，chosen_productが最初の要素のとき" do
#     let(:quantity_of_product_input) { 4 }
#     let(:select_product_num_input) { "#{products.first.id}\n" }
#     let(:total_price_msg){ "合計金額は#{(chosen_product.price * quantity_of_product).floor }円です。" }
#     it "正しい合計金額を含む，期待した表示がされること" do
#       allow(ARGF).to receive(:gets).and_return select_product_num_input
#       user.choose_product(products)
#       allow(ARGF).to receive(:gets).and_return quantity_of_product_input
#       user.decide_quantity
#       greengrocer.calculate_charges(user)
#       expect{ greengrocer.calculate_charges(user) }.to output("#{total_price_msg}\n#{thank_msg}\n").to_stdout
#     end
#   end

#   context "quantity_of_productが4個，chosen_productが最後の要素のとき" do
#     let(:quantity_of_product_input) { 4 }
#     let(:select_product_num_input) { "#{products.last.id}\n" }
#     let(:total_price_msg){ "合計金額は#{(chosen_product.price * quantity_of_product).floor }円です。" }
#     it "正しい合計金額を含む，期待した表示がされること" do
#       allow(ARGF).to receive(:gets).and_return select_product_num_input
#       user.choose_product(products)
#       allow(ARGF).to receive(:gets).and_return quantity_of_product_input
#       user.decide_quantity
#       greengrocer.calculate_charges(user)
#       expect{ greengrocer.calculate_charges(user) }.to output("#{total_price_msg}\n#{thank_msg}\n").to_stdout
#     end
#   end

#   context "quantity_of_productが5個，chosen_productが最初の要素のとき" do
#     let(:quantity_of_product_input) { 5 }
#     let(:select_product_num_input) { "#{products.first.id}\n" }
#     let(:total_price_msg){ "合計金額は#{(chosen_product.price * quantity_of_product * 0.9).floor }円です。" }
#     let(:discount_msg) { "5個以上なので10％割引となります！" }
#     it "正しい合計金額を含む，期待した表示がされること" do
#       allow(ARGF).to receive(:gets).and_return select_product_num_input
#       user.choose_product(products)
#       allow(ARGF).to receive(:gets).and_return quantity_of_product_input
#       user.decide_quantity
#       greengrocer.calculate_charges(user)
#       expect{ greengrocer.calculate_charges(user) }.to output("#{discount_msg}\n#{total_price_msg}\n#{thank_msg}\n").to_stdout
#     end
#   end

#   context "quantity_of_productが5個，chosen_productが最後の要素のとき" do
#     let(:quantity_of_product_input) { 5 }
#     let(:select_product_num_input) { "#{products.last.id}\n" }
#     let(:total_price_msg){ "合計金額は#{(chosen_product.price * quantity_of_product * 0.9).floor }円です。" }
#     let(:discount_msg) { "5個以上なので10％割引となります！" }
#     it "正しい合計金額を含む，期待した表示がされること" do
#       allow(ARGF).to receive(:gets).and_return select_product_num_input
#       user.choose_product(products)
#       allow(ARGF).to receive(:gets).and_return quantity_of_product_input
#       user.decide_quantity
#       greengrocer.calculate_charges(user)
#       expect{ greengrocer.calculate_charges(user) }.to output("#{discount_msg}\n#{total_price_msg}\n#{thank_msg}\n").to_stdout
#     end
#   end
# end
