import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/screens/homepage.dart';
import 'package:kolky_vysledkovy_servis/screens/match_detail_page.dart';
import 'models/match.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home':
        return platformPageRoute(builder: (_) => const HomePage());
      case '/match/detail':
        return platformPageRoute(
            builder: (_) =>
                MatchDetailPage(match: routeSettings.arguments as Match));
      case '/match/detail':
        return platformPageRoute(
            builder: (_) =>
                MatchDetailPage(match: routeSettings.arguments as Match));
    }
    return platformPageRoute(builder: (_) => const Scaffold());
  }

  static PageRoute platformPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    String? iosTitle,
  }) {
    if (Platform.isIOS) {
      return CupertinoPageRoute(
        builder: builder,
        settings: settings,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
        title: iosTitle,
      );
    } else {
      return MaterialPageRoute(
        builder: builder,
        settings: settings,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
      );
    }
  }
}
