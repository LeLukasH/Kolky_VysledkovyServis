import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/all_models.dart';
import 'package:kolky_vysledkovy_servis/screens/archive_page.dart';
import 'package:kolky_vysledkovy_servis/screens/full_league_best_results_page.dart';
import 'package:kolky_vysledkovy_servis/screens/full_league_individuals_page.dart';
import 'package:kolky_vysledkovy_servis/screens/full_league_table_page.dart';
import 'package:kolky_vysledkovy_servis/screens/homepage.dart';
import 'package:kolky_vysledkovy_servis/screens/league_page.dart';
import 'package:kolky_vysledkovy_servis/screens/match_detail_page.dart';
import 'package:kolky_vysledkovy_servis/screens/player_detail_page.dart';
import 'package:kolky_vysledkovy_servis/screens/team_detail_page.dart';
import 'package:kolky_vysledkovy_servis/screens/tournament_page.dart';
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
      case '/league/detail':
        var map = routeSettings.arguments as Map?;
        if (map?.containsKey('leagueId') == true) {
          if (map?.containsKey('initialIndex') == true) {
            return platformPageRoute(
              builder: (_) => LeaguePage(
                leagueId: map!['leagueId'],
                initialIndex: map['initialIndex'],
              ),
            );
          } else {
            return platformPageRoute(
              builder: (_) => LeaguePage(
                leagueId: map!['leagueId'],
              ),
            );
          }
        }
        break;
      case '/archive':
        return platformPageRoute(
          builder: (_) => const ArchivePage(),
        );
      case '/player/detail':
        return platformPageRoute(
          builder: (_) => PlayerDetailPage(
            player: routeSettings.arguments as Player,
          ),
        );
      case '/team/detail':
        return platformPageRoute(
          builder: (_) => TeamDetailPage(
            teamId: routeSettings.arguments as int,
          ),
        );
      case '/tournament/detail':
        return platformPageRoute(
          builder: (_) => TournamentPage(
            tournamentId: routeSettings.arguments as int,
          ),
        );
      case '/tables/table':
        var map = routeSettings.arguments as Map?;
        if (map?.containsKey('leagueId') == true &&
            map?.containsKey('round') == true) {
          return platformPageRoute(
            builder: (_) => FullLeagueTablePage(
              leagueId: map!['leagueId'],
              round: map['round'],
            ),
          );
        }
        break;
      case '/tables/individuals':
        var map = routeSettings.arguments as Map?;
        if (map?.containsKey('leagueId') == true &&
            map?.containsKey('round') == true) {
          return platformPageRoute(
            builder: (_) => FullLeagueIndividualsPage(
              leagueId: map!['leagueId'],
              round: map['round'],
            ),
          );
        }
        break;
      case '/tables/best_results':
        var map = routeSettings.arguments as Map?;
        if (map?.containsKey('leagueId') == true &&
            map?.containsKey('round') == true) {
          return platformPageRoute(
            builder: (_) => FullBestResultsPage(
              leagueId: map!['leagueId'],
              round: map['round'],
            ),
          );
        }
    }
    return platformPageRoute(
        builder: (_) => const Scaffold(
              body: Text('Error'),
            ));
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
