import 'package:flutter/material.dart';
import 'package:juan_kite/extensions/l10n.dart';
import 'package:juan_kite/extensions/theme_extensions.dart';
import 'package:juan_kite/model/category.dart';
import 'package:juan_kite/theme/app_spacing.dart';
import 'package:juan_kite/widgets/app_buttons.dart';

class CategoriesLoadedWidget extends StatelessWidget {
  const CategoriesLoadedWidget({
    required this.categories,
    required this.onCategorySelected,
    super.key,
  });

  final List<Category> categories;
  final ValueChanged<Category> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: categories.length,
      separatorBuilder: (context, index) =>
          const Padding(padding: EdgeInsets.only(bottom: AppSpacing.sm)),
      itemBuilder: (context, index) {
        final category = categories[index];
        return CategoryListItem(
          category: category,
          onPressed: () => onCategorySelected(category),
        );
      },
    );
  }
}

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    required this.category,
    required this.onPressed,
    super.key,
  });

  final Category category;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = context.textTheme;
    return PrimaryTextButton(
      text: category.name,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            textStyle: WidgetStatePropertyAll(textTheme.headlineLarge),
          ),
      hint: l10n.categoriesGoToCategory(category.name),
      onPressed: onPressed,
    );
  }
}
