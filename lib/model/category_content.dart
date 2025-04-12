import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:juan_kite/model/cluster.dart';

part 'category_content.g.dart';

@JsonSerializable(createToJson: false)
class CategoryContent with EquatableMixin {
  CategoryContent({
    required this.timestamp,
    required this.read,
    required this.clusters,
  });

  factory CategoryContent.fromJson(Map<String, dynamic> json) =>
      _$CategoryContentFromJson(json);

  final int timestamp;

  @JsonKey(fromJson: _readFromJson)
  final int read;

  final List<Cluster> clusters;

  static int _readFromJson(dynamic value) => value == null ? 0 : value as int;

  @override
  List<Object> get props => [timestamp, read, clusters];
}
