import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neversitup_app/product/domain/models/department/response/department.dart';
import 'package:neversitup_app/product/domain/use_case/get_department_use_case.dart';

class MockGetDepartmentUseCase extends Mock implements GetDepartmentUseCase {}

void main(){
  late final MockGetDepartmentUseCase mUseCase;

  setUpAll((){
    mUseCase = MockGetDepartmentUseCase();
  });

  group('test department group', (){
    test('get department success case', ()async{

      when(()=> mUseCase.invoke).thenAnswer((_)=> Stream.value([Department()]));
      final data = await mUseCase.invoke.first;

      expect(data.length, 1);
      verify(()=> mUseCase.invoke).called(1);
    });

    test('get department empty body case', ()async{

      when(()=> mUseCase.invoke).thenAnswer((_)=> Stream.value([]));
      final data = await mUseCase.invoke.first;

      expect(data.length, 0);
      verify(()=> mUseCase.invoke).called(1);
    });
  });
}