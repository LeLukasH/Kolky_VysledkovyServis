import 'package:flutter/material.dart';
import '../assets/expansion_tiles.dart';
import '../assets/other_assets.dart';
import 'package:unicons/unicons.dart';

import '../models/league.dart';
import '../models/tournament.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  final double _leftPadding = 20.0;

  Future<int> getLastSeasonId() async {
    var seasons = await dao.getSeasons();
    var lastSeasonId = seasons.first.id;
    return lastSeasonId;
  }

  Future<List<League>> getListOfLeagues(int lastSeasonId) async {
    var leagues = await dao.getLeagues(lastSeasonId);
    return leagues;
  }

  Future<List<Tournament>> getListOfTournaments(int lastSeasonId) async {
    var tournaments = await dao.getTournaments(lastSeasonId);
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
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Domov'),
                onTap: () => Navigator.pop(context)),
            FutureBuilder(
                future: getLastSeasonId(),
                builder: (context, snapshotId) {
                  if (snapshotId.hasData) {
                    return Column(
                      children: [
                        FutureBuilder(
                          future: getListOfLeagues(snapshotId.requireData),
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
                                            padding:
                                                EdgeInsets.all(_leftPadding),
                                            child: const Text(
                                                'V tejto sezóne nie sú...'),
                                          )
                                        ]);
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return const ExpansionTile(
                                leading: Icon(UniconsLine.bowling_ball),
                                title: Text('Ligy'),
                                children: [
                                  Center(child: CircularProgressIndicator())
                                ]);
                          },
                        ),
                        FutureBuilder(
                          future: getListOfTournaments(snapshotId.requireData),
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
                                            padding:
                                                EdgeInsets.all(_leftPadding),
                                            child: const Text(
                                                'V tejto sezóne nie sú...'),
                                          )
                                        ]);
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return const ExpansionTile(
                                leading: Icon(UniconsLine.trophy),
                                title: Text('Turnaje'),
                                children: [
                                  Center(child: CircularProgressIndicator())
                                ]);
                          },
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
            ListTile(
              leading: const Icon(Icons.history_outlined),
              title: const Text('Archív'),
              onTap: () => Navigator.of(context).pushNamed(
                '/archive',
              ),
            ),
            ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: const Text('Nastavenia'),
                onTap: () => Navigator.of(context).pushNamed('/settings'))
          ],
        ));
  }
}
