part of 'category_cubit.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryError extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  const CategoryLoaded({required this.content});

  final CategoryContent content;

  @override
  List<Object> get props => [content];
}
