FactoryBot.define do
  factory :post do
    before(:create) do |images|
      post.images.create("#{Rails.root}/spec/fixture/image_1.jpg")
    end
    title { 'test title' }
    content { 'test content' }
  end
end