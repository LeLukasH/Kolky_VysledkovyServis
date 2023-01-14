import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/DAO.dart';
import 'package:kolky_vysledkovy_servis/all_models.dart';
import '../all_screens.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key? key}) : super(key: key);

  final _dao = DAO();

  final double _leftPadding = 20.0;

  int lastSeasonId = -1;

  Future<int> getLastSeasonId() async {
    if (lastSeasonId == -1) {
      var seasons = await _dao.getSeasons();
      lastSeasonId = seasons.first.id;
    }
    return lastSeasonId;
  }

  Future<List<League>> getListOfLeagues() async {
    int lastSeasonId = await getLastSeasonId();
    var leagues = await _dao.getLeagues(lastSeasonId);
    return leagues;
  }

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

  Future<List<Tournament>> getListOfTournaments() async {
    int lastSeasonId = await getLastSeasonId();
    var tournaments = await _dao.getTournaments(
        ["tournamentGroup", "tournamentGroup.parentTournamentGroup"],
        lastSeasonId);
    return tournaments;
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
        tiles.add(addLeagueListTile(
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
      String tournamentName, int leagueId, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: _leftPadding),
      child: ListTile(
        title: Text(tournamentName),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TournamentPage(
                  tournamentId: leagueId,
                ))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Drawer(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ));

  Widget buildHeader(BuildContext context) => Container(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Image.asset(
          'images/logo200x200.png',
          height: 200,
        ),
      ));

  Widget buildMenuItems(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Domov'),
                onTap: () => Navigator.pop(context)),
            FutureBuilder(
              future: getListOfLeagues(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ExpansionTile(
                      leading: const Icon(Icons.sports_score_outlined),
                      title: const Text('Ligy'),
                      children: snapshot.requireData.isNotEmpty
                          ? getLeagueTiles(
                              context,
                              snapshot.requireData,
                            )
                          : [
                              Padding(
                                padding: EdgeInsets.all(_leftPadding),
                                child: const Text('V tejto sezóne nie sú...'),
                              )
                            ]);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const ExpansionTile(
                    leading: Icon(Icons.sports_score_outlined),
                    title: Text('Ligy'),
                    children: [Center(child: CircularProgressIndicator())]);
              },
            ),
            FutureBuilder(
              future: getListOfTournaments(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ExpansionTile(
                      leading: const Icon(Icons.sports_score_outlined),
                      title: const Text('Turnaje'),
                      children: snapshot.requireData.isNotEmpty
                          ? getTournamentTiles(
                              context,
                              snapshot.requireData,
                            )
                          : [
                              Padding(
                                padding: EdgeInsets.all(_leftPadding),
                                child: const Text('V tejto sezóne nie sú...'),
                              )
                            ]);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const ExpansionTile(
                    leading: Icon(Icons.sports_score_outlined),
                    title: Text('Turnaje'),
                    children: [Center(child: CircularProgressIndicator())]);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history_outlined),
              title: const Text('Archív'),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ArchivePage(),
              )),
            ),
            ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: const Text('Ostatné'),
                onTap: () => {})
          ],
        ));
  }
}
