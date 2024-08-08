// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:neversitup_app/product/data/repository/product_repo_impl.dart'
    as _i439;
import 'package:neversitup_app/product/data/service/product_service.dart'
    as _i975;
import 'package:neversitup_app/product/domain/product_provider/product_provider.dart'
    as _i119;
import 'package:neversitup_app/product/domain/use_case/get_department_use_case.dart'
    as _i910;
import 'package:neversitup_app/product/domain/use_case/get_product_use_case.dart'
    as _i825;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i975.ProductService>(() => _i975.ProductService());
    gh.singleton<_i439.ProductRepoImpl>(
        () => _i439.ProductRepoImpl(service: gh<_i975.ProductService>()));
    gh.singleton<_i910.GetDepartmentUseCase>(
        () => _i910.GetDepartmentUseCase(repo: gh<_i439.ProductRepoImpl>()));
    gh.singleton<_i825.GetProductUseCase>(
        () => _i825.GetProductUseCase(repo: gh<_i439.ProductRepoImpl>()));
    gh.lazySingleton<_i119.ProductProvider>(() => _i119.ProductProvider(
          productUseCase: gh<_i825.GetProductUseCase>(),
          departmentUseCase: gh<_i910.GetDepartmentUseCase>(),
        ));
    return this;
  }
}
