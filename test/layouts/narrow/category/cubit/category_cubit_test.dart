import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:juan_kite/layouts/narrow/category/cubit/category_cubit.dart';
import 'package:juan_kite/model/category.dart';
import 'package:juan_kite/model/category_content.dart';
import 'package:juan_kite/model/cluster.dart';
import 'package:juan_kite/repository/kite_repository.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository extends Mock implements KiteRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(Category(name: 'default', file: 'default.json'));
  });

  group(CategoryCubit, () {
    late CategoryCubit cubit;
    late KiteRepository mockRepository;

    setUp(() {
      mockRepository = _MockRepository();
      cubit = CategoryCubit(repository: mockRepository);
    });

    test('initial state is $CategoryInitial', () {
      expect(cubit.state, isA<CategoryInitial>());
    });

    blocTest<CategoryCubit, CategoryState>(
      'emits loading and error when the repository throws',
      setUp: () {
        when(
          () => mockRepository.loadCategoryContent(
            category: any(named: 'category', that: isA<Category>()),
          ),
        ).thenThrow(Exception(''));
      },
      build: () => cubit,
      act: (_) => cubit.load(category: _mockCategory),
      expect: () => [isA<CategoryLoading>(), isA<CategoryError>()],
    );

    blocTest<CategoryCubit, CategoryState>(
      'emits loading and loaded when loading content',
      setUp: () {
        when(
          () => mockRepository.loadCategoryContent(
            category: any(named: 'category', that: isA<Category>()),
          ),
        ).thenAnswer((_) async => _mockContent);
      },
      build: () => cubit,
      act: (_) => cubit.load(category: _mockCategory),
      expect: () => [isA<CategoryLoading>(), isA<CategoryLoaded>()],
    );

    blocTest<CategoryCubit, CategoryState>(
      'emits loaded category content',
      setUp: () {
        when(
          () => mockRepository.loadCategoryContent(
            category: any(named: 'category', that: isA<Category>()),
          ),
        ).thenAnswer((_) async => _mockContent);
      },
      build: () => cubit,
      act: (_) => cubit.load(category: _mockCategory),
      verify: (_) {
        final content = (cubit.state as CategoryLoaded).content;

        expect(content.timestamp, equals(1234));
        expect(content.read, equals(4321));
        expect(content.clusters, hasLength(1));
        expect(content.clusters.first.title, equals('juan cluster'));
        expect(
          content.clusters.first.shortSummary,
          equals('juan short summary'),
        );
      },
    );
  });
}

final _mockCategory = Category(name: 'spain', file: 'spain.json');

final _mockContent = CategoryContent(
  timestamp: 1234,
  read: 4321,
  clusters: [
    Cluster(
      title: 'juan cluster',
      shortSummary: 'juan short summary',
      talkingPoints: [],
      perspectives: [],
      timeline: [],
      articles: [],
    ),
  ],
);
