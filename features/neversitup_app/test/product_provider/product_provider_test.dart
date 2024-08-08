import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neversitup_app/product/domain/models/department/response/department.dart';
import 'package:neversitup_app/product/domain/models/product/response/product.dart';
import 'package:neversitup_app/product/domain/product_provider/event/product_event.dart';
import 'package:neversitup_app/product/domain/product_provider/product_provider.dart';

import '../usecase/get_department_usecase_test.dart';
import '../usecase/get_product_usecase_test.dart';

void main() {
  late final ProductProvider provider;
  late final MockGetProductUseCase productUseCase;
  late final MockGetDepartmentUseCase departmentUseCase;

  setUpAll(() {
    productUseCase = MockGetProductUseCase();
    departmentUseCase = MockGetDepartmentUseCase();

    provider = ProductProvider(
      productUseCase: productUseCase,
      departmentUseCase: departmentUseCase,
    );
  });

  group('test product provider', () {
    test('event get product test', () async {
      when(() => productUseCase.invoke('1'))
          .thenAnswer((_) => Stream.value([Product()]));
      provider.onEvent(GetProductEvent(id: '1'));

      final data = await provider.productStream?.first;

      expect(data?.length ?? 0, 1);

      verify(()=>  provider.onEvent(GetProductEvent(id: '1'))).called(1);
    });

    test('event get department test', () async {
      when(() => departmentUseCase.invoke)
          .thenAnswer((_) => Stream.value([Department()]));
      provider.onEvent(GetDepartmentEvent());

      final data = await provider.departmentStream?.first;

      expect(data?.length ?? 0, 1);

      verify(()=>  provider.onEvent(GetDepartmentEvent())).called(1);
    });

    ///next
  });
}
