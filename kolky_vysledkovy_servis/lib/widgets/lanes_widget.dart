import 'package:flutter/material.dart';

import 'other_widgets.dart';
import '../models/lane.dart';

class AllLanesVertical extends StatelessWidget {
  final List<Lane> lanes;

  final double spaceWidth;
  final TextStyle style;

  const AllLanesVertical(
      {super.key,
      required this.spaceWidth,
      required this.style,
      required this.lanes});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          OneLaneVertical(style: style, lane: lanes[0]),
          SizedBox(
            width: spaceWidth,
          ),
          OneLaneVertical(style: style, lane: lanes[1]),
          SizedBox(
            width: spaceWidth,
          ),
          OneLaneVertical(style: style, lane: lanes[2]),
          SizedBox(
            width: spaceWidth,
          ),
          OneLaneVertical(style: style, lane: lanes[3]),
        ],
      ),
    );
  }
}

class OneLaneVertical extends StatelessWidget {
  final Lane lane;
  final TextStyle? style;

  const OneLaneVertical({super.key, required this.style, required this.lane});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBoxVertical(text: lane.full.toString(), style: style),
        CustomBoxVertical(text: lane.clean.toString(), style: style),
        CustomBoxVertical(text: lane.faults.toString(), style: style),
        CustomBoxVertical(
            text: (lane.clean + lane.full).toString(), style: style),
        CustomBoxVertical(text: lane.points.toString(), style: style),
        CustomBoxVertical(text: '-', style: style),
        CustomBoxVertical(
            text: lane.lane != "" ? '${lane.lane}.' : '1.', style: style),
      ],
    );
  }
}

class AllLanesHorizontal extends StatelessWidget {
  final List<Lane> lanes;

  final double spaceHeight;
  final TextStyle? smallStyle;
  final TextStyle? boldStyle;

  const AllLanesHorizontal(
      {super.key,
      required this.spaceHeight,
      required this.lanes,
      this.smallStyle,
      this.boldStyle});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          OneLaneHorizontal(
              smallStyle: smallStyle, boldStyle: boldStyle, lane: lanes[0]),
          SizedBox(
            height: spaceHeight,
          ),
          OneLaneHorizontal(
              smallStyle: smallStyle, boldStyle: boldStyle, lane: lanes[1]),
          SizedBox(
            height: spaceHeight,
          ),
          OneLaneHorizontal(
              smallStyle: smallStyle, boldStyle: boldStyle, lane: lanes[2]),
          SizedBox(
            height: spaceHeight,
          ),
          OneLaneHorizontal(
              smallStyle: smallStyle, boldStyle: boldStyle, lane: lanes[3]),
        ],
      ),
    );
  }
}

class OneLaneHorizontal extends StatelessWidget {
  final Lane lane;
  final TextStyle? smallStyle;
  final TextStyle? boldStyle;

  const OneLaneHorizontal(
      {super.key, required this.lane, this.smallStyle, this.boldStyle});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomBoxHorizontal(text: '${lane.lane}.', style: smallStyle),
        CustomBoxHorizontal(text: lane.full.toString(), style: smallStyle),
        CustomBoxHorizontal(text: lane.clean.toString(), style: smallStyle),
        CustomBoxHorizontal(text: lane.faults.toString(), style: smallStyle),
        CustomBoxHorizontal(
            text: (lane.clean + lane.full).toString(), style: boldStyle),
        CustomBoxHorizontal(text: lane.points.toString(), style: smallStyle),
        CustomBoxHorizontal(text: '-', style: boldStyle),
      ],
    );
  }
}
