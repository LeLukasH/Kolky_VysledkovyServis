import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../assets/colors.dart';
import '../assets/other_assets.dart';
import '../widgets/other_widgets.dart';
import '../models/table_of_round.dart';

class FullLeagueTablePage extends StatefulWidget {
  const FullLeagueTablePage(
      {super.key, required this.leagueId, required this.round});

  final int leagueId;
  final int round;

  @override
  State<StatefulWidget> createState() => _FullLeagueTablePageState();
}

class _FullLeagueTablePageState extends State<FullLeagueTablePage> {
  String type = "total";
  final List<DropdownMenuItem> items = const [
    DropdownMenuItem(value: "total", child: Text("Celkom")),
    DropdownMenuItem(value: "home", child: Text("Doma")),
    DropdownMenuItem(value: "away", child: Text("Vonku"))
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
        title: const Text('Tabuľka'),
        actions: [
          DropdownButton(
              items: items,
              value: type,
              onChanged: ((value) {
                setState(() {
                  type = value;
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
              future: dao.getTable([], widget.leagueId, widget.round, type),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FullLeagueTableWidget(
                      tableRows: snapshot.requireData.tableOfRoundRows);
                } else if (snapshot.hasError) {
                  return const Text("Error");
                }
                return const Center(child: CircularProgressIndicator());
              },
            ))),
      ),
    );
  }
}

class FullLeagueTableWidget extends StatefulWidget {
  final List<TableOfRoundRow> tableRows;
  const FullLeagueTableWidget({super.key, required this.tableRows});

  @override
  State<StatefulWidget> createState() => _FullLeagueTableWidgetState();
}

class _FullLeagueTableWidgetState extends State<FullLeagueTableWidget> {
  int? sortColumnIndex = 0;
  bool isAscending = false;

  final boldColumns = [1, 9];

  @override
  void initState() {
    super.initState();
  }

  List<DataColumn> getColumns() {
    return [
      DataColumn(
        label: const Text('#'),
        tooltip: "Poradie",
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.tableRows.sort((a, b) => !ascending
                ? a.order.compareTo(b.order)
                : b.order.compareTo(a.order));
          });
        },
      ),
      DataColumn(
        label: const Text('Klub'),
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.tableRows.sort((a, b) => !ascending
                ? a.teamName.compareTo(b.teamName)
                : b.teamName.compareTo(a.teamName));
          });
        },
      ),
      DataColumn(
        label: const Text('Z'),
        numeric: true,
        tooltip: "Zápasy",
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.tableRows.sort((a, b) => !ascending
                ? a.countableMatchCount.compareTo(b.countableMatchCount)
                : b.countableMatchCount.compareTo(a.countableMatchCount));
          });
        },
      ),
      DataColumn(
        label: const Text('V'),
        numeric: true,
        tooltip: "Výhry",
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.tableRows.sort((a, b) => !ascending
                ? a.wins.compareTo(b.wins)
                : b.wins.compareTo(a.wins));
          });
        },
      ),
      DataColumn(
        label: const Text('R'),
        numeric: true,
        tooltip: "Remízy",
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.tableRows.sort((a, b) => !ascending
                ? a.draws.compareTo(b.draws)
                : b.draws.compareTo(a.draws));
          });
        },
      ),
      DataColumn(
        label: const Text('P'),
        numeric: true,
        tooltip: "Prehry",
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.tableRows.sort((a, b) => !ascending
                ? a.loses.compareTo(b.loses)
                : b.loses.compareTo(a.loses));
          });
        },
      ),
      DataColumn(
        label: const Text('Skóre'),
        numeric: true,
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.tableRows.sort((a, b) => !ascending
                ? a.teamPoints.compareTo(b.teamPoints)
                : b.teamPoints.compareTo(a.teamPoints));
          });
        },
      ),
      DataColumn(
        label: const Text('Sety'),
        numeric: true,
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.tableRows.sort((a, b) => !ascending
                ? a.setPoints.compareTo(b.setPoints)
                : b.setPoints.compareTo(a.setPoints));
          });
        },
      ),
      DataColumn(
        label: const Text('Priemer'),
        numeric: true,
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.tableRows.sort((a, b) => !ascending
                ? a.total.compareTo(b.total)
                : b.total.compareTo(a.total));
          });
        },
      ),
      DataColumn(
        label: const Text('Body'),
        numeric: true,
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.tableRows.sort((a, b) => !ascending
                ? a.order.compareTo(b.order)
                : b.order.compareTo(a.order));
          });
        },
      ),
    ];
  }

  List<DataRow> getRows(List<TableOfRoundRow> rows) =>
      rows.map((TableOfRoundRow row) {
        final cells = [
          "${row.order}.",
          row.teamName,
          row.countableMatchCount,
          row.wins,
          row.draws,
          row.loses,
          "${row.teamPoints}:${row.againstTeamPoints}",
          "${row.setPoints}:${row.againstSetPoints}",
          row.total.round(),
          row.tablePoints
        ];
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
        columnSpacing: 2,
        sortAscending: isAscending,
        sortColumnIndex: sortColumnIndex,
        columns: getColumns(),
        rows: getRows(widget.tableRows),
      ),
    );
  }
}
