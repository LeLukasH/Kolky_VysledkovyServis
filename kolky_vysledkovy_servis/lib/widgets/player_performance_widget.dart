import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/all_assets.dart';
import 'package:kolky_vysledkovy_servis/all_models.dart';

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
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  OneLane(
                                      lineUp: widget.homeLineUp,
                                      style: smallStyle,
                                      lane: 1),
                                  SizedBox(
                                    width: spaceWidth,
                                  ),
                                  OneLane(
                                      lineUp: widget.homeLineUp,
                                      style: smallStyle,
                                      lane: 2),
                                  SizedBox(
                                    width: spaceWidth,
                                  ),
                                  OneLane(
                                      lineUp: widget.homeLineUp,
                                      style: smallStyle,
                                      lane: 3),
                                  SizedBox(
                                    width: spaceWidth,
                                  ),
                                  OneLane(
                                      lineUp: widget.homeLineUp,
                                      style: smallStyle,
                                      lane: 4),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      width: spaceWidth,
                    ),
                    Column(
                      children: [
                        CustomBox(
                            text: widget.homeLineUp.full.toString(),
                            style: mediumStyle),
                        CustomBox(
                            text: widget.homeLineUp.clean.toString(),
                            style: mediumStyle),
                        CustomBox(
                            text: widget.homeLineUp.faults.toString(),
                            style: mediumStyle),
                        CustomBox(
                            text: (widget.homeLineUp.clean +
                                    widget.homeLineUp.full)
                                .toString(),
                            style: mediumLabelStyle),
                        CustomBox(
                            text: widget.homeLineUp.setPoints.toString(),
                            style: mediumStyle),
                        CustomBox(
                            text: widget.homeLineUp.points.toString(),
                            style: mediumLabelStyle),
                        CustomBox(text: '', style: mediumLabelStyle),
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
                CustomBox(text: 'PLNÉ', style: smallStyle),
                CustomBox(text: 'DOR.', style: smallStyle),
                CustomBox(text: 'CHYBY', style: smallStyle),
                CustomBox(text: 'SUM', style: smallLabelStyle),
                CustomBox(text: 'S. B.', style: smallStyle),
                CustomBox(text: 'BODY', style: smallLabelStyle),
                CustomBox(text: '', style: smallStyle),
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
                        CustomBox(
                            text: widget.awayLineUp.full.toString(),
                            style: mediumStyle),
                        CustomBox(
                            text: widget.awayLineUp.clean.toString(),
                            style: mediumStyle),
                        CustomBox(
                            text: widget.awayLineUp.faults.toString(),
                            style: mediumStyle),
                        CustomBox(
                            text: (widget.awayLineUp.clean +
                                    widget.awayLineUp.full)
                                .toString(),
                            style: mediumLabelStyle),
                        CustomBox(
                            text: widget.awayLineUp.setPoints.toString(),
                            style: mediumStyle),
                        CustomBox(
                            text: widget.awayLineUp.points.toString(),
                            style: mediumLabelStyle),
                        CustomBox(text: '', style: mediumLabelStyle),
                      ],
                    ),
                    SizedBox(
                      width: spaceWidth,
                    ),
                    awayExpanded
                        ? Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  OneLane(
                                      lineUp: widget.awayLineUp,
                                      style: smallStyle,
                                      lane: 1),
                                  SizedBox(
                                    width: spaceWidth,
                                  ),
                                  OneLane(
                                      lineUp: widget.awayLineUp,
                                      style: smallStyle,
                                      lane: 2),
                                  SizedBox(
                                    width: spaceWidth,
                                  ),
                                  OneLane(
                                      lineUp: widget.awayLineUp,
                                      style: smallStyle,
                                      lane: 3),
                                  SizedBox(
                                    width: spaceWidth,
                                  ),
                                  OneLane(
                                      lineUp: widget.awayLineUp,
                                      style: smallStyle,
                                      lane: 4),
                                ],
                              ),
                            ),
                          )
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

class OneLane extends StatelessWidget {
  final LineUp lineUp;
  final TextStyle? style;
  final int lane;

  const OneLane(
      {super.key,
      required this.lineUp,
      required this.style,
      required this.lane});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBox(text: lineUp.lanes[lane - 1].full.toString(), style: style),
        CustomBox(text: lineUp.lanes[lane - 1].clean.toString(), style: style),
        CustomBox(text: lineUp.lanes[lane - 1].faults.toString(), style: style),
        CustomBox(
            text: (lineUp.lanes[lane - 1].clean + lineUp.lanes[lane - 1].full)
                .toString(),
            style: style),
        CustomBox(text: lineUp.lanes[lane - 1].points.toString(), style: style),
        CustomBox(text: '-', style: style),
        CustomBox(text: '$lane.', style: style),
      ],
    );
  }
}
