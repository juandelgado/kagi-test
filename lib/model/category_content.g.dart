// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryContent _$CategoryContentFromJson(Map<String, dynamic> json) =>
    CategoryContent(
      timestamp: (json['timestamp'] as num).toInt(),
      read: CategoryContent._readFromJson(json['read']),
      clusters: (json['clusters'] as List<dynamic>)
          .map((e) => Cluster.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
