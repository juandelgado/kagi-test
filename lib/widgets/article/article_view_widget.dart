import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:juan_kite/extensions/iterable.dart';
import 'package:juan_kite/extensions/l10n.dart';
import 'package:juan_kite/extensions/theme_extensions.dart';
import 'package:juan_kite/model/cluster.dart';
import 'package:juan_kite/theme/app_spacing.dart';
import 'package:juan_kite/widgets/app_buttons.dart';
import 'package:juan_kite/widgets/app_colored_box.dart';
import 'package:juan_kite/widgets/semantics/semantic_widget.dart';
import 'package:juan_kite/widgets/top_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({
    required this.cluster,
    this.displayTopBar = true,
    super.key,
  });

  final Cluster cluster;
  final bool displayTopBar;

  @override
  Widget build(BuildContext context) {
    final children = [
      if (displayTopBar) const TopBar(),
      TitleWidget(title: cluster.title),
      ImageWidget(
        articles: cluster.articles,
      ),
      SummaryWidget(
        summary: cluster.shortSummary,
      ),
      PerspectivesWidget(
        perspectives: cluster.perspectives,
      ),
      ArticlesWidget(articles: cluster.articles),
    ];

    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
      body: Padding(
        padding: AppSpacing.horizontalPaddingLg,
        child: ListView.separated(
          key: Key(cluster.title),
          itemBuilder: (context, index) => children[index],
          separatorBuilder: (context, index) => AppSpacing.verticalSpacerSm,
          itemCount: children.length,
        ),
      ),
    );
  }
}

// NOTE: putting it into a dedicated widget
// so we can later find it during testing
// not just by text, but also by type in order
// to avoid false positives (the title being repeated
// in the description, for example)
class TitleWidget extends StatelessWidget {
  const TitleWidget({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    return SemanticWidget(
      value: title,
      isLiveRegion: true,
      child: AppColoredBox(
        child: Text(
          title,
          style: textTheme.headlineLarge?.copyWith(color: colorScheme.primary),
        ),
      ),
    );
  }
}

// same as above, but mostly for consistency, because the possibilities of
// the entire summary appearing in a different piece of text are LOW!
class SummaryWidget extends StatelessWidget {
  const SummaryWidget({required this.summary, super.key});

  final String summary;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    return AppColoredBox(
      child: Text(
        summary,
        style: textTheme.bodyLarge?.copyWith(color: colorScheme.primary),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    required this.articles,
    super.key,
  });

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    final article =
        articles.firstWhereOrNull((article) => article.image.isNotEmpty);

    final imageUrl = article?.image;
    final imageDescription = article?.imageCaption;

    final l10n = context.l10n;

    return imageUrl == null
        ? Container()
        : SemanticWidget(
            value: imageDescription ?? l10n.noImageDescription,
            child: AppColoredBox(
              insets: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xs),
                child: CachedNetworkImage(
                  height: 200,
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
  }
}

class PerspectivesWidget extends StatelessWidget {
  const PerspectivesWidget({required this.perspectives, super.key});

  final List<Perspective> perspectives;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final l10n = context.l10n;

    return perspectives.isEmpty
        ? Container()
        : AppColoredBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: Text(
                    l10n.articlePerspectives,
                    style: textTheme.titleLarge
                        ?.copyWith(color: colorScheme.primary),
                  ),
                ),
                for (final (index, perspective) in perspectives.indexed)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.sm,
                      0,
                      0,
                      AppSpacing.sm,
                    ),
                    child: PerspectiveWidget(
                      index: index,
                      perspective: perspective,
                    ),
                  ),
              ],
            ),
          );
  }
}

class PerspectiveWidget extends StatelessWidget {
  const PerspectiveWidget({
    required this.perspective,
    required this.index,
    super.key,
  });

  final Perspective perspective;
  final int index;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final l10n = context.l10n;

    var colonIndex = perspective.text.indexOf(':');
    if (colonIndex < 0) colonIndex = 0;

    return SemanticWidget(
      // adding one to the index because most screen reader
      // users will likely prefer 1-based arrays!
      value: l10n.articlePerspective(index + 1, perspective.text),
      child: Text.rich(
        TextSpan(
          text: perspective.text.substring(0, colonIndex).toUpperCase(),
          style: textTheme.titleMedium?.copyWith(color: colorScheme.primary),
          children: [
            TextSpan(
              text: perspective.text.substring(colonIndex),
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.normal,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticlesWidget extends StatelessWidget {
  const ArticlesWidget({required this.articles, super.key});

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final l10n = context.l10n;

    return articles.isEmpty
        ? Container()
        : AppColoredBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: Text(
                    l10n.articleFurtherReading,
                    style: textTheme.titleLarge
                        ?.copyWith(color: colorScheme.primary),
                  ),
                ),
                for (final article in articles)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: ArticleWidget(
                      article: article,
                    ),
                  ),
              ],
            ),
          );
  }
}

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({required this.article, super.key});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;

    return PrimaryButton(
      style: const ButtonStyle(
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        ),
      ),
      hint: l10n.visitArticleHint(article.domain, article.title),
      onPressed: () => launchUrl(Uri.parse(article.link)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              '${article.title} / ${article.domain}',
              style:
                  textTheme.titleMedium?.copyWith(color: colorScheme.primary),
            ),
          ),
          const Icon(
            Icons.launch,
            size: 16,
          ),
        ],
      ),
    );
  }
}
