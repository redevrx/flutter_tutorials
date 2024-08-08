import 'package:injectable/injectable.dart';
import 'package:neversitup_app/core/network/app_client.dart';
import 'package:neversitup_app/product/domain/endpoint.dart';
import 'package:neversitup_app/product/domain/models/department/response/department.dart';
import 'package:neversitup_app/product/domain/models/product/response/product.dart';

@Singleton()
class ProductService {
  final _mClient = AppClient.instance;

  Stream<List<Product>> getProduct(String productId) {
    return _mClient.getStream(
      endpoint: "$kDepartmentEndpoint/$productId/$kProductEndpoint",
      success: Product.fromJsons,
    );
  }

  Stream<List<Department>> getDepartment() {
    return _mClient.getStream(
      endpoint: kDepartmentEndpoint,
      success: Department.fromJsons,
    );
  }
}
