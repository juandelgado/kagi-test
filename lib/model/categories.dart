import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:juan_kite/model/category.dart';

part 'categories.g.dart';

@JsonSerializable(createToJson: false)
class Categories with EquatableMixin {
  Categories({required this.timestamp, required this.categories});

  factory Categories.fromJson(Map<String, dynamic> json) =>
      _$CategoriesFromJson(json);

  final int timestamp;
  final List<Category> categories;

  @override
  List<Object> get props => [timestamp, categories];
}
