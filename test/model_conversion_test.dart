import 'package:flutter_test/flutter_test.dart';
import 'package:shopa/model/product_model.dart';




void main() {
  group('Product Model Tests', () {
    test('Product fromJson works correctly', () {
      // Arrange
      final json = {
        'id': '123',
        'name': 'Product Name',
        'description': 'Product Description',
        'image': 'image_url',
        'category': 'Category',
        'image_list': ['image_url_1', 'image_url_2'],
        'price': 99.99
      };

      // Act
      final product = Product.fromJson(json);

      // Assert
      expect(product.id, '123');
      expect(product.name, 'Product Name');
      expect(product.price, 99.99);
    });

    test('Product toJson works correctly', () {
      // Arrange
      final product = Product(
        id: '123',
        name: 'Product Name',
        description: 'Product Description',
        image: 'image_url',
        category: 'Category',
        imageList: ['image_url_1', 'image_url_2'],
        price: 99.99,
      );

      // Act
      final json = product.toJson();

      // Assert
      expect(json['id'], '123');
      expect(json['name'], 'Product Name');
      expect(json['price'], 99.99);
    });
  });
}
