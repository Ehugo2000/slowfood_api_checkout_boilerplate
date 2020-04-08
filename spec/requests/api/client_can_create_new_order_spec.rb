RSpec.describe Api::OrdersController, type: :request do
  let!(:product_1) { create(:product, name: "Pizza") }
  let!(:product_2) { create(:product, name: "Kebab") }

  before do
    post "/api/orders", params: { id: product_1.id }
    @order = Order.last
  end

  it "responds with success message" do
    post "/api/orders", params: { id: product_1.id }
    expect(JSON.parse(response.body)["message"]).to eq "The product has been added to your order"
  end

  it 'adds another product to order if param "order_id" is present' do
    post '/api/orders', params: {id: product_2.id, order_id: @order.id}
    expect(@order.order_items.count).to eq 2
  end
end
