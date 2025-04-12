import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable(createToJson: false)
class Category with EquatableMixin {
  Category({required this.name, required this.file});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  final String name;
  final String file;

  @override
  List<Object> get props => [name, file];
}
