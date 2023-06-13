import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/models/player_results.dart';
import '../assets/colors.dart';
import '../assets/other_assets.dart';
import '../models/player.dart';
import 'other_widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PlayerDetailGeneralWidget extends StatelessWidget {
  final Player player;

  const PlayerDetailGeneralWidget({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(children: [
        TwoValuesRow(
          "Meno",
          "${player.firstName} ${player.lastName}",
          sizeFactor: 1.2,
        ),
        const Divider(),
        TwoValuesRow(
          "Aktuálny klub",
          player.club!.name,
          sizeFactor: 1.2,
        ),
        const Divider(),
        TwoValuesRow(
          "Vek",
          (DateTime.now().difference(player.birthday).inDays / 365)
              .floor()
              .toString(),
          sizeFactor: 1.2,
        ),
      ]),
    );
  }
}

class PlayerDetailSeasonWidget extends StatelessWidget {
  final int playerId;
  final int seasonId;

  const PlayerDetailSeasonWidget(
      {super.key, required this.playerId, required this.seasonId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dao.getPlayerResults(playerId, seasonId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return getPlayerDetailSeasonWidget(context, snapshot.requireData);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  Widget getPlayerDetailSeasonWidget(
      BuildContext context, PlayerResults playerResults) {
    List<ChartData> data = [];

    for (PlayerResult playerResult in playerResults.list) {
      data.add(ChartData(
          playerResult.total,
          playerResult.match.homeTeam!.name != playerResults.average.teamName
              ? playerResult.match.homeTeam!.name
              : playerResult.match.awayTeam!.name));
    }
    return Column(
      children: [
        CustomContainer(
            child: Column(
          children: [
            TwoValuesRow(
              "Tím",
              playerResults.average.teamName,
              textColor: primaryColor,
            ),
            const Divider(),
            TwoValuesRow(
              "Počet zápasov",
              playerResults.average.count.toString(),
              textColor: primaryColor,
            ),
            const Divider(),
            TwoValuesRow(
                "Top výkon",
                playerResults.list
                    .reduce((a, b) => a.total > b.total ? a : b)
                    .total
                    .toString(),
                textColor: primaryColor),
            const Divider(),
            const TwoValuesRow("Priemer", ""),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text("B."),
                    Text(playerResults.average.points.toString())
                  ],
                ),
                Column(
                  children: [
                    const Text("Plné."),
                    Text(playerResults.average.full.toStringAsFixed(1))
                  ],
                ),
                Column(
                  children: [
                    const Text("Dor."),
                    Text(playerResults.average.clean.toStringAsFixed(1))
                  ],
                ),
                Column(
                  children: [
                    const Text("Ch."),
                    Text(playerResults.average.faults.toString())
                  ],
                ),
                Column(
                  children: [
                    const Text("Ch.(Ø)"),
                    Text(playerResults.average.faultsAverage.toStringAsFixed(1))
                  ],
                ),
                Column(
                  children: [
                    const Text("SPOLU"),
                    Text(playerResults.average.total.toStringAsFixed(1))
                  ],
                ),
              ],
            )
          ],
        )),
        Padding(
          padding: EdgeInsets.only(top: assetsPadding),
          child: CustomContainerWithOutPadding(
            child: SizedBox(
              height: 200,
              child: SfCartesianChart(
                  title: ChartTitle(
                      text: 'Graf výkonov     ',
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(color: secondaryColor)
                          .apply(fontSizeFactor: 0.9),
                      alignment: ChartAlignment.far),
                  margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                  borderWidth: 0,
                  plotAreaBorderWidth: 0,
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    builder: (cdata, point, series, pointIndex, seriesIndex) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          'Tím: ${data[pointIndex].team}\nCelkom: ${data[pointIndex].total}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      );
                    },
                  ),
                  primaryYAxis: NumericAxis(
                    minimum: (data
                                .reduce((a, b) => a.total > b.total ? b : a)
                                .total ~/
                            100) *
                        100,
                    maximum: ((data
                                    .reduce((a, b) => a.total > b.total ? a : b)
                                    .total ~/
                                100) *
                            100) +
                        100.0,
                  ),
                  primaryXAxis: CategoryAxis(
                    isVisible: false,
                  ),
                  series: <ChartSeries>[
                    SplineAreaSeries<ChartData, String>(
                        dataSource: data,
                        xValueMapper: (ChartData data, i) =>
                            data.team + (i + 100).toString(),
                        yValueMapper: (ChartData data, i) => data.total,
                        gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              primaryColor.withAlpha(40)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                        splineType: SplineType.monotonic),
                    SplineSeries<ChartData, String>(
                        dataSource: data,
                        color: primaryColor,
                        markerSettings: const MarkerSettings(
                          isVisible: true,
                          width: 7,
                          height: 7,
                          borderColor: primaryColor,
                        ),
                        xValueMapper: (ChartData data, i) =>
                            data.team + (i + 100).toString(),
                        yValueMapper: (ChartData data, i) => data.total,
                        splineType: SplineType.monotonic,
                        enableTooltip: true),
                  ]),
            ),
          ),
        )
      ],
    );
  }
}

class ChartData {
  final String team;
  final int total;
  ChartData(this.total, this.team);
}

class TwoValuesRow extends StatelessWidget {
  final String left;
  final String right;
  final Color textColor;
  final double sizeFactor;

  const TwoValuesRow(this.left, this.right,
      {super.key, this.textColor = secondaryColor, this.sizeFactor = 1});

  @override
  Widget build(BuildContext context) {
    TextStyle? largeStyle = Theme.of(context)
        .textTheme
        .labelLarge!
        .apply(fontSizeFactor: sizeFactor);
    TextStyle? mediumStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .apply(color: textColor)
        .apply(fontSizeFactor: sizeFactor);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          left,
          style: mediumStyle,
        ),
        Text(
          right,
          style: largeStyle,
        )
      ],
    );
  }
}
