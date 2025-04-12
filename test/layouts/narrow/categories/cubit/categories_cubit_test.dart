import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:juan_kite/layouts/narrow/categories/cubit/categories_cubit.dart';
import 'package:juan_kite/model/category.dart' as category;
import 'package:juan_kite/repository/kite_repository.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository extends Mock implements KiteRepository {}

void main() {
  group(CategoriesCubit, () {
    late CategoriesCubit cubit;
    late KiteRepository mockRepository;

    setUp(() {
      mockRepository = _MockRepository();
      cubit = CategoriesCubit(repository: mockRepository);
    });

    test('initial state is $CategoriesInitial', () {
      expect(cubit.state, isA<CategoriesInitial>());
    });

    blocTest<CategoriesCubit, CategoriesState>(
      'emits loading and error when the repository throws',
      setUp: () {
        when(mockRepository.loadCategories).thenThrow(Exception(''));
      },
      build: () => cubit,
      act: (_) => cubit.loadCategories(),
      expect: () => [isA<CategoriesLoading>(), isA<CategoriesError>()],
    );

    blocTest<CategoriesCubit, CategoriesState>(
      'emits loading and loaded when loading categories',
      setUp: () {
        when(mockRepository.loadCategories).thenAnswer(
          (_) async => [],
        );
      },
      build: () => cubit,
      act: (_) => cubit.loadCategories(),
      expect: () => [isA<CategoriesLoading>(), isA<CategoriesLoaded>()],
    );

    blocTest<CategoriesCubit, CategoriesState>(
      'emits loaded categories in alphabetical order',
      setUp: () {
        when(mockRepository.loadCategories).thenAnswer(
          (_) async => _mockCategories,
        );
      },
      build: () => cubit,
      act: (_) => cubit.loadCategories(),
      verify: (_) {
        final categories = (cubit.state as CategoriesLoaded).categories;

        expect(categories, hasLength(2));
        expect(categories.first.name, equals('A category'));
        expect(categories.first.file, equals('a.json'));
        expect(categories.last.name, equals('B category'));
        expect(categories.last.file, equals('b.json'));
      },
    );
  });
}

final _mockCategories = [
  category.Category(name: 'B category', file: 'b.json'),
  category.Category(name: 'A category', file: 'a.json'),
];
