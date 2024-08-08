import 'package:neversitup_app/product/domain/models/department/response/department.dart';
import 'package:neversitup_app/product/domain/models/product/response/product.dart';

mixin ProductRepository {
  Stream<List<Product>> getProduct(String productId);

  Stream<List<Department>> getDepartment();
}
