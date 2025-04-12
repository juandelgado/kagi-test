import 'package:flutter/material.dart';
import 'package:juan_kite/model/cluster.dart';
import 'package:juan_kite/widgets/article/article_view_widget.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({required this.cluster, super.key});

  final Cluster cluster;

  @override
  Widget build(BuildContext context) {
    return ArticleView(
      cluster: cluster,
    );
  }
}
