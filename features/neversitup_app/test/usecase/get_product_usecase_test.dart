import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neversitup_app/product/domain/models/product/response/product.dart';
import 'package:neversitup_app/product/domain/use_case/get_product_use_case.dart';

class MockGetProductUseCase extends Mock implements GetProductUseCase {}

void main() {
  late final MockGetProductUseCase mUseCase;
  setUpAll(() {
    mUseCase = MockGetProductUseCase();
  });

  test('test get product success case', () async {
    final data = [Product()];
    when(()=>mUseCase.invoke("1")).thenAnswer((_) => Stream.value(data));

    final response = await mUseCase.invoke("1").first;
    expect(response.length, data.length);
    verify(()=>mUseCase.invoke("1")).called(1);
  });

  test('test get product case body empty', () async {
    final List<Product> data = [];
    when(()=>mUseCase.invoke("1")).thenAnswer((_) => Stream.value(data));

    final response = await mUseCase.invoke("1").first;
    expect(response.length, data.length);
    verify(()=>mUseCase.invoke("1")).called(1);
  });
}
