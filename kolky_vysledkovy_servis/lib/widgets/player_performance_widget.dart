import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/all_assets.dart';
import 'package:kolky_vysledkovy_servis/all_models.dart';

import 'lanes_widget.dart';

class PlayersPerformanceWidget extends StatelessWidget {
  final MatchDetail matchDetail;
  const PlayersPerformanceWidget({super.key, required this.matchDetail});

  @override
  Widget build(BuildContext context) {
    List<LineUp> homeLineUps = matchDetail.lineUp.home;
    homeLineUps.sort((a, b) => a.playerOrder.compareTo(b.playerOrder));

    List<LineUp> awayLineUps = matchDetail.lineUp.away;
    awayLineUps.sort((a, b) => a.playerOrder.compareTo(b.playerOrder));

    List<Widget> children = [];

    for (int i = 0; i < matchDetail.lineUp.home.length; i++) {
      children.add(OnePlayerPerformance(
          homeLineUp: matchDetail.lineUp.home[i],
          awayLineUp: matchDetail.lineUp.away[i]));
      children.add(const Divider());
    }

    children.removeLast();

    return Column(
      children: children,
    );
  }
}

class OnePlayerPerformance extends StatefulWidget {
  const OnePlayerPerformance({
    super.key,
    required this.homeLineUp,
    required this.awayLineUp,
  });

  final LineUp homeLineUp;
  final LineUp awayLineUp;

  @override
  State<StatefulWidget> createState() => OnePlayerPerformanceState();
}

class OnePlayerPerformanceState extends State<OnePlayerPerformance> {
  late bool homeExpanded;
  late bool awayExpanded;

  double spaceWidth = 10;
  double widthBox = 20;
  double heightBox = 20;

  @override
  void initState() {
    super.initState();
    homeExpanded = false;
    awayExpanded = false;
  }

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
            Text(
              "${widget.homeLineUp.player.firstName} ${widget.homeLineUp.player.lastName}",
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.right,
            ),
            Text(
              "${widget.awayLineUp.player.firstName} ${widget.awayLineUp.player.lastName}",
              style: Theme.of(context).textTheme.labelLarge,
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
              child: Stack(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    homeExpanded
                        ? Expanded(
                            child: AllLanesVertical(
                                spaceWidth: spaceWidth,
                                style: smallStyle!,
                                lanes: widget.homeLineUp.lanes))
                        : Container(),
                    SizedBox(
                      width: spaceWidth,
                    ),
                    Column(
                      children: [
                        CustomBoxVertical(
                            text: widget.homeLineUp.full.toString(),
                            style: mediumStyle),
                        CustomBoxVertical(
                            text: widget.homeLineUp.clean.toString(),
                            style: mediumStyle),
                        CustomBoxVertical(
                            text: widget.homeLineUp.faults.toString(),
                            style: mediumStyle),
                        CustomBoxVertical(
                            text: (widget.homeLineUp.clean +
                                    widget.homeLineUp.full)
                                .toString(),
                            style: mediumLabelStyle),
                        CustomBoxVertical(
                            text: widget.homeLineUp.setPoints.toString(),
                            style: mediumStyle),
                        CustomBoxVertical(
                            text: widget.homeLineUp.points.toString(),
                            style: mediumLabelStyle),
                        CustomBoxVertical(text: '', style: mediumLabelStyle),
                      ],
                    ),
                  ],
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () => {
                              setState(
                                () => homeExpanded = !homeExpanded,
                              )
                            },
                        icon: Icon(
                            color: secondaryColor,
                            homeExpanded
                                ? Icons.arrow_right_outlined
                                : Icons.arrow_left_outlined))),
              ]),
            ),
            Column(
              children: [
                CustomBoxVertical(text: 'PLN??', style: smallStyle),
                CustomBoxVertical(text: 'DOR.', style: smallStyle),
                CustomBoxVertical(text: 'CHYBY', style: smallStyle),
                CustomBoxVertical(text: 'SUM', style: smallLabelStyle),
                CustomBoxVertical(text: 'S. B.', style: smallStyle),
                CustomBoxVertical(text: 'BODY', style: smallLabelStyle),
                CustomBoxVertical(text: '', style: smallStyle),
              ],
            ),
            SizedBox(
              width: columnWidth,
              child: Stack(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        CustomBoxVertical(
                            text: widget.awayLineUp.full.toString(),
                            style: mediumStyle),
                        CustomBoxVertical(
                            text: widget.awayLineUp.clean.toString(),
                            style: mediumStyle),
                        CustomBoxVertical(
                            text: widget.awayLineUp.faults.toString(),
                            style: mediumStyle),
                        CustomBoxVertical(
                            text: (widget.awayLineUp.clean +
                                    widget.awayLineUp.full)
                                .toString(),
                            style: mediumLabelStyle),
                        CustomBoxVertical(
                            text: widget.awayLineUp.setPoints.toString(),
                            style: mediumStyle),
                        CustomBoxVertical(
                            text: widget.awayLineUp.points.toString(),
                            style: mediumLabelStyle),
                        CustomBoxVertical(text: '', style: mediumLabelStyle),
                      ],
                    ),
                    SizedBox(
                      width: spaceWidth,
                    ),
                    awayExpanded
                        ? Expanded(
                            child: AllLanesVertical(
                                spaceWidth: spaceWidth,
                                style: smallStyle!,
                                lanes: widget.awayLineUp.lanes))
                        : Container(),
                  ],
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () => {
                              setState(
                                () => awayExpanded = !awayExpanded,
                              )
                            },
                        icon: Icon(
                            color: secondaryColor,
                            awayExpanded
                                ? Icons.arrow_left_outlined
                                : Icons.arrow_right_outlined))),
              ]),
            ),
          ],
        ),
      ],
    );
  }
}
