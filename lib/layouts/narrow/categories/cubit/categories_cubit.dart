import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:juan_kite/model/category.dart';
import 'package:juan_kite/repository/kite_repository.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({KiteRepository? repository}) : super(CategoriesInitial()) {
    _repository = repository ?? KiteRepository();
  }

  late final KiteRepository _repository;

  Future<void> loadCategories() async {
    emit(CategoriesLoading());

    try {
      final categories = await _repository.loadCategories();
      categories.sort(
        (a, b) => a.name.compareTo(b.name),
      );

      emit(CategoriesLoaded(categories: categories));
    } catch (_) {
      emit(CategoriesError());
    }
  }
}
