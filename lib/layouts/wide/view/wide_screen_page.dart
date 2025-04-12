import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juan_kite/extensions/l10n.dart';
import 'package:juan_kite/extensions/theme_extensions.dart';
import 'package:juan_kite/layouts/wide/cubit/wide_screen_cubit.dart';
import 'package:juan_kite/model/cluster.dart';
import 'package:juan_kite/theme/app_spacing.dart';
import 'package:juan_kite/widgets/article/article_view_widget.dart';
import 'package:juan_kite/widgets/categories/categories_loaded.dart';
import 'package:juan_kite/widgets/category/category_loaded_widget.dart';
import 'package:juan_kite/widgets/content_loading.dart';
import 'package:juan_kite/widgets/content_loading_error.dart';

class WideScreenPage extends StatelessWidget {
  const WideScreenPage({required this.constrains, super.key});

  final BoxConstraints constrains;

  @override
  Widget build(BuildContext context) {
    final columnWidth = (constrains.maxWidth - AppSpacing.lg * 2) / 3;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        child: Row(
          children: [
            BlocBuilder<WideScreenCubit, WideScreenState>(
              buildWhen: (previous, current) =>
                  current is WideScreenCategoriesState,
              builder: (context, state) {
                return Padding(
                  padding: AppSpacing.horizontalPaddingLg,
                  child: SizedBox(
                    width: columnWidth,
                    child: state is WideScreenInitial
                        ? const ContentLoadingWidget()
                        : CategoriesColumn(
                            state: state as WideScreenCategoriesState,
                          ),
                  ),
                );
              },
            ),
            BlocBuilder<WideScreenCubit, WideScreenState>(
              buildWhen: (previous, current) =>
                  current is WideScreenCategoryState,
              builder: (context, state) {
                return SizedBox(
                  width: columnWidth,
                  child: CategoryColumn(
                    state: state,
                  ),
                );
              },
            ),
            BlocBuilder<WideScreenCubit, WideScreenState>(
              buildWhen: (previous, current) =>
                  current is WideScreenArticleSelected,
              builder: (context, state) {
                Cluster? cluster;

                if (state is WideScreenArticleSelected) {
                  cluster = state.cluster;
                }

                return SizedBox(
                  width: columnWidth,
                  child: ArticleColumn(
                    cluster: cluster,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesColumn extends StatelessWidget {
  const CategoriesColumn({required this.state, super.key});

  final WideScreenCategoriesState state;

  @override
  Widget build(BuildContext context) {
    switch (state.runtimeType) {
      case WideScreenCategoriesLoaded:
        return CategoriesLoadedWidget(
          categories: (state as WideScreenCategoriesLoaded).categories,
          onCategorySelected: (category) =>
              context.read<WideScreenCubit>().loadCategory(category: category),
        );
      case WideScreenCategoriesError:
        return ContentLoadingErrorWidget(
          retryOnPressed: () =>
              context.read<WideScreenCubit>().loadCategories(),
        );
      case WideScreenCategoriesLoading:
      default:
        return const ContentLoadingWidget();
    }
  }
}

class CategoryColumn extends StatelessWidget {
  const CategoryColumn({required this.state, super.key});

  final WideScreenState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = context.textTheme;

    switch (state.runtimeType) {
      case WideScreenCategoryLoaded:
        return CategoryLoadedWidget(
          title: (state as WideScreenCategoryLoaded).category.name,
          content: (state as WideScreenCategoryLoaded).content,
          displayBackButton: false,
          onArticleSelected: (cluster) =>
              context.read<WideScreenCubit>().loadArticle(cluster: cluster),
        );
      case WideScreenCategoryError:
        return ContentLoadingErrorWidget(
          retryOnPressed: () => context.read<WideScreenCubit>().loadCategory(
                category: (state as WideScreenCategoryError).category,
              ),
        );
      case WideScreenCategoryLoading:
        return const ContentLoadingWidget();
      default:
        return Text(
          l10n.widePleaseSelectCategory,
          style: textTheme.headlineLarge,
        );
    }
  }
}

class ArticleColumn extends StatelessWidget {
  const ArticleColumn({super.key, this.cluster});

  final Cluster? cluster;

  @override
  Widget build(BuildContext context) {
    return cluster == null
        ? Container()
        : ArticleView(
            cluster: cluster!,
            displayTopBar: false,
          );
  }
}
