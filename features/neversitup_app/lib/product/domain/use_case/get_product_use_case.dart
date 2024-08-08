import 'package:injectable/injectable.dart';
import 'package:neversitup_app/product/data/repository/product_repo_impl.dart';

import '../models/product/response/product.dart';

@Singleton()
class GetProductUseCase {
  final ProductRepoImpl _repo;

  GetProductUseCase({required ProductRepoImpl repo}) : _repo = repo;

  Stream<List<Product>> invoke(String productId) => _repo.getProduct(productId);
}
