// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cluster.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cluster _$ClusterFromJson(Map<String, dynamic> json) => Cluster(
      title: json['title'] as String,
      shortSummary: json['short_summary'] as String,
      talkingPoints: (json['talking_points'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      perspectives: (json['perspectives'] as List<dynamic>)
          .map((e) => Perspective.fromJson(e as Map<String, dynamic>))
          .toList(),
      timeline: Cluster._timeLineFromJson(json['timeline']),
      articles: (json['articles'] as List<dynamic>)
          .map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Perspective _$PerspectiveFromJson(Map<String, dynamic> json) => Perspective(
      (json['sources'] as List<dynamic>)
          .map((e) => Source.fromJson(e as Map<String, dynamic>))
          .toList(),
      text: json['text'] as String,
    );

Source _$SourceFromJson(Map<String, dynamic> json) => Source(
      name: json['name'] as String,
      url: json['url'] as String,
    );

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      title: json['title'] as String,
      link: json['link'] as String,
      domain: json['domain'] as String,
      date: json['date'] as String,
      image: json['image'] as String,
      imageCaption: json['imageCaption'] as String?,
    );
