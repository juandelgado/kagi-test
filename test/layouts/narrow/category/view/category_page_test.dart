import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:juan_kite/layouts/narrow/category/cubit/category_cubit.dart';
import 'package:juan_kite/layouts/narrow/category/view/category_page.dart';
import 'package:juan_kite/model/category.dart';
import 'package:juan_kite/model/category_content.dart';
import 'package:juan_kite/model/cluster.dart';
import 'package:juan_kite/widgets/category/category_loaded_widget.dart';
import 'package:juan_kite/widgets/content_loading.dart';
import 'package:juan_kite/widgets/content_loading_error.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/a11y.dart';
import '../../../../helpers/pump_app.dart';

class _MockCategoryCubit extends MockCubit<CategoryState>
    implements CategoryCubit {}

void main() {
  group(CategoryPage, () {
    testWidgets('renders $CategoryView', (tester) async {
      await tester.pumpApp(
        CategoryPage(
          category: _mockCategory,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CategoryView), findsOneWidget);
      await tester.a11yCheck();
    });
  });

  group(CategoryView, () {
    late CategoryCubit mockCubit;

    setUpAll(() {
      mockCubit = _MockCategoryCubit();
    });

    testWidgets('renders loading widget for $CategoryInitial', (tester) async {
      when(() => mockCubit.state).thenReturn(CategoryInitial());

      await tester.pumpApp(
        BlocProvider.value(
          value: mockCubit,
          child: CategoryView(
            category: _mockCategory,
          ),
        ),
      );

      expect(find.byType(ContentLoadingWidget), findsOneWidget);
      await tester.a11yCheck();
    });

    testWidgets('renders loading widget for $CategoryLoading', (tester) async {
      when(() => mockCubit.state).thenReturn(CategoryLoading());

      await tester.pumpApp(
        BlocProvider.value(
          value: mockCubit,
          child: CategoryView(
            category: _mockCategory,
          ),
        ),
      );

      expect(find.byType(ContentLoadingWidget), findsOneWidget);
      await tester.a11yCheck();
    });

    testWidgets('renders error widget for $CategoryError', (tester) async {
      when(() => mockCubit.state).thenReturn(CategoryError());

      await tester.pumpApp(
        BlocProvider.value(
          value: mockCubit,
          child: CategoryView(
            category: _mockCategory,
          ),
        ),
      );

      expect(find.byType(ContentLoadingErrorWidget), findsOneWidget);
      await tester.a11yCheck();
    });

    testWidgets('renders content widget for $CategoryLoaded', (tester) async {
      when(() => mockCubit.state)
          .thenReturn(CategoryLoaded(content: _mockContent));

      await tester.pumpApp(
        BlocProvider.value(
          value: mockCubit,
          child: CategoryView(
            category: _mockCategory,
          ),
        ),
      );

      expect(find.byType(CategoryLoadedWidget), findsOneWidget);
      await tester.a11yCheck();
    });
  });
}

final _mockCategory = Category(name: 'spain', file: 'spain.json');

final _mockContent = CategoryContent(
  timestamp: 12345,
  read: 54321,
  clusters: [
    Cluster(
      title: 'another cluster',
      shortSummary: 'another short summary',
      talkingPoints: [],
      perspectives: [],
      timeline: [],
      articles: [],
    ),
  ],
);
