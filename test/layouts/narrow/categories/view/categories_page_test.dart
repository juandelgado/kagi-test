import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:juan_kite/layouts/narrow/categories/cubit/categories_cubit.dart';
import 'package:juan_kite/layouts/narrow/categories/view/categories_page.dart';
import 'package:juan_kite/widgets/content_loading.dart';
import 'package:juan_kite/widgets/content_loading_error.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/a11y.dart';
import '../../../../helpers/pump_app.dart';

class _MockCategoriesCubit extends MockCubit<CategoriesState>
    implements CategoriesCubit {}

void main() {
  group(CategoriesPage, () {
    testWidgets('renders $CategoriesView', (tester) async {
      await tester.pumpApp(const CategoriesPage());
      await tester.pumpAndSettle();
      expect(find.byType(CategoriesView), findsOneWidget);
      await tester.a11yCheck();
    });
  });

  group(CategoriesView, () {
    late CategoriesCubit mockCubit;

    setUpAll(() {
      mockCubit = _MockCategoriesCubit();
    });

    testWidgets('renders loading widget for $CategoriesInitial',
        (tester) async {
      when(() => mockCubit.state).thenReturn(CategoriesInitial());

      await tester.pumpApp(
        BlocProvider.value(
          value: mockCubit,
          child: CategoriesView(
            onCategorySelected: (value) {},
          ),
        ),
      );

      expect(find.byType(ContentLoadingWidget), findsOneWidget);
      await tester.a11yCheck();
    });

    testWidgets('renders loading widget for $CategoriesLoading',
        (tester) async {
      when(() => mockCubit.state).thenReturn(CategoriesLoading());

      await tester.pumpApp(
        BlocProvider.value(
          value: mockCubit,
          child: CategoriesView(
            onCategorySelected: (value) {},
          ),
        ),
      );

      expect(find.byType(ContentLoadingWidget), findsOneWidget);
      await tester.a11yCheck();
    });

    testWidgets('renders error widget for $CategoriesError', (tester) async {
      when(() => mockCubit.state).thenReturn(CategoriesError());

      await tester.pumpApp(
        BlocProvider.value(
          value: mockCubit,
          child: CategoriesView(
            onCategorySelected: (value) {},
          ),
        ),
      );

      expect(find.byType(ContentLoadingErrorWidget), findsOneWidget);
      await tester.a11yCheck();
    });
  });
}
