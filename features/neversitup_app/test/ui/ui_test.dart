import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neversitup_app/neversitup_app.dart';
import 'package:neversitup_app/product/data/repository/product_repo_impl.dart';
import 'package:neversitup_app/product/data/service/product_service.dart';
import 'package:neversitup_app/product/domain/models/department/response/department.dart';
import 'package:neversitup_app/product/domain/models/product/response/product.dart';
import 'package:neversitup_app/product/domain/product_provider/event/product_event.dart';
import 'package:neversitup_app/product/domain/product_provider/product_provider.dart';
import 'package:provider/provider.dart';

import '../usecase/get_department_usecase_test.dart';
import '../usecase/get_product_usecase_test.dart';

class MockProductService extends Mock implements ProductService {}

class MockProductRepoImpl extends Mock implements ProductRepoImpl {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    GetIt.instance.registerSingleton<MockProductService>(MockProductService());
    GetIt.instance
        .registerSingleton<MockProductRepoImpl>(MockProductRepoImpl());
    GetIt.instance.registerLazySingleton<MockGetProductUseCase>(
        () => MockGetProductUseCase());
    GetIt.instance.registerSingleton<MockGetDepartmentUseCase>(
        MockGetDepartmentUseCase());
    GetIt.instance.registerSingleton(ProductProvider(
        productUseCase: GetIt.instance.get<MockGetProductUseCase>(),
        departmentUseCase: GetIt.instance.get<MockGetDepartmentUseCase>()));
  });

  tearDownAll(() {
    GetIt.instance.reset();
  });

  testWidgets('product screen ui test', (tester) async {
    const url =
        'https://www.paperflite.com/sites/default/files/inline-images/What%20is%20my%20LinkedIn%20URL%20%7C%20Paperflite%20%7C%20Finding%20LinkedIn%20URL%20in%20Mobile%20App%202.png';
    when(() => GetIt.instance.get<MockGetDepartmentUseCase>().invoke)
        .thenAnswer((_) => Stream.value([
              Department(
                id: '1',
                name: 'snake',
                imageUrl: url,
              )
            ]));
    GetIt.instance.get<MockGetDepartmentUseCase>().invoke;

    when(() => GetIt.instance.get<MockGetProductUseCase>().invoke('1'))
        .thenAnswer((_) => Stream.value([
              Product(
                id: '1',
                imageUrl: url,
                name: 'snake',
                departmentId: '1',
                type: '',
                price: '200.0',
                desc: 'description',
              ),
              Product(
                id: '2',
                imageUrl: url,
                name: 'snake',
                departmentId: '1',
                type: '',
                price: '200.0',
                desc: 'description',
              )
            ]));
    GetIt.instance.get<MockGetProductUseCase>().invoke('1');
    final provider = GetIt.instance.get<ProductProvider>();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => GetIt.I.get<ProductProvider>(),
          )
        ],
        child: const MaterialApp(
          home: NeversitupApp(),
        ),
      ),
    );

    final findCarouselTitle = find.text('Department Carousel');
    final findProductListName = find.text("Product list: ");
    final txt = find.text('Data not found');
    final findLoading = find.byType(CircularProgressIndicator);

    expect(findCarouselTitle, findsOneWidget);
    expect(findProductListName, findsOneWidget);
    expect(txt, findsNWidgets(1));
    expect(findLoading, findsNWidgets(1));

    ///show carousel list
    await tester.pump();

    final findCarouselList = find.byKey(const Key("carousel list"));
    final findProductListNameWithName = find.text("Product list: snake");
    provider.onEvent(GetProductEvent(id: '1'));

    ///update findProductListName
    await tester.pump();

    expect(findCarouselList, findsOneWidget);
    expect(findProductListNameWithName, findsOneWidget);

    ///update product list
    await tester.pump();
    final findProductList = find.byKey(const Key("product list"));
    expect(findProductList, findsOneWidget);

    ///click open dialog
    await tester.tap(find.byKey(
      const Key('product card 1'),
    ));

    await tester.pump();
    final findDialogInfo = find.byKey(const Key("product dialog"));
    final findTextClose = find.text('Close');
    expect(findDialogInfo, findsOneWidget);
    expect(findTextClose, findsOneWidget);
    
    ///click close dialog
    await tester.tap(find.byKey(const Key('close dialog')));
    await tester.pump();
    expect(findDialogInfo, findsNWidgets(0));
    
    ///
  });
}
