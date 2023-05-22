import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/screens/team_detail_page.dart';

import '../assets/colors.dart';
import '../assets/other_assets.dart';
import '../models/tournament_detail.dart';
import '../screens/player_detail_page.dart';
import 'other_widgets.dart';

class TournamentGroupResultsWidget extends StatelessWidget {
  final List<GroupResult> groupResults;
  const TournamentGroupResultsWidget({super.key, required this.groupResults});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    for (GroupResult result in groupResults) {
      children.add(OneTournamentGroupResult(
        groupResult: result,
        order: groupResults.indexOf(result),
      ));
      children.add(const Divider());
    }

    children.removeLast();

    return Column(
      children: children,
    );
  }
}

class OneTournamentGroupResult extends StatelessWidget {
  const OneTournamentGroupResult(
      {super.key, required this.groupResult, required this.order});

  final GroupResult groupResult;
  final int order;

  @override
  Widget build(BuildContext context) {
    TextStyle smallStyle = Theme.of(context).textTheme.bodySmall!;
    TextStyle boldStyle = Theme.of(context).textTheme.labelMedium!;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: assetsPadding / 4),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 40,
                child: Text(
                  "${order + 1}.",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .apply(color: secondaryColor),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextButton(
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PlayerDetailPage(
                                    player: groupResult.player!,
                                  ))),
                      text:
                          "${groupResult.player!.firstName} ${groupResult.player!.lastName}",
                      textAlign: TextAlign.start,
                      textStyle: Theme.of(context).textTheme.titleSmall!),
                  Text(
                    groupResult.club!.name,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: assetsPadding / 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(children: [
                Text(
                  "Plné",
                  style: smallStyle,
                ),
                Text(
                  groupResult.full.toString(),
                  style: smallStyle,
                )
              ]),
              Column(children: [
                Text(
                  "Dor.",
                  style: smallStyle,
                ),
                Text(
                  groupResult.clean.toString(),
                  style: smallStyle,
                )
              ]),
              Column(children: [
                Text(
                  "CH",
                  style: smallStyle,
                ),
                Text(
                  groupResult.faults.toString(),
                  style: smallStyle,
                )
              ]),
              Column(children: [
                Text(
                  "SUM",
                  style: boldStyle,
                ),
                Text(
                  groupResult.total.toString(),
                  style: boldStyle,
                )
              ]),
              Column(children: [
                Text(
                  "S.B.",
                  style: smallStyle,
                ),
                Text(
                  groupResult.setPoints.toString(),
                  style: smallStyle,
                )
              ]),
              Column(children: [
                Text(
                  "Body",
                  style: boldStyle,
                ),
                Text(
                  groupResult.points.toString(),
                  style: boldStyle,
                )
              ])
            ],
          ),
        ],
      ),
    );
  }
}
