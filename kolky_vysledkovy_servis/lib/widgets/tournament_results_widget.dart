import 'package:flutter/material.dart';

import '../assets/colors.dart';
import '../assets/other_assets.dart';
import 'other_widgets.dart';
import '../models/tournament_detail.dart';
import 'lanes_widget.dart';

class TournamentResultsWidget extends StatelessWidget {
  final List<Result> results;
  const TournamentResultsWidget({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    results.sort(((a, b) => a.playerOrder!.compareTo(b.playerOrder!)));

    List<Widget> children = [];

    for (Result result in results) {
      children.add(OneTournamentResult(
        result: result,
      ));
      children.add(const Divider());
    }

    children.removeLast();

    return Column(
      children: children,
    );
  }
}

class OneTournamentResult extends StatefulWidget {
  final Result result;

  const OneTournamentResult({super.key, required this.result});

  @override
  State<StatefulWidget> createState() => OneTournamentResultState();
}

class OneTournamentResultState extends State<OneTournamentResult> {
  late bool isExpanded;

  double spaceHeight = 10;

  @override
  void initState() {
    super.initState();
    isExpanded = false;
  }

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
                width: 50,
                child: Text(
                  "${widget.result.playerOrder! + 1}.",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .apply(color: secondaryColor),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                "${widget.result.player!.firstName} ${widget.result.player!.lastName}",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          SizedBox(
            height: assetsPadding / 4,
          ),
          Stack(children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomBoxHorizontal(text: "", style: smallStyle),
                    CustomBoxHorizontal(text: "Plné", style: smallStyle),
                    CustomBoxHorizontal(text: "Dor", style: smallStyle),
                    CustomBoxHorizontal(text: "CH", style: smallStyle),
                    CustomBoxHorizontal(text: "SUM", style: boldStyle),
                    CustomBoxHorizontal(text: "S.B.", style: smallStyle),
                    CustomBoxHorizontal(text: "Body", style: boldStyle),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomBoxHorizontal(text: "", style: smallStyle),
                    CustomBoxHorizontal(
                        text: widget.result.full.toString(), style: smallStyle),
                    CustomBoxHorizontal(
                        text: widget.result.clean.toString(),
                        style: smallStyle),
                    CustomBoxHorizontal(
                        text: widget.result.faults.toString(),
                        style: smallStyle),
                    CustomBoxHorizontal(
                        text: widget.result.total.toString(), style: boldStyle),
                    CustomBoxHorizontal(
                        text: widget.result.setPoints.toString(),
                        style: smallStyle),
                    CustomBoxHorizontal(
                        text: widget.result.points.toString(),
                        style: boldStyle),
                  ],
                ),
              ],
            ),
            Positioned(
              left: 12,
              bottom: 6,
              child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => {
                        setState(
                          () => isExpanded = !isExpanded,
                        )
                      },
                  icon: Icon(
                      color: primaryColor,
                      isExpanded
                          ? Icons.arrow_drop_up_outlined
                          : Icons.arrow_drop_down_outlined)),
            )
          ]),
          isExpanded
              ? Column(
                  children: [
                    const Divider(),
                    AllLanesHorizontal(
                        spaceHeight: spaceHeight,
                        smallStyle: smallStyle,
                        boldStyle: boldStyle,
                        lanes: widget.result.lanes!)
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
