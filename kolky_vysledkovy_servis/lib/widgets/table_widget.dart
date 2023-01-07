import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/all_assets.dart';
import 'package:kolky_vysledkovy_servis/all_models.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({super.key, required this.table, required this.showTable});

  final List<TableOfRoundRow> table;
  final bool showTable;

  final double dividerHeight = 10.0;
  final double boxWidth = 20;

  @override
  Widget build(BuildContext context) {
    table.sort(((a, b) => a.order.compareTo(b.order)));
    if (table.isEmpty || !showTable) return Container();
    List<Widget> tableRowWidgets = [];

    tableRowWidgets.add(FirstTableRowWidget(boxWidth: boxWidth));
    for (int i = 0; i < table.length; i++) {
      if (i != 0) {
        tableRowWidgets.add(Divider(
          height: dividerHeight,
        ));
      }
      tableRowWidgets.add(TableRowWidget(
        tableRow: table[i],
        boxWidth: boxWidth,
      ));
    }
    return Padding(
      padding: EdgeInsets.only(top: assetsPadding),
      child: CustomContainer(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const NameWidget(icon: Icons.table_rows_outlined, name: 'Tabuľka'),
          Column(
            children: tableRowWidgets,
          )
        ]),
      ),
    );
  }
}

class TableRowWidget extends StatelessWidget {
  const TableRowWidget(
      {super.key, required this.tableRow, required this.boxWidth});

  final TableOfRoundRow tableRow;

  final double boxWidth;

  final bool first = true;

  @override
  Widget build(BuildContext context) {
    Widget;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: boxWidth,
              child: Text(
                "${tableRow.order}.",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              tableRow.teamName.length < 25
                  ? tableRow.teamName
                  : "${tableRow.teamName.substring(0, 24)}...",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
        SizedBox(
          width: 6 * boxWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  width: boxWidth,
                  child: Text(
                    tableRow.countableMatchCount.toString(),
                    textAlign: TextAlign.center,
                  )),
              Row(
                children: [
                  SizedBox(
                      width: boxWidth,
                      child: Text(
                        tableRow.wins.toString(),
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                      width: boxWidth,
                      child: Text(
                        tableRow.draws.toString(),
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                      width: boxWidth,
                      child: Text(
                        tableRow.loses.toString(),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
              SizedBox(
                  width: boxWidth,
                  child: Text(tableRow.tablePoints.toString(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium)),
            ],
          ),
        )
      ],
    );
  }
}

class FirstTableRowWidget extends StatelessWidget {
  const FirstTableRowWidget({super.key, required this.boxWidth});

  final double boxWidth;
  final double fontSize = 16;
  final Color fontColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final style =
        Theme.of(context).textTheme.titleSmall!.apply(color: fontColor);
    return Padding(
      padding: EdgeInsets.only(bottom: assetsPadding / 4),
      child: Container(
        color: primaryColor,
        child: Padding(
          padding: EdgeInsets.only(
            top: assetsPadding / 4,
            bottom: assetsPadding / 4,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: boxWidth,
                    child: Text("#", textAlign: TextAlign.center, style: style),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text("Klub", textAlign: TextAlign.left, style: style),
                ],
              ),
              SizedBox(
                width: 6 * boxWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: boxWidth,
                        child: Text("Z",
                            textAlign: TextAlign.center, style: style)),
                    Row(
                      children: [
                        SizedBox(
                            width: boxWidth,
                            child: Text("V",
                                textAlign: TextAlign.center, style: style)),
                        SizedBox(
                            width: boxWidth,
                            child: Text("R",
                                textAlign: TextAlign.center, style: style)),
                        SizedBox(
                            width: boxWidth,
                            child: Text("P",
                                textAlign: TextAlign.center, style: style)),
                      ],
                    ),
                    SizedBox(
                        width: boxWidth,
                        child: Text("B",
                            textAlign: TextAlign.center, style: style)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
