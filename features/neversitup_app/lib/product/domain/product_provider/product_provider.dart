import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:neversitup_app/product/domain/models/department/response/department.dart';
import 'package:neversitup_app/product/domain/models/product/response/product.dart';
import 'package:neversitup_app/product/domain/product_provider/event/product_event.dart';
import 'package:neversitup_app/product/domain/use_case/get_department_use_case.dart';
import 'package:neversitup_app/product/domain/use_case/get_product_use_case.dart';

import '../../../core/provider/base_provider.dart';

@LazySingleton()
class ProductProvider extends BaseProvider {
  final GetProductUseCase productUseCase;
  final GetDepartmentUseCase departmentUseCase;

  ProductProvider({
    required this.productUseCase,
    required this.departmentUseCase,
  });

  @override
  void onEvent<T>(T event) {
    switch (event) {
      case GetProductEvent():
        _getProduct(event.id);
        break;
      case GetDepartmentEvent():
        _getDepartment();
        break;
      case ClearProductEvent():
        _clearProduct();
        break;
      case ClearDepartmentEvent():
        _clearDepartment();
        break;
      default:
        break;
    }
  }

  final List<Product> products = [];
  StreamController<List<Product>>? productController;

  void _getProduct(String id) {
    products.clear();
    productController
      ?..sink
      ..add(products);
    productController ??= StreamController<List<Product>>.broadcast();

    productUseCase.invoke(id).listen((event) {
      products.addAll(event);
      productController
        ?..sink
        ..add(products);
    }, onDone: notifyListeners);
  }

  final List<Department> departments = [];
  StreamController<List<Department>>? departmentController;

  void _getDepartment() {
    departmentController ??= StreamController<List<Department>>.broadcast();

    departmentUseCase.invoke.listen(
      (event) {
        if (event.isEmpty) return;

        departments.addAll(event);
        departmentController
          ?..sink
          ..add(departments);

        _getProduct(departments.firstOrNull?.id ?? '1');
      },
      onDone: notifyListeners,
    );
  }

  /// product response data
  Stream<List<Product>>? get productStream => productController?.stream;

  /// department response data
  Stream<List<Department>>? get departmentStream =>
      departmentController?.stream;

  void close() {
    products.clear();
    productController?.close();
    productController = null;

    departments.clear();
    departmentController?.close();
    departmentController = null;
  }

  void _clearProduct() {
    products.clear();
    productController
      ?..sink
      ..add(products);
    notifyListeners();
  }

  void _clearDepartment() {
    departments.clear();
    departmentController
      ?..sink
      ..add(departments);
    notifyListeners();
  }
}
