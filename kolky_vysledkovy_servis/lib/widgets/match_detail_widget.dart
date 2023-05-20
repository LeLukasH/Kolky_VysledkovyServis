import 'package:flutter/material.dart';

import '../assets/converters.dart';
import '../assets/other_assets.dart';
import '../models/match_detail.dart';
import '../models/status.dart';
import '../models/match.dart';

class MatchDetailWidget extends StatelessWidget {
  final Match match;
  final MatchDetail? matchDetail;

  const MatchDetailWidget({super.key, required this.match, this.matchDetail});

  final double ratio = 0.3;

  @override
  Widget build(BuildContext context) {
    final bool finished =
        match.status == Status.FINISHED || match.status == Status.INPROGRESS;
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
              Text(match.hallName!),
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
                      match.homeName!,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * ratio,
                    child: Text(
                      match.awayName!,
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
