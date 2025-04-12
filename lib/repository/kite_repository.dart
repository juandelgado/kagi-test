import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:juan_kite/model/categories.dart';
import 'package:juan_kite/model/category.dart';
import 'package:juan_kite/model/category_content.dart';

class KiteRepository {
  KiteRepository({Dio? dio}) {
    _dio = dio ?? Dio(BaseOptions(baseUrl: 'https://kite.kagi.com'));
  }

  late final Dio _dio;

  Future<List<Category>> loadCategories() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/kite.json');
      final categories = Categories.fromJson(response.data!);
      return categories.categories;
    } catch (e) {
      log('Error while loding Kite categories');
      log(e.toString());
      rethrow;
    }
  }

  Future<CategoryContent> loadCategoryContent({
    required Category category,
  }) async {
    try {
      final response =
          await _dio.get<Map<String, dynamic>>('/${category.file}');
      return CategoryContent.fromJson(response.data!);
    } catch (e) {
      log('Error while loading category content');
      log(e.toString());
      rethrow;
    }
  }
}
