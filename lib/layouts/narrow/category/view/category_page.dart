import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juan_kite/layouts/narrow/category/cubit/category_cubit.dart';
import 'package:juan_kite/model/category.dart';
import 'package:juan_kite/theme/app_spacing.dart';
import 'package:juan_kite/widgets/category/category_loaded_widget.dart';
import 'package:juan_kite/widgets/content_loading.dart';
import 'package:juan_kite/widgets/content_loading_error.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({required this.category, super.key});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit()..load(category: category),
      lazy: false,
      child: CategoryView(
        category: category,
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  const CategoryView({required this.category, super.key});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: AppSpacing.horizontalPaddingLg,
            child: Builder(
              builder: (context) {
                switch (state.runtimeType) {
                  case CategoryLoaded:
                    final content = (state as CategoryLoaded).content;
                    return CategoryLoadedWidget(
                      title: category.name,
                      content: content,
                      onArticleSelected: (article) =>
                          Beamer.of(context).beamToNamed(
                        '/category/article',
                        data: {'cluster': article, 'category': category},
                      ),
                    );
                  case CategoryError:
                    return ContentLoadingErrorWidget(
                      retryOnPressed: () => context
                          .read<CategoryCubit>()
                          .load(category: category),
                      backOnPressed: () => Navigator.of(context).pop(),
                    );
                  case CategoryLoading:
                  case CategoryInitial:
                  default:
                    return const ContentLoadingWidget();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
