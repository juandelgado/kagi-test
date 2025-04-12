import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:juan_kite/layouts/narrow/categories/cubit/categories_cubit.dart';
import 'package:juan_kite/model/category.dart';
import 'package:juan_kite/theme/app_spacing.dart';
import 'package:juan_kite/widgets/categories/categories_loaded.dart';
import 'package:juan_kite/widgets/content_loading.dart';
import 'package:juan_kite/widgets/content_loading_error.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoriesCubit()..loadCategories(),
      lazy: false,
      child: CategoriesView(
        onCategorySelected: (category) => Beamer.of(context)
            .beamToNamed('/category', data: {'category': category}),
      ),
    );
  }
}

class CategoriesView extends StatelessWidget {
  const CategoriesView({required this.onCategorySelected, super.key});

  final ValueChanged<Category> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    // this is a bit heavy handed because the whole tree
    // will get redrawn on any state change, but we can
    // probably live with it since performance is unlikely critical here
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: AppSpacing.horizontalPaddingLg,
            child: Builder(
              builder: (context) {
                switch (state.runtimeType) {
                  case CategoriesLoaded:
                    final categories = (state as CategoriesLoaded).categories;
                    return CategoriesLoadedWidget(
                      categories: categories,
                      onCategorySelected: onCategorySelected,
                    );
                  case CategoriesError:
                    return ContentLoadingErrorWidget(
                      retryOnPressed: () =>
                          context.read<CategoriesCubit>().loadCategories(),
                    );
                  case CategoriesLoading:
                  case CategoriesInitial:
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
