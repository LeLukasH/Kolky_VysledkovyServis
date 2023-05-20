import 'package:flutter/material.dart';
import '../assets/colors.dart';
import '../assets/other_assets.dart';
import 'other_widgets.dart';
import '../models/best_result.dart';
import '../screens/full_league_best_results_page.dart';

class BestResultsChooser extends StatefulWidget {
  const BestResultsChooser(
      {super.key, required this.leagueId, required this.round});

  final int leagueId;
  final int round;

  @override
  State<StatefulWidget> createState() => _BestResultsChooserState();
}

class _BestResultsChooserState extends State<BestResultsChooser> {
  String type = "total";
  String tableType = "total";

  final List<DropdownMenuItem> items1 = const [
    DropdownMenuItem(value: "total", child: Text("Celkom")),
    DropdownMenuItem(value: "home", child: Text("Doma")),
    DropdownMenuItem(value: "away", child: Text("Vonku"))
  ];
  final List<DropdownMenuItem> items2 = const [
    DropdownMenuItem(value: "total", child: Text("Celkom")),
    DropdownMenuItem(value: "full", child: Text("Plné")),
    DropdownMenuItem(value: "clean", child: Text("Dorážka"))
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: assetsPadding / 2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const NameWidget(
                  icon: Icons.hdr_strong_outlined, name: 'Top Výkony'),
              Row(
                children: [
                  DropdownButton(
                      items: items2,
                      value: type,
                      style: Theme.of(context).textTheme.labelMedium,
                      onChanged: ((value) {
                        setState(() {
                          type = value;
                        });
                      })),
                  SizedBox(
                    width: assetsPadding / 4,
                  ),
                  DropdownButton(
                      items: items1,
                      value: tableType,
                      style: Theme.of(context).textTheme.labelMedium,
                      onChanged: ((value) {
                        setState(() {
                          tableType = value;
                        });
                      })),
                  IconButton(
                      icon: const Icon(Icons.exit_to_app_outlined),
                      color: secondaryColor,
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FullBestResultsPage(
                              leagueId: widget.leagueId,
                              round: widget.round,
                            ),
                          )))
                ],
              )
            ],
          ),
          CustomContainerWithOutPadding(
              child: FutureBuilder(
            future: dao.getBestResults(
                widget.leagueId, widget.round, type, tableType),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return BestResultsWidget(
                  bestResults: snapshot.requireData,
                  type: type,
                );
              } else if (snapshot.hasError) {
                return const Text("Error");
              }
              return const Center(child: CircularProgressIndicator());
            },
          ))
        ]));
  }
}

class BestResultsWidget extends StatefulWidget {
  final List<BestResult> bestResults;
  final String type;
  const BestResultsWidget(
      {super.key, required this.bestResults, required this.type});

  @override
  State<StatefulWidget> createState() => _BestResultsWidgetState();
}

class _BestResultsWidgetState extends State<BestResultsWidget> {
  final columns = ["#", "Hráč", "Tím", "Spolu"];
  final boldColumns = [1, 3];

  List<DataColumn> getColumns() => columns
      .map((column) => DataColumn(
          label: Text(column),
          numeric:
              columns.indexOf(column) == columns.length - 1 ? true : false))
      .toList();

  List<DataRow> getRows(List<BestResult> rows) =>
      rows.asMap().entries.map((entry) {
        int index = entry.key;
        BestResult row = entry.value;
        final cells = [
          "${index + 1}.",
          "${row.lastName} ${row.firstName}",
          row.teamName,
        ];
        if (widget.type == "clean") {
          cells.add("${row.clean} (${row.total})");
        } else if (widget.type == "full") {
          cells.add("${row.full} (${row.total})");
        } else {
          cells.add(row.total.toString());
        }
        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) {
    List<DataCell> list = [];
    for (int i = 0; i < cells.length; i++) {
      list.add(DataCell(Text(cells[i].toString(),
          style: boldColumns.contains(i)
              ? const TextStyle(fontWeight: FontWeight.bold)
              : const TextStyle())));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
        headingRowColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          return primaryColor.withOpacity(0.2);
        }),
        headingRowHeight: 50,
        horizontalMargin: 12,
        columnSpacing: 10,
        columns: getColumns(),
        rows: getRows(widget.bestResults),
      ),
    );
  }
}
