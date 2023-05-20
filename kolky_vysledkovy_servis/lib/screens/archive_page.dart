import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../assets/colors.dart';
import '../assets/expansion_tiles.dart';
import '../assets/other_assets.dart';
import '../widgets/other_widgets.dart';
import '../models/league.dart';
import '../models/season.dart';
import '../models/tournament.dart';

class ArchivePage extends StatelessWidget {
  const ArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Archív")),
      body: FutureBuilder(
        future: getLeaguesAndTournaments(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
                child: getArchivePage(snapshot.requireData, context));
          } else if (snapshot.hasError) {
            return const Text("Error");
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

Future<Map<Season, Tuple>> getLeaguesAndTournaments() async {
  Map<Season, Tuple> map = {};
  List<Season> seasons = await dao.getSeasons();
  for (Season season in seasons) {
    List<League> leagues = await dao.getLeagues(season.id);
    List<Tournament> tournaments = await dao.getTournaments(
        ["tournamentGroup", "tournamentGroup.parentTournamentGroup"],
        season.id);
    Tuple tuple = Tuple(item1: leagues, item2: tournaments);
    map.putIfAbsent(season, () => tuple);
  }
  return map;
}

Widget getArchivePage(Map<Season, Tuple> map, BuildContext context) {
  List<Widget> children = [];
  for (var entry in map.entries) {
    Season season = entry.key;
    List<League> leagues = entry.value.item1;
    List<Tournament> tournaments = entry.value.item2;

    Widget child = Column(
      children: [
        Text(
          season.name,
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .apply(color: secondaryColor),
        ),
        SizedBox(
          height: assetsPadding / 2,
        ),
        CustomContainer(
          child: Column(
            children: [
              ExpansionTile(
                  leading: const Icon(UniconsLine.bowling_ball),
                  title: const Text('Ligy'),
                  children: leagues.isNotEmpty
                      ? getLeagueTiles(
                          context,
                          leagues,
                        )
                      : [
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text('V tejto sezóne nie sú...'),
                          )
                        ]),
              ExpansionTile(
                  leading: const Icon(UniconsLine.trophy),
                  title: const Text('Turnaje'),
                  children: tournaments.isNotEmpty
                      ? getTournamentTiles(
                          context,
                          tournaments,
                        )
                      : [
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text('V tejto sezóne nie sú...'),
                          )
                        ]),
            ],
          ),
        ),
      ],
    );

    children.add(child);
    children.add(SizedBox(
      height: assetsPadding,
    ));
  }
  children.removeLast();
  return Padding(
    padding: EdgeInsets.all(assetsPadding),
    child: Column(
      children: children,
    ),
  );
}
