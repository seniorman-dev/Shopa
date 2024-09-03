


class Product {
  final String id;
  final String name;
  final String description;
  final String image;
  final String category;
  final List<dynamic> imageList;
  final double price;

  Product({required this.id, required this.name, required this.description, required this.image, required this.category, required this.imageList, required this.price});

  // Factory method to create a User from a Firestore document snapshot
  factory Product.fromJson(Map<String, dynamic> data) {
    //final data = doc.data() as Map<String, dynamic> ?? {};
    return Product(
      id: data['id'] ?? '',
      name: data['name'] ?? '', // Provide default values if fields are missing (Null-Safety)
      description: data["description"] ?? '',
      image: data["image"] ?? '',
      category: data["category"] ?? "",
      imageList: data["image_list"] ?? [],
      price: data['price'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "image": image,
      "category": category,
      "image_list": imageList,
      "price": price
    };
  }
}
