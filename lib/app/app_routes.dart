import 'package:beamer/beamer.dart';
import 'package:juan_kite/app/view/app_layout_switcher.dart';
import 'package:juan_kite/layouts/narrow/article/view/article_page.dart';
import 'package:juan_kite/layouts/narrow/category/view/category_page.dart';
import 'package:juan_kite/model/category.dart';
import 'package:juan_kite/model/cluster.dart';

final routerDelegate = BeamerDelegate(
  locationBuilder: RoutesLocationBuilder(
    routes: {
      '/': (context, state, data) => const AppLayoutSwitcher(),
      '/category': (context, state, data) {
        final category =
            (data! as Map<String, dynamic>)['category'] as Category;
        return CategoryPage(
          category: category,
        );
      },
      '/category/article': (context, state, data) {
        final cluster = (data! as Map<String, dynamic>)['cluster'] as Cluster;
        return ArticlePage(
          cluster: cluster,
        );
      },
    },
  ).call,
);
