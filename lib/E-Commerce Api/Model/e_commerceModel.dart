class ECommerceModel {
  late List<Product> products = [];

  ECommerceModel({required this.products});

  factory ECommerceModel.fromJson(Map m1) {
    return ECommerceModel(
        products:
            (m1['products'] as List).map((e) => Product.fromJson(e)).toList());
  }
}

class Product {
  late int id, stock;
  late double rating,price;
  late String title,
      description,
      category,
      warrantyInformation,
      shippingInformation,
      returnPolicy,
      availabilityStatus;
  late List tags = [];
  late List images = [];
  late List<Reviews> reviews = [];

  Product(
      {required this.id,
      required this.stock,
      required this.rating,
      required this.price,
      required this.title,
      required this.description,
      required this.category,
      required this.warrantyInformation,
      required this.shippingInformation,
      required this.availabilityStatus,
      required this.returnPolicy,
      required this.tags,
      required this.images,
      required this.reviews});

  factory Product.fromJson(Map m1) {
    return Product(
        id: m1['id'],
        stock: m1['stock'],
        rating: m1['rating'].toDouble(),
        price: m1['price'].toDouble(),
        title: m1['title'],
        description: m1['description'],
        category: m1['category'],
        warrantyInformation: m1['warrantyInformation'],
        shippingInformation: m1['shippingInformation'],
        availabilityStatus: m1['availabilityStatus'],
        returnPolicy: m1['returnPolicy'],
        tags: m1['tags'],
        images: m1['images'],
        reviews:
            (m1['reviews'] as List).map((e) => Reviews.fromJson(e)).toList());
  }
}

class Reviews {
  late int rating;

  Reviews({required this.rating});

  factory Reviews.fromJson(Map m1) {
    return Reviews(rating: m1['rating']);
  }
}
