import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/assets/all_assets.dart';
import 'package:kolky_vysledkovy_servis/models/match.dart';

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
    return CustomContainer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const NameWidget(icon: Icons.sports_outlined, name: 'Zápasy'),
        Column(
          children: matchWidgets,
        )
      ]),
    );
  }
}

class MatchWidget extends StatelessWidget {
  const MatchWidget({super.key, required this.match});

  final Match match;

  final double boxHeight = 45.0;

  @override
  Widget build(BuildContext context) {
    Column left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            SizedBox(
                height: assetsPadding,
                width: assetsPadding,
                child: Image.network(match.homeClubPhoto)),
            const SizedBox(
              width: 5,
            ),
            Text(
              match.homeName,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
                height: assetsPadding,
                width: assetsPadding,
                child: Image.network(match.awayClubPhoto)),
            const SizedBox(
              width: 5,
            ),
            Text(
              match.awayName,
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
    } else if (match.status == Status.FINISHED) {
      right = Row(
        children: [
          match.videoUrl != "" && match.videoUrl != null
              ? const Icon(
                  Icons.videocam_outlined,
                  color: secondaryColor,
                )
              : Container(),
          SizedBox(
            width: assetsPadding / 2,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
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
    return SizedBox(
      height: boxHeight,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            left,
            right,
          ]),
    );
  }
}
