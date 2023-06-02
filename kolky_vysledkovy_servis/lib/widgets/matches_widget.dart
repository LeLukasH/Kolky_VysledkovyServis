import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/screens/team_detail_page.dart';

import '../assets/colors.dart';
import '../assets/converters.dart';
import '../assets/other_assets.dart';
import '../models/match.dart';
import '../models/status.dart';
import '../screens/match_detail_page.dart';
import 'other_widgets.dart';

class MatchesWidget extends StatelessWidget {
  const MatchesWidget({super.key, required this.matches});

  final List<Match> matches;

  final double dividerHeight = 1.0;

  @override
  Widget build(BuildContext context) {
    List<Widget> matchWidgets = [];
    for (int i = 0; i < matches.length; i++) {
      if (i != 0) {
        matchWidgets.add(Divider(
          height: dividerHeight,
        ));
      }
      matchWidgets.add(MatchWidget(match: matches[i]));
    }
    return Column(
      children: matchWidgets,
    );
  }
}

class MatchWidget extends StatelessWidget {
  const MatchWidget({super.key, required this.match});

  final Match match;

  final double boxHeight = 60.0;

  final double logoScaleRatio = 1.2;
  final double logoPadding = 10;
  final int teamNameLimit = 22;

  @override
  Widget build(BuildContext context) {
    Column left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            SizedBox(
                height: assetsPadding * logoScaleRatio,
                width: assetsPadding * logoScaleRatio,
                child: Image.network(match.homeClubPhoto)),
            SizedBox(
              width: logoPadding * logoScaleRatio,
            ),
            CustomTextButton(
              onPressed: () => Navigator.of(context).pushNamed(
                '/team/detail',
                arguments: match.homeId,
              ),
              text: match.homeName!.length < teamNameLimit
                  ? match.homeName!
                  : "${match.homeName!.substring(0, teamNameLimit)}...",
              textStyle: Theme.of(context).textTheme.labelMedium!,
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
                height: assetsPadding * logoScaleRatio,
                width: assetsPadding * logoScaleRatio,
                child: Image.network(match.awayClubPhoto)),
            SizedBox(
              width: logoPadding * logoScaleRatio,
            ),
            CustomTextButton(
              onPressed: () => Navigator.of(context).pushNamed(
                '/team/detail',
                arguments: match.awayId,
              ),
              textStyle: Theme.of(context).textTheme.labelMedium!,
              text: match.awayName!.length < teamNameLimit
                  ? match.awayName!
                  : "${match.awayName!.substring(0, teamNameLimit)}...",
            )
          ],
        ),
      ],
    );
    Widget right;
    if (match.status == Status.NEW) {
      right = Text(
        convertDateTime(match.startDate),
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .apply(fontStyle: FontStyle.italic),
      );
    } else if (match.status == Status.FINISHED ||
        match.status == Status.INPROGRESS) {
      right = Row(
        children: [
          match.videoUrl != "" && match.videoUrl != null
              ? const Icon(
                  Icons.videocam_outlined,
                  color: secondaryColor,
                )
              : Container(),
          match.status == Status.INPROGRESS
              ? const Text(
                  "LIVE",
                  style: TextStyle(color: secondaryColor),
                )
              : Container(),
          SizedBox(
            width: assetsPadding / 2,
          ),
          SizedBox(
            width: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  match.homeTotal.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  match.awayTotal.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          SizedBox(
            width: assetsPadding,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                match.homeTeamPoints.toString(),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                match.awayTeamPoints.toString(),
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ],
      );
    } else {
      right = Container();
    }

    return TextButton(
      onPressed: () => Navigator.of(context).pushNamed(
        '/match/detail',
        arguments: match,
      ),
      child: SizedBox(
        height: boxHeight,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              left,
              right,
            ]),
      ),
    );
  }
}
