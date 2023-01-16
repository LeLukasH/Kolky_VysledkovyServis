import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/all_assets.dart';
import 'package:kolky_vysledkovy_servis/all_models.dart';
import 'package:kolky_vysledkovy_servis/all_screens.dart';

class MatchesWidget extends StatelessWidget {
  const MatchesWidget({super.key, required this.matches});

  final List<Match> matches;

  final double dividerHeight = 10.0;

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
            Text(
              match.homeName.length < teamNameLimit
                  ? match.homeName
                  : "${match.homeName.substring(0, teamNameLimit)}...",
              style: Theme.of(context).textTheme.labelMedium,
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
            Text(
              match.awayName.length < teamNameLimit
                  ? match.awayName
                  : "${match.awayName.substring(0, teamNameLimit)}...",
              style: Theme.of(context).textTheme.labelMedium,
            ),
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

    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MatchDetailPage(match: match),
        ),
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
