// ignore_for_file: inference_failure_on_collection_literal

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:juan_kite/model/category.dart';
import 'package:juan_kite/repository/kite_repository.dart';

void main() {
  late Dio dio;
  late DioAdapter adapter;
  late KiteRepository repository;

  setUp(() {
    dio = Dio();
    adapter = DioAdapter(dio: dio);
    repository = KiteRepository(dio: dio);
  });

  group('$KiteRepository loadCategories()', () {
    const categoriesUrl = '/kite.json';

    test('throws if the request fails', () {
      adapter.onGet(
        categoriesUrl,
        (server) => server.reply(403, <String, dynamic>{}),
      );

      expect(() => repository.loadCategories(), throwsException);
    });

    test('throws if it cannot parse the response', () {
      adapter.onGet(
        categoriesUrl,
        (server) => server.reply(200, 'not json!'),
      );

      expect(() => repository.loadCategories(), throwsException);
    });

    test('returns the expected list of categories', () async {
      adapter.onGet(
        categoriesUrl,
        (server) => server.reply(200, _mockCategoriesJson),
      );

      final categories = await repository.loadCategories();

      expect(categories.length, 2);
      expect(categories.first.name, 'one category');
      expect(categories.first.file, 'one.json');
      expect(categories.last.name, 'two category');
      expect(categories.last.file, 'two.json');
    });
  });

  group('$KiteRepository, loadCategoryContent()', () {
    final categoryUrl = '/${_mockCategory.file}';

    test('throws if the request fails', () {
      adapter.onGet(
        categoryUrl,
        (server) => server.reply(403, <String, dynamic>{}),
      );

      expect(
        () => repository.loadCategoryContent(category: _mockCategory),
        throwsException,
      );
    });

    test('throws if it cannot parse the response', () {
      adapter.onGet(
        categoryUrl,
        (server) => server.reply(200, 'not json!'),
      );

      expect(
        () => repository.loadCategoryContent(category: _mockCategory),
        throwsException,
      );
    });

    test('returns the expected category content', () async {
      adapter.onGet(
        categoryUrl,
        (server) => server.reply(200, _mockCategoryJson),
      );

      final content =
          await repository.loadCategoryContent(category: _mockCategory);

      expect(content.read, equals(1234));
      expect(content.clusters.length, equals(2));
      expect(content.clusters.first.title, equals('first title'));
      expect(
        content.clusters.first.shortSummary,
        equals('The first short summary'),
      );
      expect(content.clusters.last.title, equals('second title'));
      expect(
        content.clusters.last.shortSummary,
        equals('The second short summary'),
      );
    });
  });
}

final _mockCategory = Category(name: 'world', file: 'world.json');

const _mockCategoryJson = <String, dynamic>{
  'timestamp': 12345678,
  'read': 1234,
  'clusters': [
    {
      'title': 'first title',
      'short_summary': 'The first short summary',
      'talking_points': [],
      'perspectives': [],
      'timeline': [],
      'articles': [],
    },
    {
      'title': 'second title',
      'short_summary': 'The second short summary',
      'talking_points': [],
      'perspectives': [],
      'timeline': [],
      'articles': [],
    },
  ],
};

const _mockCategoriesJson = <String, dynamic>{
  'timestamp': 12345678,
  'categories': [
    {
      'name': 'one category',
      'file': 'one.json',
    },
    {
      'name': 'two category',
      'file': 'two.json',
    }
  ],
};
