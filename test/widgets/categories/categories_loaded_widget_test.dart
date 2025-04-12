import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:juan_kite/layouts/narrow/categories/cubit/categories_cubit.dart';
import 'package:juan_kite/layouts/narrow/categories/view/categories_page.dart';
import 'package:juan_kite/model/category.dart';
import 'package:juan_kite/widgets/categories/categories_loaded.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/a11y.dart';
import '../../helpers/pump_app.dart';

class _MockCategoriesCubit extends MockCubit<CategoriesState>
    implements CategoriesCubit {}

void main() {
  group(CategoriesLoaded, () {
    late CategoriesCubit mockCubit;

    setUpAll(() {
      mockCubit = _MockCategoriesCubit();
    });

    testWidgets('renders loaded widget for $CategoriesLoaded', (tester) async {
      when(() => mockCubit.state)
          .thenReturn(CategoriesLoaded(categories: _mockCategories));

      await tester.pumpApp(
        BlocProvider.value(
          value: mockCubit,
          child: CategoriesView(
            onCategorySelected: (value) {},
          ),
        ),
      );

      expect(find.byType(CategoriesLoadedWidget), findsOneWidget);
      expect(find.byType(CategoryListItem), findsExactly(2));
      await tester.a11yCheck();
    });
  });
}

final _mockCategories = [
  Category(name: 'B category', file: 'b.json'),
  Category(name: 'A category', file: 'a.json'),
];
