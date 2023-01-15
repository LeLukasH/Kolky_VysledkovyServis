import 'package:flutter/material.dart';
import 'package:kolky_vysledkovy_servis/all_assets.dart';
import 'package:kolky_vysledkovy_servis/all_models.dart';

class TableWidget extends StatefulWidget {
  final List<TableOfRoundRow> tableRows;
  const TableWidget({super.key, required this.tableRows});

  @override
  State<StatefulWidget> createState() => TableWidgetState();
}

class TableWidgetState extends State<TableWidget> {
  int? sortColumnIndex = 0;
  bool isAscending = false;

  final boldColumns = [1, 6];

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
        label: const Text('B'),
        numeric: true,
        tooltip: "Body",
        onSort: (int columnIndex, bool ascending) {
          setState(() {
            isAscending = ascending;
            sortColumnIndex = columnIndex;
            widget.tableRows.sort((a, b) => !ascending
                ? a.tablePoints.compareTo(b.tablePoints)
                : b.tablePoints.compareTo(a.tablePoints));
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
    return DataTable(
      headingRowColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        return primaryColor.withOpacity(0.2);
      }),
      horizontalMargin: 12,
      columnSpacing: 2,
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(),
      rows: getRows(widget.tableRows),
    );
  }
}
