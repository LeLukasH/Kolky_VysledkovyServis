import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/all_assets.dart';
import 'package:kolky_vysledkovy_servis/all_models.dart';
import 'package:kolky_vysledkovy_servis/all_screens.dart';
import 'package:kolky_vysledkovy_servis/all_widgets.dart';
import 'package:kolky_vysledkovy_servis/widgets/ytb_player_widget.dart';

class MatchDetailPage extends StatelessWidget {
  final Match match;

  const MatchDetailPage({super.key, required this.match});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail zápasu'),
          actions: [
            TextButton(
                style: const ButtonStyle(alignment: Alignment.center),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LeaguePage(
                          leagueId: match.leagueId,
                          initialIndex: convertRoundToOrder(match.round) - 1,
                        ))),
                child: Padding(
                  padding: EdgeInsets.only(right: assetsPadding),
                  child: Text(
                    '${convertRoundToText(match.round)}\n${match.leagueName.length < 15 ? match.leagueName : "${match.leagueName.substring(0, 13)}..."}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: Colors.white),
                  ),
                )),
          ],
          titleTextStyle: Theme.of(context)
              .textTheme
              .titleLarge!
              .apply(color: Colors.white),
        ),
        body: FutureBuilder(
            future: dao.getMatchDetail(match.id, [
              "league",
              "details",
              "teams",
              "teams.club",
              "results",
              "results.lanes",
              "referee",
              "substitutions",
              "sprint",
              "hall"
            ]),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return getMatchDetailPage(context, snapshot.requireData);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }

  Widget getMatchDetailPage(BuildContext context, MatchDetail matchDetail) {
    final bool finished = matchDetail.status == Status.FINISHED ||
        matchDetail.status == Status.INPROGRESS;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(assetsPadding),
        child: Column(
          children: [
            CustomContainer(
                child: MatchDetailWidget(
              match: match,
              matchDetail: matchDetail,
            )),
            finished
                ? Padding(
                    padding: EdgeInsets.only(top: assetsPadding),
                    child: CustomContainer(
                        child:
                            PlayersPerformanceWidget(matchDetail: matchDetail)),
                  )
                : Container(),
            finished && matchDetail.sprints!.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(top: assetsPadding),
                    child: Column(
                      children: [
                        const NameWidget(
                            icon: Icons.hourglass_empty_outlined,
                            name: 'Šprinty'),
                        CustomContainer(
                          child: SprintsPerfformanceWidget(
                            sprints: matchDetail.sprints!,
                            homeTeamId: matchDetail.homeTeam.id,
                            awayTeamId: matchDetail.awayTeam.id,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            matchDetail.videoUrl != null && matchDetail.videoUrl != ""
                ? Padding(
                    padding: EdgeInsets.only(top: assetsPadding),
                    child: YoutubePlayerWidget(videoUrl: matchDetail.videoUrl),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
