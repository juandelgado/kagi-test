import 'package:flutter/material.dart';
import 'package:juan_kite/extensions/l10n.dart';
import 'package:juan_kite/extensions/theme_extensions.dart';
import 'package:juan_kite/model/category_content.dart';
import 'package:juan_kite/model/cluster.dart';
import 'package:juan_kite/theme/app_spacing.dart';
import 'package:juan_kite/widgets/app_buttons.dart';
import 'package:juan_kite/widgets/top_bar.dart';

class CategoryLoadedWidget extends StatelessWidget {
  const CategoryLoadedWidget({
    required this.content,
    required this.title,
    required this.onArticleSelected,
    this.displayBackButton = true,
    super.key,
  });

  final CategoryContent content;
  final String title;
  final ValueChanged<Cluster> onArticleSelected;
  final bool displayBackButton;

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: Key(title),
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.lg),
          child: TopBar(
            title: title,
            displayBackButton: displayBackButton,
          ),
        ),
        for (final (index, cluster) in content.clusters.indexed)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: ClusterListItem(
              liveRegion: index == 0,
              cluster: cluster,
              onArticleSelected: onArticleSelected,
            ),
          ),
      ],
    );
  }
}

class ClusterListItem extends StatelessWidget {
  const ClusterListItem({
    required this.liveRegion,
    required this.cluster,
    required this.onArticleSelected,
    super.key,
  });

  final bool liveRegion;
  final Cluster cluster;
  final ValueChanged<Cluster> onArticleSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = context.textTheme;
    return PrimaryTextButton(
      liveRegion: liveRegion,
      text: cluster.title,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            textStyle: WidgetStatePropertyAll(textTheme.titleLarge),
          ),
      hint: l10n.goToCluster(cluster.title),
      onPressed: () => onArticleSelected(cluster),
    );
  }
}
