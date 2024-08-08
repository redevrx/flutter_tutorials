import 'package:injectable/injectable.dart';
import 'package:neversitup_app/product/data/repository/product_repo_impl.dart';

import '../models/department/response/department.dart';

@Singleton()
class GetDepartmentUseCase {
  final ProductRepoImpl _repo;

  GetDepartmentUseCase({required ProductRepoImpl repo}) : _repo = repo;

  Stream<List<Department>> get invoke => _repo.getDepartment();
}
