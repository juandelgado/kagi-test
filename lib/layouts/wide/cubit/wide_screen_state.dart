part of 'wide_screen_cubit.dart';

sealed class WideScreenState extends Equatable {
  const WideScreenState();

  @override
  List<Object> get props => [];
}

final class WideScreenInitial extends WideScreenState {}

// categories states
final class WideScreenCategoriesState extends WideScreenState {}

final class WideScreenCategoriesLoading extends WideScreenCategoriesState {}

final class WideScreenCategoriesLoaded extends WideScreenCategoriesState {
  WideScreenCategoriesLoaded({required this.categories});

  final List<Category> categories;

  @override
  List<Object> get props => [categories];
}

final class WideScreenCategoriesError extends WideScreenCategoriesState {}

// category states
final class WideScreenCategoryState extends WideScreenState {}

final class WideScreenCategoryLoading extends WideScreenCategoryState {}

final class WideScreenCategoryLoaded extends WideScreenCategoryState {
  WideScreenCategoryLoaded({
    required this.category,
    required this.content,
  });

  final Category category;
  final CategoryContent content;

  @override
  List<Object> get props => [category, content];
}

final class WideScreenCategoryError extends WideScreenCategoryState {
  WideScreenCategoryError({required this.category});

  final Category category;

  @override
  List<Object> get props => [category];
}

// article states
final class WideScreenArticleSelected extends WideScreenState {
  const WideScreenArticleSelected({required this.cluster});

  final Cluster cluster;

  @override
  List<Object> get props => [cluster];
}
