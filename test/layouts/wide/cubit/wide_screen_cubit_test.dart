import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:juan_kite/layouts/wide/cubit/wide_screen_cubit.dart';
import 'package:juan_kite/model/category.dart';
import 'package:juan_kite/model/cluster.dart';
import 'package:juan_kite/repository/kite_repository.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository extends Mock implements KiteRepository {}

void main() {
  group(WideScreenCubit, () {
    late WideScreenCubit cubit;
    late KiteRepository mockRepository;

    setUp(() {
      registerFallbackValue(Category(name: 'default', file: 'default.json'));
      mockRepository = _MockRepository();
      cubit = WideScreenCubit(repository: mockRepository);
    });

    test('initial state is $WideScreenInitial', () {
      expect(cubit.state, isA<WideScreenInitial>());
    });

    blocTest<WideScreenCubit, WideScreenState>(
      'emits loaded article',
      build: () => cubit,
      act: (_) => cubit.loadArticle(cluster: _mockCluster),
      verify: (_) {
        final cluster = (cubit.state as WideScreenArticleSelected).cluster;

        expect(cluster.title, equals(_mockCluster.title));
        expect(cluster.shortSummary, equals(_mockCluster.shortSummary));
        // etc
      },
    );

    blocTest<WideScreenCubit, WideScreenState>(
      'emits loading and error when the repository throws loading categories',
      setUp: () {
        when(
          () => mockRepository.loadCategories(),
        ).thenThrow(Exception(''));
      },
      build: () => cubit,
      act: (_) => cubit.loadCategories(),
      expect: () => [
        isA<WideScreenCategoriesLoading>(),
        isA<WideScreenCategoriesError>(),
      ],
    );

    blocTest<WideScreenCubit, WideScreenState>(
      'emits loading and error when the repository throws loading categories',
      setUp: () {
        when(
          () => mockRepository.loadCategories(),
        ).thenThrow(Exception(''));
      },
      build: () => cubit,
      act: (_) => cubit.loadCategories(),
      expect: () => [
        isA<WideScreenCategoriesLoading>(),
        isA<WideScreenCategoriesError>(),
      ],
    );

    blocTest<WideScreenCubit, WideScreenState>(
      'emits loading and loaded when loading categories',
      setUp: () {
        when(
          () => mockRepository.loadCategories(),
        ).thenAnswer(
          (_) async => [],
        );
      },
      build: () => cubit,
      act: (_) => cubit.loadCategories(),
      expect: () => [
        isA<WideScreenCategoriesLoading>(),
        isA<WideScreenCategoriesLoaded>(),
      ],
    );

    blocTest<WideScreenCubit, WideScreenState>(
      'emits loaded categories',
      setUp: () {
        when(
          () => mockRepository.loadCategories(),
        ).thenAnswer(
          (_) async => _mockCategories,
        );
      },
      build: () => cubit,
      act: (_) => cubit.loadCategories(),
      verify: (_) {
        final categories =
            (cubit.state as WideScreenCategoriesLoaded).categories;

        expect(categories, hasLength(2));
        expect(categories.first.name, equals('X category'));
        expect(categories.first.file, equals('x.json'));
        expect(categories.last.name, equals('Z category'));
        expect(categories.last.file, equals('z.json'));
      },
    );

    // here would go similar tests but for loadCategory()
  });
}

final _mockCluster = Cluster(
  title: 'title',
  shortSummary: 'short summary',
  talkingPoints: [],
  perspectives: [],
  timeline: [],
  articles: [],
);

final _mockCategories = [
  Category(name: 'Z category', file: 'z.json'),
  Category(name: 'X category', file: 'x.json'),
];
