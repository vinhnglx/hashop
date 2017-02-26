# Create the sample data

['mascara', 'makeup', 'tool', 'face'].each do |c|
  Category.create!(name: c)
end

20.times do |i|
  product = Product.new(name: "Sample Product #{i}", price: Random.rand(1000..5000), category: Category.all.sample)
  product.save!
end

