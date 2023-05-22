import 'package:flutter/material.dart';

import '../assets/other_assets.dart';
import '../screens/player_detail_page.dart';
import 'other_widgets.dart';
import '../models/sprint.dart';

class SprintsPerfformanceWidget extends StatelessWidget {
  const SprintsPerfformanceWidget(
      {super.key,
      required this.sprints,
      required this.homeTeamId,
      required this.awayTeamId});

  final List<Sprint> sprints;

  final int homeTeamId;
  final int awayTeamId;

  List<Sprint> getSprintsByTeam(int teamId) {
    List<Sprint> list = [];
    for (Sprint sprint in sprints) {
      if (sprint.teamId == teamId) {
        list.add(sprint);
      }
    }
    list.sort(((a, b) => a.playerOrder!.compareTo(b.playerOrder!)));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    List<Sprint> homeSprints = getSprintsByTeam(homeTeamId);
    List<Sprint> awaySprints = getSprintsByTeam(awayTeamId);
    List<Widget> children = [];

    for (int i = 0; i < homeSprints.length; i++) {
      children.add(OneSprintPerformanceWidget(
        homeSprint: homeSprints[i],
        awaySprint: awaySprints[i],
      ));
      children.add(const Divider());
    }

    children.removeLast();

    return Column(
      children: children,
    );
  }
}

class OneSprintPerformanceWidget extends StatelessWidget {
  const OneSprintPerformanceWidget(
      {super.key, required this.homeSprint, required this.awaySprint});

  final Sprint homeSprint;
  final Sprint awaySprint;

  final double heightBox = 20;

  @override
  Widget build(BuildContext context) {
    double columnWidth =
        MediaQuery.of(context).size.width / 2 - assetsPadding * 3.5;

    TextStyle? smallStyle = Theme.of(context).textTheme.bodySmall;
    TextStyle? smallLabelStyle =
        Theme.of(context).textTheme.bodySmall!.apply(fontWeightDelta: 3);
    TextStyle? mediumStyle = Theme.of(context).textTheme.bodyMedium;
    TextStyle? mediumLabelStyle =
        Theme.of(context).textTheme.labelMedium!.apply(fontWeightDelta: 1);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PlayerDetailPage(
                        player: homeSprint.player!,
                      ))),
              text:
                  "${homeSprint.player!.firstName} ${homeSprint.player!.lastName}",
              textStyle: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(decoration: TextDecoration.underline),
              textAlign: TextAlign.right,
            ),
            CustomTextButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PlayerDetailPage(
                        player: awaySprint.player!,
                      ))),
              text:
                  "${awaySprint.player!.firstName} ${awaySprint.player!.lastName}",
              textStyle: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .apply(decoration: TextDecoration.underline),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        SizedBox(
          height: heightBox / 4,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: columnWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomBoxVertical(
                      text: homeSprint.set1.toString(), style: mediumStyle),
                  CustomBoxVertical(
                      text: homeSprint.set2.toString(), style: mediumStyle),
                  CustomBoxVertical(
                      text: homeSprint.suddenVictory.toString(),
                      style: mediumStyle),
                  CustomBoxVertical(
                      text: homeSprint.point.toString(),
                      style: mediumLabelStyle),
                ],
              ),
            ),
            Column(
              children: [
                CustomBoxVertical(text: 'SET 1', style: smallStyle),
                CustomBoxVertical(text: 'SET 2.', style: smallStyle),
                CustomBoxVertical(text: 'SV', style: smallStyle),
                CustomBoxVertical(text: 'BODY', style: smallLabelStyle),
              ],
            ),
            SizedBox(
              width: columnWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBoxVertical(
                      text: awaySprint.set1.toString(), style: mediumStyle),
                  CustomBoxVertical(
                      text: awaySprint.set2.toString(), style: mediumStyle),
                  CustomBoxVertical(
                      text: awaySprint.suddenVictory.toString(),
                      style: mediumStyle),
                  CustomBoxVertical(
                      text: awaySprint.point.toString(),
                      style: mediumLabelStyle),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
