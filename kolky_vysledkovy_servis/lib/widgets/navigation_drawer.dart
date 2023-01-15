import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/all_models.dart';
import '../all_assets.dart';
import '../all_screens.dart';
import 'package:unicons/unicons.dart';

// ignore: must_be_immutable
class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key? key}) : super(key: key);

  final double _leftPadding = 20.0;

  int lastSeasonId = -1;

  Future<int> getLastSeasonId() async {
    if (lastSeasonId == -1) {
      var seasons = await dao.getSeasons();
      lastSeasonId = seasons.first.id;
    }
    return lastSeasonId;
  }

  Future<List<League>> getListOfLeagues() async {
    int lastSeasonId = await getLastSeasonId();
    var leagues = await dao.getLeagues(lastSeasonId);
    return leagues;
  }

  Future<List<Tournament>> getListOfTournaments() async {
    int lastSeasonId = await getLastSeasonId();
    var tournaments = await dao.getTournaments(
        ["tournamentGroup", "tournamentGroup.parentTournamentGroup"],
        lastSeasonId);
    return tournaments;
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
          'assets/images/logo200x200.png',
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
                      leading: const Icon(UniconsLine.bowling_ball),
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
                    leading: Icon(UniconsLine.bowling_ball),
                    title: Text('Ligy'),
                    children: [Center(child: CircularProgressIndicator())]);
              },
            ),
            FutureBuilder(
              future: getListOfTournaments(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ExpansionTile(
                      leading: const Icon(UniconsLine.trophy),
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
                    leading: Icon(UniconsLine.trophy),
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
