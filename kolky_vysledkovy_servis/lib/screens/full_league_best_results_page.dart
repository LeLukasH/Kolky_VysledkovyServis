import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolky_vysledkovy_servis/all_assets.dart';
import 'package:kolky_vysledkovy_servis/all_models.dart';

class FullBestResultsPage extends StatefulWidget {
  const FullBestResultsPage(
      {super.key, required this.leagueId, required this.round});

  final int leagueId;
  final int round;

  @override
  State<StatefulWidget> createState() => _FullBestResultsPageState();
}

class _FullBestResultsPageState extends State<FullBestResultsPage> {
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
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Top Výkony'),
          actions: [
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
            SizedBox(
              width: assetsPadding * 2,
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(assetsPadding),
                child: CustomContainerWithOutPadding(
                    child: FutureBuilder(
                  future: dao.getBestResults(
                      widget.leagueId, widget.round, type, tableType),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return FullBestResultsWidget(
                        bestResults: snapshot.requireData,
                        type: type,
                      );
                    } else if (snapshot.hasError) {
                      return const Text("Error");
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                )))));
  }
}

class FullBestResultsWidget extends StatefulWidget {
  final List<BestResult> bestResults;
  final String type;
  const FullBestResultsWidget(
      {super.key, required this.bestResults, required this.type});

  @override
  State<StatefulWidget> createState() => _FullBestResultsWidgetState();
}

class _FullBestResultsWidgetState extends State<FullBestResultsWidget> {
  final columns = ["#", "Hráč", "Tím", "Kolkáreň", "Spolu"];
  final boldColumns = [1, 4];

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
          row.hallName,
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
