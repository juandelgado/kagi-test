import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:juan_kite/app/app_routes.dart';
import 'package:juan_kite/l10n/arb/app_localizations.dart';
import 'package:juan_kite/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );

    return MaterialApp.router(
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
