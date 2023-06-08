import 'package:flutter/material.dart';

import '../models/league.dart';
import '../models/tournament.dart';
import '../screens/league_detail_page.dart';
import '../screens/tournament_detail_page.dart';

double _leftPadding = 20.0;

List<Widget> getLeagueTiles(BuildContext context, List<League> leagues) {
  leagues.sort(((a, b) {
    int cmp = a.category!.rank.compareTo(b.category!.rank);
    if (cmp != 0) return cmp;
    return a.id.compareTo(b.id);
  }));

  Map<int, int> categoryCount = {};
  for (League league in leagues) {
    categoryCount.putIfAbsent(league.categoryId, () => 0);
    categoryCount.update(league.categoryId, (value) => value + 1);
  }

  List<Widget> tiles = [];
  for (int i = 0; i < leagues.length; i++) {
    if (categoryCount[leagues[i].categoryId] == 1) {
      tiles.add(addLeagueListTile(leagues[i].name, leagues[i].id, context));
    } else {
      var j = i;
      List<Widget> tilesToAdd = [];
      while (categoryCount[leagues[j].categoryId]! > 0) {
        tilesToAdd
            .add(addLeagueListTile(leagues[i].name, leagues[i].id, context));
        categoryCount.update(leagues[j].categoryId, (value) => value - 1);
        i++;
      }
      i--;
      tiles.add(
        Padding(
          padding: EdgeInsets.only(left: _leftPadding),
          child: ExpansionTile(
            title: Text(leagues[j].category!.name),
            children: tilesToAdd,
          ),
        ),
      );
    }
  }
  return tiles;
}

Widget addLeagueListTile(
    String leagueName, int leagueId, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(left: _leftPadding),
    child: ListTile(
      title: Text(leagueName),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LeaguePage(
                leagueId: leagueId,
              ))),
    ),
  );
}

List<Widget> getTournamentTiles(
    BuildContext context, List<Tournament> tournaments) {
  tournaments.sort(((a, b) {
    int cmp = a.tournamentGroupId!.compareTo(b.tournamentGroupId!);
    if (cmp != 0) return cmp;
    return a.name!.compareTo(b.name!);
  }));

  Map<int, int> categoryCount = {};
  for (Tournament tournament in tournaments) {
    categoryCount.putIfAbsent(tournament.tournamentGroupId!, () => 0);
    categoryCount.update(tournament.tournamentGroupId!, (value) => value + 1);
  }

  List<Widget> tiles = [];
  for (int i = 0; i < tournaments.length; i++) {
    if (categoryCount[tournaments[i].tournamentGroupId] == 1) {
      tiles.add(addTournamentListTile(
          tournaments[i].name!, tournaments[i].id!, context));
    } else {
      var j = i;
      List<Widget> tilesToAdd = [];
      while (categoryCount[tournaments[j].tournamentGroupId]! > 0) {
        tilesToAdd.add(addTournamentListTile(
            tournaments[i].name!, tournaments[i].id!, context));
        categoryCount.update(
            tournaments[j].tournamentGroupId!, (value) => value - 1);
        i++;
      }
      i--;
      tiles.add(
        Padding(
          padding: EdgeInsets.only(left: _leftPadding),
          child: ExpansionTile(
            title: Text(tournaments[j].tournamentGroup!.name!),
            children: tilesToAdd,
          ),
        ),
      );
    }
  }
  return tiles;
}

Widget addTournamentListTile(
    String tournamentName, int tournamentId, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(left: _leftPadding),
    child: ListTile(
      title: Text(tournamentName),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TournamentPage(
                tournamentId: tournamentId,
              ))),
    ),
  );
}
