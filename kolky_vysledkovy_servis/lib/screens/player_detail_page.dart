import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/widgets/other_widgets.dart';

import '../assets/other_assets.dart';
import '../models/player.dart';
import '../models/player_detail.dart';
import '../widgets/player_detail_widgets.dart';

class PlayerDetailPage extends StatelessWidget {
  final Player player;

  const PlayerDetailPage({super.key, required this.player});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail hráča'),
          titleTextStyle: Theme.of(context)
              .textTheme
              .titleLarge!
              .apply(color: Colors.white),
        ),
        body: FutureBuilder(
            future: dao.getPlayerDetail(player.id, [
              "player.club",
            ]),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return getPlayerDetailPage(context, snapshot.requireData);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }

  Widget getPlayerDetailPage(BuildContext context, PlayerDetail playerDetail) {
    List<Widget> children = [
      PlayerDetailGeneralWidget(player: playerDetail.player)
    ];

    List<PlayedClub> playedClubs = playerDetail.playedClubs;
    playedClubs.sort((a, b) => b.season.name.compareTo(a.season.name));

    for (PlayedClub playedClub in playedClubs) {
      children.add(Divider(
        height: assetsPadding * 2,
        thickness: 1.5,
      ));
      children.add(NameWidget(
          icon: Icons.timeline_outlined, name: playedClub.season.name));
      children.add(PlayerDetailSeasonWidget(
          playerId: player.id, seasonId: playedClub.season.id));
    }
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(assetsPadding),
        child: Column(children: children),
      ),
    );
  }
}
