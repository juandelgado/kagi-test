import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:juan_kite/model/category.dart';
import 'package:juan_kite/model/category_content.dart';
import 'package:juan_kite/model/cluster.dart';
import 'package:juan_kite/repository/kite_repository.dart';

part 'wide_screen_state.dart';

class WideScreenCubit extends Cubit<WideScreenState> {
  WideScreenCubit({KiteRepository? repository}) : super(WideScreenInitial()) {
    _repository = repository ?? KiteRepository();
  }

  late final KiteRepository _repository;

  Future<void> loadCategories() async {
    emit(WideScreenCategoriesLoading());

    try {
      final categories = await _repository.loadCategories();
      categories.sort(
        (a, b) => a.name.compareTo(b.name),
      );

      emit(WideScreenCategoriesLoaded(categories: categories));
    } catch (e) {
      log('Error while loading categories');
      log(e.toString());
      emit(WideScreenCategoriesError());
    }
  }

  Future<void> loadCategory({required Category category}) async {
    emit(WideScreenCategoryLoading());

    try {
      final content = await _repository.loadCategoryContent(category: category);
      emit(WideScreenCategoryLoaded(category: category, content: content));
    } catch (e) {
      log('Error while loading category');
      log(e.toString());
      emit(WideScreenCategoryError(category: category));
    }
  }

  // NOTE: no need to load anything, this is "just" emitting a new state
  // in order to redraw the widget tree accordingly
  Future<void> loadArticle({required Cluster cluster}) async {
    emit(WideScreenArticleSelected(cluster: cluster));
  }
}
