import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cluster.g.dart';

@JsonSerializable(createToJson: false)
class Cluster with EquatableMixin {
  Cluster({
    required this.title,
    required this.shortSummary,
    required this.talkingPoints,
    required this.perspectives,
    required this.timeline,
    required this.articles,
  });

  factory Cluster.fromJson(Map<String, dynamic> json) =>
      _$ClusterFromJson(json);

  final String title;

  @JsonKey(name: 'short_summary')
  final String shortSummary;

  @JsonKey(name: 'talking_points')
  final List<String> talkingPoints;

  final List<Perspective> perspectives;

  @JsonKey(fromJson: _timeLineFromJson)
  final List<String> timeline;

  final List<Article> articles;

  static List<String> _timeLineFromJson(dynamic value) {
    if (value is String) return [];
    return (value as List<dynamic>).map((e) => e as String).toList();
  }

  @override
  List<Object> get props =>
      [title, shortSummary, talkingPoints, perspectives, timeline, articles];
}

@JsonSerializable(createToJson: false)
class Perspective with EquatableMixin {
  Perspective(this.sources, {required this.text});

  factory Perspective.fromJson(Map<String, dynamic> json) =>
      _$PerspectiveFromJson(json);

  final String text;
  final List<Source> sources;

  @override
  List<Object> get props => [text, sources];
}

@JsonSerializable(createToJson: false)
class Source with EquatableMixin {
  Source({required this.name, required this.url});

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  final String name;
  final String url;

  @override
  List<Object> get props => [name, url];
}

@JsonSerializable(createToJson: false)
class Article with EquatableMixin {
  Article({
    required this.title,
    required this.link,
    required this.domain,
    required this.date,
    required this.image,
    required this.imageCaption,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  final String title;
  final String link;
  final String domain;
  final String date;
  final String image;
  final String? imageCaption;

  @override
  List<Object?> get props => [title, link, domain, date, image, imageCaption];
}
