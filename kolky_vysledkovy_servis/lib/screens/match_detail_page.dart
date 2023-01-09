import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/all_assets.dart';
import 'package:kolky_vysledkovy_servis/all_models.dart';
import 'package:kolky_vysledkovy_servis/all_screens.dart';
import 'package:kolky_vysledkovy_servis/all_widgets.dart';

import '../DAO.dart';

class MatchDetailPage extends StatelessWidget {
  final Match match;
  final _dao = DAO();

  MatchDetailPage({super.key, required this.match});
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
                          name: match.leagueName,
                          initialIndex: match.round - 1,
                        ))),
                child: Padding(
                  padding: EdgeInsets.only(right: assetsPadding),
                  child: Text(
                    '${match.round}. kolo\n${match.leagueName.length < 15 ? match.leagueName : "${match.leagueName.substring(0, 13)}..."}',
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
            future: _dao.getMatchDetail(match.id, [
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
    final bool finished = matchDetail.status == Status.FINISHED;
    return Padding(
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
        ],
      ),
    );
  }
}

class MatchDetailWidget extends StatelessWidget {
  final Match match;
  final MatchDetail? matchDetail;

  const MatchDetailWidget({super.key, required this.match, this.matchDetail});

  final double ratio = 0.3;

  @override
  Widget build(BuildContext context) {
    final bool finished = match.status == Status.FINISHED;
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(convertDateTime(match.startDate)),
              const SizedBox(
                height: 15,
                child: VerticalDivider(),
              ),
              Text(match.hallName),
            ],
          ),
        ),
        const Divider(
          height: 1,
        ),
        Stack(children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * ratio,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: assetsPadding,
                          vertical: assetsPadding / 2),
                      child: Image.network(match.homeClubPhoto),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * ratio,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: assetsPadding,
                          vertical: assetsPadding / 2),
                      child: Image.network(match.awayClubPhoto),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * ratio,
                    child: Text(
                      match.homeName,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * ratio,
                    child: Text(
                      match.awayName,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: finished
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'BODY',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '${match.homeTeamPoints} : ${match.awayTeamPoints}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'SPOLU',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '${match.homeTotal} : ${match.awayTotal}',
                          style: Theme.of(context).textTheme.labelMedium,
                        )
                      ],
                    )
                  : Container(),
            ),
          ),
        ]),
        finished
            ? Column(
                children: [
                  Divider(
                    height: assetsPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'SETY',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            '${match.homeSetPoints} : ${match.awaySetPoints}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'PLNÉ',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            '${match.homeFull} : ${match.awayFull}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'DORÁŽKA',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            '${match.homeClean} : ${match.awayClean}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'CHYBY',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            '${matchDetail!.teamResult.home!.faults} : ${matchDetail!.teamResult.away!.faults}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )
            : Container(),
      ],
    );
  }
}

class PlayersPerformanceWidget extends StatelessWidget {
  final MatchDetail matchDetail;
  const PlayersPerformanceWidget({super.key, required this.matchDetail});

  @override
  Widget build(BuildContext context) {
    List<Widget> homeColumnChildren = [];
    List<Widget> awayColumnChildren = [];

    for (LineUp lineUp in matchDetail.lineUp.home) {
      homeColumnChildren.add(onePlayerPerformance(lineUp));
      homeColumnChildren.add(SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        child: const Divider(),
      ));
    }
    homeColumnChildren.removeLast();
    for (LineUp lineUp in matchDetail.lineUp.away) {
      awayColumnChildren.add(onePlayerPerformance(lineUp));
      awayColumnChildren.add(SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        child: const Divider(),
      ));
    }
    awayColumnChildren.removeLast();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: homeColumnChildren,
        ),
        const VerticalDivider(),
        Column(children: awayColumnChildren),
      ],
    );
  }

  Widget onePlayerPerformance(LineUp lineUp) {
    return Container(
      color: Colors.red,
      child: SizedBox(
        height: 50,
        child: Text('sss'),
      ),
    );
  }
}
