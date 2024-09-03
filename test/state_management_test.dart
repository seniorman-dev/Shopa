import 'package:flutter_test/flutter_test.dart';
import 'package:shopa/controller/repository/db_helper/db_service.dart';
import 'package:shopa/model/product_model.dart';




void main() {
  group('ProductController Tests', () {
    late DatabaseService productController;

    setUp(() {
      productController = DatabaseService();
    });

    test('Initial product list is empty', () {
      expect(productController.products.isEmpty, false);
    });

    test('Add product updates product list', () {
      // Act
      productController.addProduct(Product(id: '1', name: 'Test Product', description: '', image: '', category: '', imageList: [], price: 10.0));

      // Assert
      expect(productController.products.length, 5);
    });
  });
}
