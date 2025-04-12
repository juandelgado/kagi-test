import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:juan_kite/model/category.dart';
import 'package:juan_kite/model/category_content.dart';
import 'package:juan_kite/repository/kite_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({KiteRepository? repository}) : super(CategoryInitial()) {
    _repository = repository ?? KiteRepository();
  }

  late final KiteRepository _repository;

  Future<void> load({required Category category}) async {
    emit(CategoryLoading());

    try {
      final content = await _repository.loadCategoryContent(category: category);
      emit(CategoryLoaded(content: content));
    } catch (e) {
      log('Error while loading category');
      log(e.toString());
      emit(CategoryError());
    }
  }
}
