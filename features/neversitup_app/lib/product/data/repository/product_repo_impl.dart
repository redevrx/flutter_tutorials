import 'package:injectable/injectable.dart';
import 'package:neversitup_app/product/data/service/product_service.dart';
import 'package:neversitup_app/product/domain/models/department/response/department.dart';
import 'package:neversitup_app/product/domain/models/product/response/product.dart';
import 'package:neversitup_app/product/domain/repository/product_repository.dart';

@Singleton()
class ProductRepoImpl with ProductRepository {
  final ProductService _service;

  ProductRepoImpl({required ProductService service}) : _service = service;

  @override
  Stream<List<Department>> getDepartment() => _service.getDepartment();

  @override
  Stream<List<Product>> getProduct(String productId) =>
      _service.getProduct(productId);
}
