for i in 1..5
  category = Category.create(name: "Category" + i.to_s, tag:0)

  for j in 1..5
    index_product = i * 10 + j
    product = Product.create(name: 'Product ' + index_product.to_s, content: 'Content here.', category_id: category.id)
  end

end